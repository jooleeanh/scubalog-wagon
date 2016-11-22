require "pry-byebug"

MODELS = [
  [User, [Participation, Dive, [EquipmentSet, Buddy, DataPoint, Sighting]]],
  [Divesite, [Event]],
  [Animal, [Sighting]],
  [Event, [Participation]]
]

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

def seed_animals(json_doc)
  json_doc.each do |key, category|
    category["creatures"].each do |k, animal|
      new_animal = Animal.new(
      name: animal["name"],
      image_url: animal["image_url"],
      )
      if new_animal.save
        puts "#{animal["name"]}".light_green
      else
        puts "#{new_animal.errors.messages}".light_red
      end
    end
  end
end

def seed_sightings
end

def parse_divesites
  JSON.parse(File.read("db/divesites_france.json"))
end

def parse_animals
  JSON.parse(File.read("db/100_animals.json"))
end

def parse_guys
  JSON.parse(File.read("db/randomuser_100_french_guys.json"))
end

def parse_girls
  JSON.parse(File.read("db/randomuser_100_french_girls.json"))
end

def prompt_for_animals
  print "Seed animals ? [y/n] > ".light_yellow
  answer = STDIN.gets.chomp
  if answer == "y"
    seed_animals(parse_animals)
  end
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
  stylize("--- DELETING SEED ---".light_red)
  puts "\n"
  MODELS.each do |model|
    dependent_models = get_names_in(model[1], []).join(", ")
    puts "Dependent: ".light_black + "#{dependent_models}".yellow
    print "- [y/n] ".light_black + "DELETE ".light_red + "#{model[0].name.pluralize}? ".light_yellow
    print " > "
    answer = STDIN.gets.chomp
    answers[model[0].name.downcase] = (answer.downcase == "y")
  end
  puts ""
  MODELS.each do |model|
    if answers[model[0].name.downcase]
      stylize("#{model[0].count} #{model[0].name.downcase.pluralize} deleted.".light_red)
      get_size_of(model[1])
      puts ""
      model[0].destroy_all
    end
  end
end

def get_names_in(array, results)
  array.each do |e|
    if e.class == Array
      get_names_in(e, results)
    else
      results << e.name.pluralize
    end
  end
  results
end

def get_size_of(array)
  array.each do |sub_model|
    if sub_model.class == Array
      print "  "
      get_size_of(sub_model)
    else
      puts "- #{sub_model.count} #{sub_model.name.pluralize} deleted.".red
    end
  end
end

def stylize(string)
  string.each_char { |chr| print chr; sleep 0.02 }
  puts ""
end

puts ""
delete_all?
create_users
create_divesites
prompt_for_animals
