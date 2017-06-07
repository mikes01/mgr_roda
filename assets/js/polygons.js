var renderedPolygons = [];
wkt = new Wkt.Wkt();

loadPolygons = function() {
  if(polygonType == null) {
    clearPolygons()
    return
  }
  parameters = getMapBounds()
  parameters.unit_types = polygonType
  $.get("polygons", { data: parameters },
    function (data) {
      console.log(data);     
      var polygons = []
      data.forEach(function(polygon) {
        polygons.push(wkt.read( polygon.coordinates_text ).toObject({
          color: polygon.color, pane: 'polygons', className: polygon.name})
          .on('click', L.bind(onPolygonClick, null, polygon)))
      });
      var polygonsToRender = L.layerGroup(polygons).setZIndex(-1).addTo(map);
      clearPolygons();
      $('#polygons_count').text(data.length)
      renderedPolygons = polygonsToRender;
    });
}

onPolygonClick = function(polygon, event) {
  $(".form-horizontal").hide()
  form = $("#polygon_remote_form.edit")
  form[0].action = "polygons/" + polygon.id
  form.find('a')[0].href = form[0].action
  form.find("#polygon-name").val(polygon.name)
  form.find("#polygon-coordinates").val(polygon.coordinates_text)
  form.find("#polygon-unit-type").val(polygon.unit_type)
  form.find("#polygon-terc").val(polygon.terc)
  form.show()
}

clearPolygons = function() {
  map.removeLayer(renderedPolygons);
}