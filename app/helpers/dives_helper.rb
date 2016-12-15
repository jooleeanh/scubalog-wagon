module DivesHelper

  def time_relative(datetime)
    ((Time.now - datetime) / (60*60*24)).day
  end

  def sort_desc(hash) # returns double array [[k, count],[]]
    hash.reject { |k, v| k.blank? }.sort_by {|_, value| value }.reverse
  end

  def count_type_occurences(dives)
    types = dives.map { |dive| dive.types }.each_with_object(Hash.new(0)) { |type, counts| counts[type] += 1 }.reject { |k, v| k.blank? }
    sort_desc(types)
  end

  def count_buddy_occurences(dives)
    buddies = dives.map { |dive| dive.buddies }.each_with_object(Hash.new(0)) { |buddy, counts| counts[buddy[0]&.user&.first_name] += 1 }
    sort_desc(buddies)
  end

  def count_divesite_occurences(dives)
    divesites = dives.map { |dive| dive.divesite }.each_with_object(Hash.new(0)) { |divesite, counts| counts[divesite&.name] += 1 }
    sort_desc(divesites)
  end

  def dive_fields_hash(dive)
    [
      { key: "Start time", value: time_long(dive.datetime), unit: "" },
      { key: "Bottom time", value: dive.bottom_time, unit: "min" },
      { key: "Surface time", value: "to calculate", unit: "" },
      { key: "Max depth", value: dive.max_depth, unit: "m" },
      { key: "Average depth", value: dive.avg_depth, unit: "m" },
      { key: "Tank size", value: dive.tank_size, unit: "L" },
      { key: "Start air", value: dive.start_air, unit: "BAR" },
      { key: "End air", value: dive.end_air, unit: "BAR" },
      { key: "Air use", value: air_use(dive.start_air, dive.end_air), unit: "BAR" },
      { key: "Air rate", value: "to calculate", unit: "L/min" },
      { key: "Min temp", value: dive.min_temp, unit: "C" },
      { key: "Max temp", value: dive.max_depth, unit: "C" },
      { key: "Visibility", value: dive.visibility, unit: "m" }
    ]
  end

  def air_use(dive)
    if dive.start_air == nil || dive.end_air == nil
      0
    else
      dive.start_air - dive.end_air
    end
  end

  def dive_equipment_hash(equipment)
    if equipment == nil
      {
        Mask: nil,
        Snorkel: nil,
        Fins: nil,
        Wetsuit: nil,
        Computer: nil,
        BCD: nil,
        Regulator: nil,
        Weight: nil,
      }
    else
      {
        Mask: equipment.mask,
        Snorkel: equipment.snorkel,
        Fins: equipment.fins,
        Wetsuit: equipment.wetsuit,
        Computer: equipment.computer,
        BCD: equipment.bcd,
        Regulator: equipment.regulator,
        Weight: equipment.weight,
      }
    end
  end
end
