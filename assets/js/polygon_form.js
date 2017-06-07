$(document).ready(function() {
  $('#polygon').click(function () {
    console.log(1234)
    $(".form-horizontal").hide()
    $("#polygon_remote_form.new").show()
    return true;
  });
});

$(document).on('submit', '#polygon_remote_form.new', function(e){
  e.preventDefault();

  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    data: $(this).serialize(),
    complete: function (data) {
      if(data.status == 201) {
        point = wkt.read(data.responseJSON.coordinates_text).components[0][0][0]
        //map.setView([point.y, point.x])
        loadPolygons()
        toastr.success('New polygon is added!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});

$(document).on('submit', '#polygon_remote_form.edit', function(e){
  e.preventDefault();

  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    data: $(this).serialize(),
    complete: function (data) {
      if(data.status == 200 || data.status == 201) {
        point = wkt.read(data.responseJSON.coordinates_text).components[0][0][0]
        //map.setView([point.y, point.x])
        loadPolygons()
        toastr.success('The polygon is updated!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});

$(document).on('click', 'a#delete_polygon', function(e){
  e.preventDefault();

  $.ajax({
    type: 'DELETE',
    url: $(this).attr('href'),
    complete: function (data) {
      if(data.status == 200 || data.status == 201) {
        loadPolygons();
        toastr.success('The polygon is deleted!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});