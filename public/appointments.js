$.getJSON( "/api/all/appointments", function( appointments ) {
  var items = [];
  $.each( appointments, function( key, val ) {
    items.push( "<li id='" + key + "'>" + JSON.stringify(val) + "</li>" );
  });

  $( "<ul/>", {
    "class": "my-appointments",
    html: items.join( "" )
  }).appendTo( "div" );
});

// console.log(data)
