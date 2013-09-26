function ZoomControl(div, map) {

  // Get the control DIV. We'll attach our control UI to this DIV.
  var controlDiv = div;

  // We set up a variable for the 'this' keyword since we're adding event
  // listeners later and 'this' will be out of scope.
  controlDiv.style.padding = '5px';
  controlDiv.style.backgroundColor = "#FFFFFF"

  // Set CSS for the control border.
  var zoomout = document.createElement('div');
  zoomout.title = 'Click to zoom out';
  controlDiv.appendChild(zoomout);

  // Set CSS for the control interior.
  var zoomoutText = document.createElement('div');
  zoomoutText.innerHTML = '<strong>---</strong>';
  zoomout.appendChild(zoomoutText);

  // Set CSS for the setHome control border.
  var zoomin = document.createElement('div');
  zoomin.title = 'Click to zoom in';
  controlDiv.appendChild(zoomin);

  // Set CSS for the control interior.
  var zoominText = document.createElement('div');
  zoominText.innerHTML = '<strong>+++++</strong>';
  zoomin.appendChild(zoominText);

  // Setup the click event listener for Home:
  // simply set the map to the control's current home property.
  google.maps.event.addDomListener(zoomout, 'click', function() {
   var currentZoomLevel = map.getZoom();
   if(currentZoomLevel != 0){
     map.setZoom(currentZoomLevel - 1);}     
  });

   google.maps.event.addDomListener(zoomin, 'click', function() {
   var currentZoomLevel = map.getZoom();
   if(currentZoomLevel != 21){
     map.setZoom(currentZoomLevel + 1);}
  });
}