var pointTypes = ["część miasta", "miasto", "wieś"]
var lineTypes = ["residential", "secondary", "secondary_link", "primary", "primary_link",
        "tertiary", "tertiary_link", "living_street"]
var polygonType = "3"

$(document).ready(function() {
    $(".select2-input").select2({
      templateResult: formatState,
      templateSelection: formatState,
      placeholder: "Select a polygon type"
    })

    $("#point_types").val(pointTypes).trigger("change")
    $("#line_types").val(lineTypes).trigger("change")
    $("#polygon_type").val(polygonType).trigger("change")
});

$(document).on('click', '#refresh-map', function(e){
  e.preventDefault();

  pointTypes = $("#point_types").val()
  loadPoints()

  lineTypes = $("#line_types").val()
  loadLines()

  polygonType = $("#polygon_type").val()
  loadPolygons()
});

$(document).on('click', '#clear-points', function(e){
  e.preventDefault();
  $("#point_types").val(null).trigger("change")
  
});

$(document).on('click', '#all-points', function(e){
  e.preventDefault();
  $("#point_types").val(["część kolonii", "część miasta",
    "część osady", "część przysiółka",
    "część wsi", "kolonia", "kolonia kolonii",
    "kolonia osady", "kolonia wsi",
    "leśniczówka", "miasto", "osada",
    "osada kolejowa", "osada kolonii",
    "osada leśna", "osada leśna wsi",
    "osada młyńska", "osada osady",
    "osada wsi", "osiedle", "osiedle wsi",
    "przysiółek", "przysiółek kolonii",
    "przysiółek osady", "przysiółek wsi",
    "schronisko turystyczne", "wieś"]).trigger("change")
  
});

$(document).on('click', '#clear-lines', function(e){
  e.preventDefault();
  $("#line_types").val(null).trigger("change")
  
});

$(document).on('click', '#all-lines', function(e){
  e.preventDefault();
  $("#line_types").val(["bridleway", "cycleway",
    "footway", "living_street", "motorway",
    "motorway_link", "path", "pedestrian",
    "primary", "primary_link", "residential",
    "secondary", "secondary_link", "service",
    "steps", "tertiary", "tertiary_link",
    "track", "track_grade1", "track_grade2",
    "track_grade3", "track_grade4",
    "track_grade5", "trunk", "trunk_link",
    "unclassified", "unknown", "custom"]).trigger("change")
  
});

$(document).on('click', '#clear-polygons', function(e){
  e.preventDefault();
  $("#polygon_type").val(null).trigger("change")
  
});

