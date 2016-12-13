require_relative 'basic_seed'
require_relative 'delete_seed'
require_relative 'seed_users'
require_relative 'seed_divesites'
require_relative 'seed_buddies'
require_relative 'seed_computer_dives'
require_relative 'seed_data_points'
require_relative 'seed_dives'
require_relative 'seed_equipment_sets'
require_relative 'seed_animals'
require_relative 'seed_sightings'
require_relative 'seed_events'
require_relative 'seed_participations'
require_relative 'seed_custom'

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
  def automatic?
    print "Automatic seed?".light_cyan + " > "
    answer = STDIN.gets.chomp
    if answer == "y"
      destroy_all_seed
      create_all_seed
    else
      delete_seed?
      create_seed?
    end
  end
  def custom?
    print "Custom seed?".light_cyan + " > "
    answer = STDIN.gets.chomp
    if answer == "y"
      seed = SeedCustom.new
      seed.create_divesites
      seed.create_dives(seed.julian, 15)
    end
  end
  def destroy_all_seed
    stylize("Destroying all seed.".light_red)
    MODELS.each do |m|
      get_size_of(m, "deleted")
      if m.first.name == "User"
        m.first.where(facebook_picture_url: nil).destroy_all
      else
        m.first.destroy_all
      end
    end
  end
  def create_all_seed
    users = SeedUsers.new
    guys = users.parse_guys
    girls = users.parse_girls
    users.seed_users(20, guys)
    users.seed_users(20, girls)

    divesites = SeedDivesites.new
    json_divesites = divesites.parse_divesites
    json_divesites = divesites.divide(json_divesites, 5)
    divesites.seed_divesites(238, json_divesites)

    dives = SeedDives.new
    dives.seed_dives

    computerdives = SeedComputerDives.new
    computerdives.seed_computer_dives

    buddies = SeedBuddies.new
    buddies.seed_buddies

    equipmentsets = SeedEquipmentSets.new
    equipmentsets.seed_equipment_sets

    animals = SeedAnimals.new
    animals.seed_animals

    sightings = SeedSightings.new
    sightings.seed_sightings

    events = SeedEvents.new
    events.create_events(50)

    participations = SeedParticipations.new
    participations.seed_participations
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
      create_computer_dives?
      create_buddies?
      create_equipment_sets?
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
    answer = ask_create("dives for fake users")
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
  def create_computer_dives?
    answer = ask_create("computer dives for custom users")
    if answer == "y"
      seed = SeedComputerDives.new
      seed.seed_computer_dives
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
seed.automatic?
seed.custom?
seed.stats?
puts ""
