var map = null;

function formatState (state) {
  if (!state.id) { return state.text; }

  var $state = $(
    '<span>' + '<input type="color" disabled="disabled" value="' + 
    state.element.attributes.style.value.split(":")[1].trim() +
    '">' + state.text + '</span>'
  );
  return $state
};

$(document).ready(function() {

  $(".form-horizontal").hide()
  map = L.map('map', {
      center: [51.1000000, 17.0333300],
      zoom: 16
  });

  map.createPane('lines');
  map.getPane('lines').style.zIndex = 500;
  map.createPane('polygons');
  map.getPane('polygons').style.zIndex = 400;

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  loadPoints();
  loadLines();
  loadPolygons();

  map.on('moveend', loadPoints);
  map.on('moveend', loadLines);
  map.on('moveend', loadPolygons);

});

getMapBounds = function() {
  bounds = map.getBounds();
  return {
    north_east_lat: bounds.getNorthEast().lat,
    north_east_lng: bounds.getNorthEast().lng,
    south_west_lat: bounds.getSouthWest().lat,
    south_west_lng: bounds.getSouthWest().lng
  }
}
