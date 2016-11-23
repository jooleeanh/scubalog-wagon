require_relative 'basic_seed'
require_relative 'delete_seed'
require_relative 'seed_users'
require_relative 'seed_divesites'
require_relative 'seed_buddies'
require_relative 'seed_data_points'
require_relative 'seed_dives'
require_relative 'seed_equipment_sets'
require_relative 'seed_animals'
require_relative 'seed_sightings'
require_relative 'seed_events'
require_relative 'seed_participations'

MODELS = [
  [Event, [Participation]],
  [Animal, [Sighting]],
  [User, [Participation, Dive, [EquipmentSet, Buddy, DataPoint, Sighting]]],
  [Divesite, [Event]],
]

class Seed < BasicSeed
  # Done
  def stats?
    print "[y/n] ".light_black + "Get model stats?".light_yellow + " > "
    puts "You like 💩💩💩💩💩💩 ?"
    answer = STDIN.gets.chomp
    if answer == "y"
      get_size_of(MODELS)
    end
  end
  def delete_seed?
    answer = ask_seed("delete")
    if answer == "y"
      puts ""
      seed = DeleteSeed.new
      seed.delete_all?
    end
  end
  def create_seed?
    answer = ask_seed("create")
    if answer == "y"
      puts ""
      stylize("--- CREATING SEED ---".light_green)
      puts "\n"
      create_users?
      create_divesites?
      create_dives?
      create_buddies?
      create_equipment_sets?
      create_data_points?
      create_animals?
      create_sightings?
      create_events?
      create_participations?
    end
  end
  def create_animals?
    answer = ask_create("animals")
    if answer == "y"
      seed = SeedAnimals.new
      seed.seed_animals
    end
  end
  def create_users?
    answer = ask_create("users")
    if answer == "y"
      seed = SeedUsers.new
      seed.create_user("guys")
      seed.create_user("girls")
    end
  end
  def create_divesites?
    answer = ask_create("divesites")
    if answer == "y"
      seed = SeedDivesites.new
      seed.create_divesites
    end
  end
  def create_equipment_sets?
    answer = ask_create("equipment sets")
    if answer == "y"
      seed = SeedEquipmentSets.new
      seed.seed_equipment_sets
    end
  end
  def create_dives?
    answer = ask_create("dives")
    if answer == "y"
      seed = SeedDives.new
      seed.seed_dives
    end
  end
  def create_buddies?
    answer = ask_create("buddies")
    if answer == "y"
      seed = SeedBuddies.new
      seed.seed_buddies
    end
  end
  def create_sightings?
    answer = ask_create("sightings")
    if answer == "y"
      seed = SeedSightings.new
      seed.seed_sightings
    end
  end
  def create_events?
    answer = ask_create("events")
    if answer == "y"
      seed = SeedEvents.new
      seed.seed_events
    end
  end
  def create_participations?
    answer = ask_create("participations")
    if answer == "y"
      seed = SeedParticipations.new
      seed.seed_participations
    end
  end

  # TODO:
  def create_data_points?
    answer = ask_create("data points")
    if answer == "y"
      seed = SeedDataPoints.new
      seed.seed_data_points
    end
  end

  private

  def ask_seed(action)
    case action
    when "delete" then print "  Delete ".light_red
    when "create" then print "  Create ".light_green
    end
    print "seed?".light_cyan
    print " [y/n] ".light_black
    print "> "
    STDIN.gets.chomp
  end
  def ask_create(model)
    print "- [y/n] ".light_black
    print "Create ".light_green
    print model.light_yellow
    print "? > ".light_yellow
    STDIN.gets.chomp
  end
end

puts ""
seed = Seed.new
seed.stats?
seed.delete_seed?
seed.create_seed?
seed.stats?
puts ""

