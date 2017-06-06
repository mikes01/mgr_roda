require 'byebug'

class MgrRoda
  plugin :all_verbs
  route 'lines' do |r|
    r.get do
      Line.in_area(params[:data][:south_west_lat],
        params[:data][:south_west_lng], params[:data][:north_east_lat],
        params[:data][:north_east_lng], params[:data][:road_types]).map do |p|
          p.values.merge({color: p.color})
      end
    end
    r.post do
      line = Line.new(line_params)

      if line.save
        response.status = 201
      else
        response.status = 422
      end
      line.values
    end

    r.delete :id do |id|
      @line = Line[id]
      if @line.delete
        response.status = 200
      else
        response.status = 422
      end
      @line.values
    end

    r.patch :id do |id|
      @line = Line[id]
      if @line.update(line_params)
        response.status = 200
      else
        response.status = 422
      end
      @line.values
    end
  end

  def line_params
    hash = params[:line]
    line =  RGeo::Geos.factory(srid: 4326).parse_wkt(params[:line][:coordinates])
    hash[:coordinates] = RGeo::WKRep::WKBGenerator.new(hex_format: true,
      type_format: :ewkb, emit_ewkb_srid: true).generate(line)
    hash
  end
end
