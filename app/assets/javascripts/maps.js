$(document).ready(function(){

  var initialLocation;
  var siberia = new google.maps.LatLng(60, 105);
  var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
  var browserSupportFlag =  new Boolean();
  var addresses = ["351 West Hubbard, Chicago, IL, 60654", 
                   "230 West Kinzie Street Chicago, IL 60654", 
                   "400 North Wells Street Chicago, IL 60654"]

  function initialize() {
    geocoder = new google.maps.Geocoder();
    var myOptions = {
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
    setUserLocation(map);
    dropPins(addresses, map);
    // codeAddress(map);
    }

    function setUserLocation(map) {
    // Try W3C Geolocation (Preferred)
      if(navigator.geolocation) {
        browserSupportFlag = true;
        navigator.geolocation.getCurrentPosition(function(position) {
          initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
          map.setCenter(initialLocation);
        }, function() {
          handleNoGeolocation(browserSupportFlag);
        });
      }
    // Browser doesn't support Geolocation
    else {
      browserSupportFlag = false;
      handleNoGeolocation(browserSupportFlag);
    }
    
    function handleNoGeolocation(errorFlag) {
      if (errorFlag == true) {
        alert("Geolocation service failed.");
        initialLocation = newyork;
      } else {
        alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
        initialLocation = siberia;
      }
      map.setCenter(initialLocation);
    }
}

    function codeAddress(address, map) {
      // var address = document.getElementById('address').value;
      // address = "351 West Hubbard, Chicago, IL, 60654"
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          map.setCenter(results[0].geometry.location);
          var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
          });
        } else {
          alert('Geocode was not successful for the following reason: ' + status);
        }
      });
    }

    function dropPins(addresses, map) {
      for (var i=0; i < addresses.length; i++)
      { 
      codeAddress(addresses[i], map);
      }
    }
    
  google.maps.event.addDomListener(window, 'load', initialize);
});
  









