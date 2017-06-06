

class Point < Sequel::Model
  extend GisSupport

  OBJECT_TYPES = {"część kolonii" => "#8fa3bf", "część miasta" => "#e51f00",
    "część osady" => "#ffa280", "część przysiółka" => "#e6f23d",
    "część wsi" => "#a6a37c", "kolonia" => "#3b5900", "kolonia kolonii" => "#3df23d",
    "kolonia osady" => "#b6f2de", "kolonia wsi" => "#00474d",
    "leśniczówka" => "#263b4d", "miasto" => "#0044ff", "osada" => "#b380ff",
    "osada kolejowa" => "#e200f2", "osada kolonii" => "#b3008f",
    "osada leśna" => "#bf6086", "osada leśna wsi" => "#a62929",
    "osada młyńska" => "#402420", "osada osady" => "#993d00",
    "osada wsi" => "#8c5e00", "osiedle" => "#403f30", "osiedle wsi" => "#eaffbf",
    "przysiółek" => "#33cc85", "przysiółek kolonii" => "#238c77",
    "przysiółek osady" => "#0099bf", "przysiółek wsi" => "#002966",
    "schronisko turystyczne" => "#4d4d99", "wieś" => "#716080"}

  OBJECT_CLASSES = ["miejscowość"]

  def self.in_area(north_east_lat, north_east_lng, south_west_lat, south_west_lng, object_type)
    objects_in_area(north_east_lat, north_east_lng, south_west_lat,
    south_west_lng, object_type, :object_type)
  end

  def color
    OBJECT_TYPES[object_type]
  end
end
