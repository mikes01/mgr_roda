require 'byebug'

class MgrRoda
  plugin :all_verbs
  route 'polygons' do |r|
    r.get do
      Polygon.in_area(params[:data][:south_west_lat],
        params[:data][:south_west_lng], params[:data][:north_east_lat],
        params[:data][:north_east_lng], params[:data][:unit_types]).map do |p|
          p.values.merge({color: p.color})
      end
    end
    r.post do
      polygon = Polygon.new(polygon_params)

      if polygon.save
        response.status = 201
      else
        response.status = 422
      end
      polygon.values
    end

    r.delete :id do |id|
      @polygon = Polygon[id]
      if @polygon.delete
        response.status = 200
      else
        response.status = 422
      end
      @polygon.values
    end

    r.patch :id do |id|
      @polygon = Polygon[id]
      if @polygon.update(polygon_params)
        response.status = 200
      else
        response.status = 422
      end
      @polygon.values
    end
  end

  def polygon_params
    hash = params[:polygon]
    polygon =  RGeo::Geos.factory(srid: 4326).parse_wkt(params[:polygon][:coordinates])
    hash[:coordinates] = RGeo::WKRep::WKBGenerator.new(hex_format: true,
      type_format: :ewkb, emit_ewkb_srid: true).generate(polygon)
    hash
  end
end
