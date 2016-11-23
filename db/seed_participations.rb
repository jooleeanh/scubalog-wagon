class SeedParticipations < BasicSeed

  def seed_participations
    User.all.each do |user|
      rand(1..3).times do
        event = Event.all.sample
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
