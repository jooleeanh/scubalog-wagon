class SeedParticipations < BasicSeed

  def seed_participations
    Event.all.each do |event|
      rand(2..4).times do
        user = User.all.sample
        participation = user.participations.new(
        event: event
        )
        if participation.save
          message(participation.id, user.first_name, "joined event at #{event.divesite.name} on", event.datetime.strftime("%a, %b %d"), "light_green")
        else
          error(participation)
        end
      end
    end
  end
end
