class SeedDivesites

  def parse_divesites
    JSON.parse(File.read("db/data/divesites_1188_france.json"))
  end

  def create_divesites
    json_doc = parse_divesites
    number = 0
    while number < 1 || number > json_doc.count
      puts "How many ? (#{json_doc.count} Dive Sites in France)"
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    seed_divesites(number, json_doc)
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
end
