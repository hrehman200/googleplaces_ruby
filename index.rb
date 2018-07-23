require 'google_places'
require 'csv'

class GooglePlacesBusiness
   
   def initialize(apiKey)
      @apiKey = apiKey
   end
   
   def askForInput()
   	   while(true)
		   puts '----------------------------------'
		   puts 'Enter address (q to quit)'
		   @address = gets.chomp 
		   if(@address == 'q')
		       break;
		   end 
		   puts "Fetching place-id for #{@address}"
		   fetchPlaceIdOfBusiness()
       end
   end
   
   def fetchPlaceIdOfBusiness()
      @client = GooglePlaces::Client.new(@apiKey)
      @spots = @client.spots_by_query(@address)
      
      if @spots.length > 0
          CSV.open("file.csv", "a+") do |csv|
			  @spots.each { |x|  
				  csv << [x.name, x.place_id]
			  }
		  end
		  puts @spots.length.to_s + ' places found and written to csv'
	  else
	      puts 'No place id found for the mentioned place'
	  end
	  
   end
   
end

API_KEY = "XXXXX";

gpb = GooglePlacesBusiness.new(API_KEY)
gpb.askForInput()

