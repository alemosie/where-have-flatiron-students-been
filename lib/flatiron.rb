require 'rest-client'
require 'json'
require 'pry'
require 'yaml'
require 'google_places'

require_relative "../lib/get-data.rb"

class Flatiron < GooglePlacesAPI
  def placeID
    self.placeIDLookup(term: "Flatiron School")
  end

  def details
    placeID = self.placeID
    self.detailsLookup(placeID: placeID)["result"]
  end

  def name
    self.details["name"]
  end

  def address
    self.details["formatted_address"]
  end

  def isOpen?
    if self.details["opening_hours"]["open_now"]
      "Currently open"
    else
      "Currently closed"
    end
  end

  def location
    loc = self.details["geometry"]["access_points"][0]["location"]
    lat = loc["lat"]
    long = loc["lng"]
    "Located at latitude: #{lat}, longitude: #{long}"
  end

  def reviews
    total = self.details["user_ratings_total"]
    rating = self.details["rating"]
    puts "Rating: " + "★" * (rating.floor) + "✰" * (5-rating.floor) + " #{rating}/5 (#{total} reviews)"
  end
end

flatiron = Flatiron.new
puts flatiron.location
puts flatiron.address
puts flatiron.isOpen?
puts flatiron.reviews
