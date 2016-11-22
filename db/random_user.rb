require "json"
require 'rest-client'
require "iso_country_codes"

class RandomUser
  attr_reader :users

  def initialize
    @users = {}
  end
  def parse_users(random_user_url)
    json_doc = JSON.parse(RestClient.get(random_user_url))
    json_doc["results"].each_with_index do |json, index|
      if json["nat"] == "FR"
        user = {
          gender: json["gender"],
          first_name: json["name"]["first"],
          last_name: json["name"]["last"],
          street: json["location"]["street"],
          city: json["location"]["city"],
          state: json["location"]["state"],
          postcode: json["location"]["postcode"],
          country: IsoCountryCodes.find(json["nat"]).name,
          email: json["email"],
          password: json["login"]["password"],
          dob: json["dob"],
          registered: json["registered"],
          photo_large: "https://randomuser.me/api/portraits/women/#{index}.jpg"
        }
        @users[index] = user
      end
    end
  end

  def store_json
    filepath = "db/randomuser_#{@users.count}_french_girls"
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(@users))
    end
  end
end

random_user = RandomUser.new

# ten_french_users = "https://randomuser.me/api/?page=1&results=160&seed=abc"
# twenty_french_users = "https://randomuser.me/api/?page=1&results=300&seed=abc"
# thirty_french_users = "https://randomuser.me/api/?page=1&results=480&seed=abc"
# hundred_french_users = "https://randomuser.me/api/?page=1&results=1430&seed=abc"
# hundred_french_guys = "https://randomuser.me/api/?nat=fr&gender=male&page=1&results=100"
hundred_french_girls = "https://randomuser.me/api/?nat=fr&gender=female&page=1&results=100"

random_user.parse_users(hundred_french_girls)
random_user.store_json
