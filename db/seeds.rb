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
      create_animals?
      create_buddies?
      create_data_points?
      create_dives?
      create_equipment_sets?
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

  # TODO:
  def create_dives?
    # TODO:
  end
  def create_equipment_sets?
    answer = ask_create("equipment sets")
    if answer == "y"
      seed = SeedEquipmentSets.new
      seed.seed_equipment_sets
    end
  end
  def create_data_points?
    # TODO:
  end
  def create_buddies?
    # TODO:
  end
  def create_sightings?
    # TODO:
  end
  def create_events?
    # TODO:
  end
  def create_participations?
    # TODO:
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
