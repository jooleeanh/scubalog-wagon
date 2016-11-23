class SeedBuddies < BasicSeed

  def seed_buddies
    Dive.all.each do |dive|
      rand(0...2).times do
        random_user = User.where.not("id = #{dive.user.id}").sample
        buddy = dive.buddies.new(user: random_user)
        # message(dive.id, "Dive at #{dive.divesite.name}", "already contains buddy", buddy.user.first_name, "light_red")
        if buddy.save
          message(dive.id, "Dive at #{dive.divesite.name}", "was with", buddy.user.first_name, "light_green")
        else
          error(buddy)
        end
      end
    end
  end
end
