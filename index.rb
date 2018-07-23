require 'google_places'
require 'csv'

class GooglePlacesBusiness
   
   def initialize(apiKey)
      @apiKey = apiKey
   end
   
   def fetchPlaceIdOfBusiness()
      @client = GooglePlaces::Client.new(@apiKey)
      @spots = @client.spots_by_query('Aberfoyle Family Chiropractic, 32 Brock Road North, Guelph, ON, Canada')
      
      if @spots.length > 0
		  CSV.open("file.csv", "a+") do |csv|
			  @spots.each { |x|  
				  csv << [x.name, x.place_id]
			  }
	  else
	      puts 'No place id found for the mentioned place'
	  end
   end
   
end

API_KEY = "XXXXX";

gpb = GooglePlacesBusiness.new(API_KEY)
gpb.fetchPlaceIdOfBusiness()

