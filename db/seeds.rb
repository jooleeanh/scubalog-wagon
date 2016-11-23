require "pry-byebug"
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
  [User, [Participation, Dive, [EquipmentSet, Buddy, DataPoint, Sighting]]],
  [Divesite, [Event]],
  [Animal, [Sighting]],
  [Event, [Participation]]
]

class Seed
  # Done
  def delete_all?
    answers = {}
    stylize("--- DELETING SEED ---".light_red)
    puts "\n"
    MODELS.each do |model|
      dependent_models = get_names_in(model[1], []).join(", ")
      puts "Dependent: ".light_black + "#{dependent_models}".yellow
      print "- [y/n] ".light_black + "DELETE ".light_red + "#{model[0].name.pluralize}? ".light_yellow
      print " > "
      answer = STDIN.gets.chomp
      answers[model[0].name.downcase] = (answer.downcase == "y")
    end
    puts ""
    MODELS.each do |model|
      if answers[model[0].name.downcase]
        stylize("#{model[0].count} #{model[0].name.downcase.pluralize} deleted.".light_red)
        get_size_of(model[1])
        puts ""
        model[0].destroy_all
      end
    end
  end
  def create_animals
    print "Seed animals ? [y/n] > ".light_yellow
    answer = STDIN.gets.chomp
    if answer == "y"
      seed = SeedAnimals.new
      seed.seed_animals
    end
  end
  def create_users
    print "Seed users ? [y/n] > ".light_yellow
    answer = STDIN.gets.chomp
    if answer == "y"
      seed = SeedUsers.new
      seed.create_user("guys")
      seed.create_user("girls")
    end
  end
  def create_divesites
    print "Seed divesites ? [y/n] > ".light_yellow
    answer = STDIN.gets.chomp
    if answer == "y"
      seed = SeedDivesites.new
      seed.create_divesites
    end
  end

  # TODO:
  def create_buddies
    # TODO:
  end
  def create_data_points
    # TODO:
  end
  def create_dives
    # TODO:
  end
  def create_equipment_sets
    # TODO:
  end
  def create_sightings
    # TODO:
  end
  def create_events
    # TODO:
  end
  def create_participations
    # TODO:
  end

  private

  # Helpers
  def get_names_in(array, results)
    array.each do |e|
      if e.class == Array
        get_names_in(e, results)
      else
        results << e.name.pluralize
      end
    end
    results
  end
  def get_size_of(array)
    array.each do |sub_model|
      if sub_model.class == Array
        print "  "
        get_size_of(sub_model)
      else
        puts "- #{sub_model.count} #{sub_model.name.pluralize} deleted.".red
      end
    end
  end
  def stylize(string)
    string.each_char { |chr| print chr; sleep 0.02 }
    puts ""
  end
end

seed = Seed.new
seed.delete_all?
seed.create_users
seed.create_divesites
seed.create_animals
seed.create_buddies
seed.create_data_points
seed.create_dives
seed.create_equipment_sets
seed.create_sightings
seed.create_events
seed.create_participations
