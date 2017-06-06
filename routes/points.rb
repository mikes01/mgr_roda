require 'byebug'

class MgrRoda
  plugin :all_verbs
  route 'points' do |r|
    r.get do
      Point.in_area(params[:data][:south_west_lat],
        params[:data][:south_west_lng], params[:data][:north_east_lat],
        params[:data][:north_east_lng], params[:data][:object_types]).map do |p|
          p.values.merge({color: p.color})
      end
    end
    r.post do
      point = Point.new(point_params)

      if point.save
        response.status = 201
      else
        response.status = 422
      end
      point.values
    end

    r.delete :id do |id|
      @point = Point[id]
      if @point.delete
        response.status = 200
      else
        response.status = 422
      end
      @point.values
    end

    r.patch :id do |id|
      @point = Point[id]
      if @point.update(point_params)
        response.status = 200
      else
        response.status = 422
      end
      @point.values
    end
  end

  def point_params
    hash = params[:point]
    point =  RGeo::Geos.factory(srid: 4326).parse_wkt(params[:point][:coordinates])
    hash[:coordinates] = RGeo::WKRep::WKBGenerator.new(hex_format: true,
      type_format: :ewkb, emit_ewkb_srid: true).generate(point)
    hash
  end
end
