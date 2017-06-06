class Line < Sequel::Model
  extend GisSupport

  ROAD_TYPES = { "bridleway" => "#33cc85", "cycleway" => "#661a57",
    "footway" => "#4d2636", "living_street" => "#ffbfbf", "motorway" => "#997873",
    "motorway_link" => "#ff8800", "path" => "#d9b56c", "pedestrian" => "#ffff00",
    "primary" => "#74b32d", "primary_link" => "#0d3321", "residential" => "#00f2e2",
    "secondary" => "#00aaff", "secondary_link" => "#8fa3bf", "service" => "#0e0066",
    "steps" => "#6f00a6", "tertiary" => "#f2b6ee", "tertiary_link" => "#f20061",
    "track" => "#3df23d", "track_grade1" => "#402420", "track_grade2" => "#ff8800",
    "track_grade3" => "#a6a37c", "track_grade4" => "#eaffbf",
    "track_grade5" => "#0d3321", "trunk" => "#00474d", "trunk_link" => "#002966",
    "unclassified" => "#0e0066", "unknown" => "#e200f2", "custom" => "#661a57" }

  def color
    ROAD_TYPES[road_type]
  end

  def self.in_area(north_east_lat, north_east_lng, south_west_lat, south_west_lng, road_type)
    objects_in_area(north_east_lat, north_east_lng, south_west_lat,
    south_west_lng, road_type, :road_type)
  end
end
