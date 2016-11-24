class SeedEvents < BasicSeed

  def seed_events
    number = 0
    while number < 1
      puts "How many events?".light_cyan
      print "> "
      number = STDIN.gets.chomp.to_i
    end
    create_events(number)
  end

  def create_events(number)
    number.times do
      divesite = Divesite.all.sample
      time = Time.now + rand(1...30).days # TODO: Set time between 8 and 20
      event = Event.new(
        divesite: divesite,
        datetime: time,
        description: Faker::Lorem.sentence(20)
      )
      if event.save
        message(event.id, "Event at #{divesite.name}", "was created at", time.strftime("%a, %b %d"), "light_green")
      else
        error(event)
      end
    end
  end
end
