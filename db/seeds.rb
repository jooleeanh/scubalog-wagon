require "pry-byebug"

MODELS = [User, EquipmentSet, Divesite, Event, Participation, Dive, Buddy, DataPoint, Animal, Sighting]

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
      puts "#{index} - #{json_doc[i]["first_name"]} #{json_doc[i]["last_name"]}".light_green
    else
      puts "#{index} - #{user.errors.full_messages}".light_red
    end
  end
end

def seed_equipment_sets
end

def seed_divesites(number, json_doc)
  number.times do |index|
    divesite = json_doc[index.to_s]
    new_divesite = Divesite.new(
     name: divesite["name"],
    #  location: divesite["location"]
     longitude: divesite["position"]["lng"],
     latitude: divesite["position"]["lat"]
    )
    if new_divesite.save
      puts "#{index} - #{divesite["name"]}".light_green
    else
      puts "#{index} - #{new_divesite.errors.full_messages}".light_red
    end
  end
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

def parse_divesites
  JSON.parse(File.read("db/divesites_france.json"))
end

def parse_guys
  JSON.parse(File.read("db/randomuser_100_french_guys.json"))
end

def parse_girls
  JSON.parse(File.read("db/randomuser_100_french_girls.json"))
end

def create_users
  print "Seed users ? [y/n] > ".light_yellow
  answer = STDIN.gets.chomp
  if answer == "y"
    create_user("guys")
    create_user("girls")
  end
end

def create_user(gender)
  puts "How many french #{gender}? (100 unique)".light_cyan
  print "> "
  number = STDIN.gets.chomp.to_i
  if number > 0
    case gender
    when "guys" then seed_users(number, parse_guys)
    when "girls" then seed_users(number, parse_girls)
    end
  end
end

def create_divesites
  print "Seed divesites ? [y/n] > ".light_yellow
  answer = STDIN.gets.chomp
  if answer == "y"
    json_doc = parse_divesites
    number = 0
    while number < 1 || number > json_doc.count
      puts "How many ? (#{json_doc.count} Dive Sites in France)"
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    seed_divesites(number, json_doc)
  end
end

def delete_all?
  answers = {}
  MODELS.each do |model|
    puts "Delete all #{model.name.downcase.pluralize}? [y/n]"
    print "> "
    answer = STDIN.gets.chomp
    answers[model.name.downcase] = answer
  end
  MODELS.each_with_index do |model, index|
    # TODO: 
  end
end

puts ""
create_users
create_divesites
