class SeedUsers < BasicSeed

  def parse_guys
    JSON.parse(File.read("db/data/users_100_french_guys.json"))
  end

  def parse_girls
    JSON.parse(File.read("db/data/users_100_french_girls.json"))
  end

  def create_user(gender)
    number = 0
    while number < 1 || number > 100
      puts "How many french #{gender}? (100 unique)".light_cyan
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    case gender
    when "guys" then seed_users(number, parse_guys)
    when "girls" then seed_users(number, parse_girls)
    end
  end

  def seed_users(number, json_doc)
    number.times do |index|
      i = index.to_s
      location = json_doc[i]["street"] + json_doc[i]["city"] + json_doc[i]["state"] + json_doc[i]["postcode"].to_s + json_doc[i]["country"]
      user = User.new(
      first_name: json_doc[i]["first_name"],
      last_name: json_doc[i]["last_name"],
      gender: json_doc[i]["gender"],
      dob: json_doc[i]["dob"],
      email: json_doc[i]["email"],
      password: "scubalog",
      location: location,
      created_at: DateTime.parse(json_doc[i]["registered"]),
      # photo: json_doc[i]["photo_large"]
      )
      if user.save
        puts "#{index} - #{json_doc[i]["first_name"].capitalize} #{json_doc[i]["last_name"].capitalize}".light_green
      else
        puts "#{index} - #{user.errors.full_messages}".light_red
      end
    end
  end
end
