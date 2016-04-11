require 'rest-client'
require 'json'
require 'pry'
require 'yaml'
require 'google_places'

class GooglePlacesAPI
  @@APIKey = ""

  attr_reader :client

  def initialize
    @@APIKey = YAML.load_file('application.yml').values[0] # reads secret key from YAML
    @client = GooglePlaces::Client.new(@@APIKey) # creates Google Places object
  end
  # DATA!: https://maps.googleapis.com/maps/api/place/autocomplete/xml?input=Amoeba&key=APIKEY
  #RestClient
  #json
end

newPlace = GooglePlacesAPI.new
# binding.pry
