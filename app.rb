require_relative 'models'

require 'roda'
require 'forme/bs3'
require "forme/erb"


class MgrRoda < Roda
  include Forme::ERB::Helper
  opts[:unsupported_block_result] = :raise
  opts[:unsupported_matcher] = :raise
  opts[:verbatim_string_matcher] = true

  use Rack::Session::Cookie,
    :key => '_MgrRoda_session',
    #:secure=>!TEST_MODE, # Uncomment if only allowing https:// access
    :secret=>File.read('.session_secret')

  plugin :render, :escape=>:erubi
  plugin :multi_route
  plugin :indifferent_params
  plugin :json, :classes=>[Array, Hash, Sequel::Model]
  plugin :all_verbs
  plugin :assets, css: ['leaflet.css', 'main.css', 'select2.min.css',
    'toastr.min.css', 'bootstrap.min.css'],
    js: ['jquery-3.2.1.min.js', 'wicket.js', 'checkboxes.js', 'leaflet.js',
      'line_form.js', 'lines.js', 'polygon_form.js', 'polygons.js',
      'map.js', 'select2.full.min.js', 'toastr.min.js', 'wicket-leaflet.js',
       'point_form.js', 'points.js', 'bootstrap.min.js']

  Unreloader.require('routes'){}

  Forme.default_config = :bs3

  route do |r|
    r.multi_route
    r.assets

    r.root do
      view 'index'
    end
  end
end
