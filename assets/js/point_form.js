$(document).ready(function() {
  $('#point').click(function () {
    $(".form-horizontal").hide()
    $("#point_remote_form.new").show()
    return true;
  });
});

$(document).on('submit', '#point_remote_form.new', function(e){
  e.preventDefault();

  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    data: $(this).serialize(),
    complete: function (data) {
      if(data.status == 201) {
        point = wkt.read(data.responseJSON.coordinates_text).components[0]
        map.setView([point.y, point.x])
        toastr.success('New point is added!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});

$(document).on('submit', '#point_remote_form.edit', function(e){
  e.preventDefault();

  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    data: $(this).serialize(),
    complete: function (data) {
      if(data.status == 200 || data.status == 201) {
        point = wkt.read(data.responseJSON.coordinates_text).components[0]
        map.setView([point.y, point.x])
        toastr.success('The point is updated!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});

$(document).on('click', 'a#delete_point', function(e){
  e.preventDefault();

  $.ajax({
    type: 'DELETE',
    url: $(this).attr('href'),
    complete: function (data) {
      if(data.status == 200 || data.status == 201) {
        loadPoints();
        toastr.success('The point is deleted!', 'Success')
        $(".form-horizontal").hide()
      } else {
        toastr.error(data.responseText, 'ERROR')
      }
    },
  });
});
