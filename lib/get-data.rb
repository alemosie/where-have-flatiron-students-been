require 'rest-client'
require 'json'
require 'pry'
require 'yaml'
require 'google_places'

class GooglePlacesAPI
  @@APIKey = ""

  attr_reader :client

  def initialize
    @@APIKey = YAML.load_file('../application.yml').values[0] # reads secret key from YAML
    @client = GooglePlaces::Client.new(@@APIKey) # creates Google Places object
  end

  def autocompleteLookup(term:) # find correct object and get placeID
    autocompleteURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=#{term}&key=#{@@APIKey}"
    data = RestClient::Request.execute(url: autocompleteURL, method: "get", ssl_ca_file: "/Users/asiega/cert.pem", verify_ssl: false)
    JSON.parse(data)["predictions"]
  end

  def placeIDLookup(term:) # isolate placeID from autocomplete results
    data = autocompleteLookup(term: term)
    index = 0
    data.each do |result|
      if result["description"].include?(term)
        index = data.index(result)
      end
    end
    data[index]["place_id"]
  end

  def detailsLookup(placeID:) # get details about the specific place from placeID
    detailsURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{placeID}&key=#{@@APIKey}"
    data = RestClient::Request.execute(url: detailsURL, method: "get", ssl_ca_file: "/Users/asiega/cert.pem", verify_ssl: false)
    JSON.parse(data)
  end

end
