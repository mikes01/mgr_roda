class Polygon < Sequel::Model
  extend GisSupport

  UNIT_TYPES = { "voivodeship" => "#a62929", "county" => "#997873", "commune" => "#402910",
    "registration_area" => "#e6f23d", "registration_unit" => "#74b32d",
    'custom' => "#b6f2de" }

  def unit_type_text
    UNIT_TYPES.keys[unit_type]
  end

  def unit_type_int
    UNIT_TYPES.keys.index(unit_type)
  end

  def color
    UNIT_TYPES[unit_type_text]
  end

  def self.in_area(north_east_lat, north_east_lng, south_west_lat, south_west_lng, unit_type)
    objects_in_area(north_east_lat, north_east_lng, south_west_lat,
    south_west_lng, unit_type, :unit_type)
  end
end
