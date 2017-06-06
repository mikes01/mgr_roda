require 'rgeo'

module GisSupport
  def objects_in_area(north_east_lat, north_east_lng, south_west_lat,
    south_west_lng, object_types, type_name)
    window = create_window(north_east_lat, north_east_lng, south_west_lat,
      south_west_lng)
    where(type_name => object_types)
      .where("coordinates && ?", window.as_text).to_a
  end

  def create_window(north_east_lat, north_east_lng, south_west_lat, south_west_lng)
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(south_west_lng, south_west_lat)
    ne = factory.point(north_east_lng, north_east_lat)
    RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
  end
end