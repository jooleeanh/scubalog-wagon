module DivesHelper

  def count_type_occurences(dives)
    dives.map { |dive| dive.types }.each_with_object(Hash.new(0)) { |type, counts| counts[type] += 1 }.reject { |k, v| k.blank? }.sort_by {|_, value| value }.reverse
  end

  def count_buddy_occurences(dives)
    d = dives.map { |dive| dive.buddies }.each_with_object(Hash.new(0)) { |buddy, counts| counts[buddy[0]&.user&.first_name] += 1 }
    d.reject { |k, v| k.blank? }.sort_by {|_, value| value }.reverse
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
      { key: "Air use", value: dive.start_air - dive.end_air, unit: "BAR" },
      { key: "Air rate", value: "to calculate", unit: "L/min" },
      { key: "Min temp", value: dive.min_temp, unit: "C" },
      { key: "Max temp", value: dive.max_depth, unit: "C" },
      { key: "Visibility", value: dive.visibility, unit: "m" }
    ]
  end

  def dive_equipment_hash(equipment)
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
