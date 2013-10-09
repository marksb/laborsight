function ZoomControl(div, map) {

  // Get the control DIV. We'll attach our control UI to this DIV.
  var controlDiv = div;

  // Set CSS for the controls.
  controlDiv.style.margin = '28px 0px 0px 22px';
  controlDiv.style.cursor = 'pointer';
  controlDiv.style.border = "1px solid #9e9e9e"
  controlDiv.style.opacity = "0.8";
  controlDiv.style.backgroundColor = "#FFFFFF";
  controlDiv.style.fontFamily = 'Open Sans';
  controlDiv.style.borderRadius = '3px';
  controlDiv.style.height = '36px';
  controlDiv.style.width = '72px';

  // var zoomout = document.createElement('div');
  // zoomout.title = 'Click to zoom out';
  // zoomout.style.display = 'inline-block';
  // zoomout.style.borderRight = "1px solid #9e9e9e"
  // zoomout.style.width = '50%';
  // zoomout.style.height = '100%';
  // zoomout.style.marginTop = '2px';
  // controlDiv.appendChild(zoomout);

  var zoomout = document.createElement('img');
  zoomout.title = 'Click to zoom in';
  zoomout.setAttribute('src', '/zoomout.png');
  zoomout.style.display = 'inline-block';
  zoomout.style.width = '17px';
  zoomout.style.height = '17px';
  zoomout.style.marginLeft = '8px';
  zoomout.style.marginTop = '8px';
  controlDiv.appendChild(zoomout);

  // var zoomoutText = document.createElement('div');
  // zoomoutText.innerHTML = '<strong>-</strong>';
  // zoomoutText.style.fontSize = '35px';
  // zoomoutText.style.position = 'static';
  // zoomoutText.style.fontWeight = '700';
  // zoomoutText.style.textAlign = 'center';
  // zoomoutText.style.color = "#9e9e9e"
  // zoomout.appendChild(zoomoutText);

  var zoomin = document.createElement('img');
  zoomin.title = 'Click to zoom in';
  zoomin.setAttribute('src', '/zoomin.png');
  zoomin.style.display = 'inline-block';
  zoomin.style.width = '17px';
  zoomin.style.height = '17px';
  zoomin.style.marginLeft = '17px';
  zoomin.style.marginTop = '8px';
  controlDiv.appendChild(zoomin);

  // var zoominText = document.createElement('div');
  // zoominText.innerHTML = '<strong>+</strong>';
  // zoominText.style.fontSize = '25px';
  // zoominText.style.position = 'static';
  // zoominText.style.textAlign = 'center';
  // zoominText.style.color = "#9e9e9e"
  // zoomin.appendChild(zoominText);

  // Setup the click event listeners for zoom-in, zoom-out:
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