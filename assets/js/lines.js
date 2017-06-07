var renderedLines = [];
wkt = new Wkt.Wkt();

loadLines = function() {
  if(lineTypes == null) {
    clearLines();
    return
  }
  parameters = getMapBounds()
  parameters.road_types = lineTypes
  $.get("lines", { data: parameters },
    function (data) {
      var lines = []
      data.forEach(function(line) {
        lines.push(wkt.read( line.coordinates_text ).toObject(
          {color: line.color, pane: 'lines', className: line.name})
          .on('click', L.bind(onLineClick, null, line)))
      });
      var polylines = L.layerGroup(lines).setZIndex(100).addTo(map);
      lines.forEach(function(line) {
        line.openPopup()
      });
      clearLines();
      $('#lines_count').text(data.length)
      renderedLines = polylines;
    });
}

onLineClick = function(line, event) {
  $(".form-horizontal").hide()
  form = $("#line_remote_form.edit")
  form[0].action = "lines/" + line.id
  form.find('a')[0].href = form[0].action
  form.find("#line-name").val(line.name)
  form.find("#line-coordinates").val(line.coordinates_text)
  form.find("#line-road-type").val(line.road_type)
  form.show()
}

clearLines = function() {
  map.removeLayer(renderedLines);
}