class SeedDives < BasicSeed

  def seed_dives
    User.all.each do |user|
      rand(5...20).times do
        dive = user.dives.new(basic_dive)
        if dive.save
          print "#{user.id} - #{user.first_name.capitalize}".light_yellow
          print " dove at "
          puts "'#{dive.divesite.name}'".blue
        else
          puts "#{dive.errors.full_messages}".light_red
        end
      end
    end
  end

  def basic_dive
    depth = rand(12...40)
    temp = rand(12...18)
    rating = [nil,nil,nil,nil,nil,nil,1,2,3,4,5].sample
    rating.nil? ? nil : review = Faker::Lorem.sentence(10)
    {
      divesite: Divesite.all.sample,
      datetime: Time.now - rand(1..365).days,
      types: Dive::TYPES.sample,
      tank_size: 80,
      bottom_time: rand(20...60),
      start_air: rand(180...220),
      end_air: rand(10...120),
      max_depth: depth.round,
      avg_depth: (depth * 2 / 3).round,
      min_temp: temp,
      max_temp: temp + rand(1...5),
      comments: Faker::Lorem.sentence(25),
      enjoyment: rand(1...5),
      visibility: rand(8...20),
      polygon: [],
      review_rating: rating,
      review_content: review
    }
  end

end
