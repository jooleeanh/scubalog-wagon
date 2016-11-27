class SeedDivesites < BasicSeed

  def parse_divesites
    JSON.parse(File.read("db/data/divesites_1188_france.json"))
  end

  def create_divesites
    json_doc = parse_divesites
    json_doc = ask_divide(json_doc)
    number = select_divesites(json_doc)
    seed_divesites(number, json_doc)
  end

  def select_divesites(json_doc)
    number = 0
    while number < 1 || number > json_doc.count
      puts "Create how many ? (#{json_doc.count} Dive Sites)"
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    number
  end

  def divide(json_doc, number)
    json_doc = json_doc.map.with_index { |(_,v), i| v if (i % number == 0) }
    json_doc.reject! { |divesite| divesite == nil }
  end

  def ask_divide(json_doc)
    number = 0 # Reduce divesite size while getting some from everywhere
    while number < 1 || number > json_doc.count
      puts "There are #{json_doc.count} Dive Sites in France."
      puts "Divide by how much?"
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    divide(json_doc, number)
  end

  def seed_divesites(number, json_doc)
    number.times do |index|
      divesite = json_doc[(index)]
      depth = rand(8...40)
      new_divesite = Divesite.new(
      name: divesite["name"],
      #  location: divesite["location"]
      longitude: divesite["position"]["lng"],
      latitude: divesite["position"]["lat"],
      difficulty: ["Easy", "Intermediate", "Hard"].sample,
      max_depth: depth,
      avg_depth: depth * 2 / 3,
      )
      if new_divesite.save
        puts "#{index} - #{divesite["name"]}".light_green
      else
        puts "#{index} - #{new_divesite.errors.full_messages}".light_red
      end
    end
  end
end
