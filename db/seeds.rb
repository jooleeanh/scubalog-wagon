require "pry-byebug"

def seed_users(number, json_doc)
  number.times do |index|
    i = index.to_s
    location = json_doc[i]["street"] + json_doc[i]["city"] + json_doc[i]["state"] + json_doc[i]["postcode"].to_s + json_doc[i]["country"]
    user = User.new(
    # first_name: json_doc[i]["first_name"],
    # last_name: json_doc[i]["last_name"],
    gender: json_doc[i]["gender"],
    dob: json_doc[i]["dob"],
    email: json_doc[i]["email"],
    password: "scubalog",
    location: location,
    created_at: DateTime.parse(json_doc[i]["registered"]),
    # photo: json_doc[i]["photo_large"]
    )
    if user.save
      puts "#{index} - #{json_doc[i]["first_name"]} #{json_doc[i]["last_name"]}".light_green
    else
      puts "#{index} - #{user.errors.messages}".light_red
    end
  end
end

def seed_equipment_sets
end

def seed_divesites
end

def seed_events
end

def seed_participations
end

def seed_dives
end

def seed_buddies
end

def seed_data_points
end

def seed_animals
end

def seed_sightings
end

def parse_guys
  JSON.parse(File.read("db/randomuser_100_french_guys.json"))
end

def parse_girls
  JSON.parse(File.read("db/randomuser_100_french_girls.json"))
end

def prompt_for_users
  print "Seed users ? [y/n] > ".light_yellow
  answer = STDIN.gets.chomp
  if answer == "y"
    prompt_for_user("guys")
    prompt_for_user("girls")
  end
end

def prompt_for_user(gender)
  print "(100 unique) How many french #{gender} ? > ".light_cyan
  number = STDIN.gets.chomp.to_i
  if number > 0
    case gender
    when "guys" then seed_users(number, parse_guys)
    when "girls" then seed_users(number, parse_girls)
    end
  end
end

puts ""
prompt_for_users
