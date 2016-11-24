module DivesHelper

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
