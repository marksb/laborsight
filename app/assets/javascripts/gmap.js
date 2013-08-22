var MapView = {

  init: function() {
    var mapOptions = {
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.TERRAIN,
        scaleControlOptions: {
      }
    };

    this.markers = [];


    this.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    var that = this;

    this.geolocateUser({success: function(coords) {
      that.map.setCenter(coords);

      that.getNeighborhood(coords, {
        success: function(neighborhood_info) {
          that.getNeighborhoodGrade(neighborhood_info);
        },
        failure: function() {
          alert("Reverse geocoding failed!");
        }
      });
    }});

      google.maps.event.addListener(that.map, 'idle', function() {
        console.log("Idle event fired!");
        that.getCompanies();
      });

  },
  getNeighborhoodGrade: function() {
    // get request
    // render the grade
    alert("Get neighborhood grade!");
  },
  getCompanies: function() {
    var bounds = this.getTheBounds();
    var that = this;
    console.log("Firing GET request!");
    $.get('/companies/data', bounds, function(response) {
      console.log("Clearing companies and rendering new ones!");
      that.clearMapMarkers();
      for (var i=0; i < response.length; i++) {
        var company = $.parseJSON( response[i] );
        that.markers.push(that.renderMarker(company));
      }
      that.startMarkerManager();
    });

  },

  renderMarker: function(company) {
    var that = this;
    var customPin = '/assets/markerRed.png';
    // console.log(customPin);
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(company["latitude"], company["longitude"]),
      icon: customPin,
      map: that.map
    });

    google.maps.event.addListener(marker, 'click', function() {
      that.activeMarker = marker
      that.activeMarker.setIcon('/assets/marker2.png');
      that.openSideBar(company);

    });
    return marker;
  },

  clearMapMarkers: function() {
    var that = this;
      if(that.markers && that.markers.length !== 0){
      for(var i = 0; i < that.markers.length; ++i){
          that.markers[i].setMap(null);
      }
    }
   that.markers = [];
  },

  startMarkerManager: function(){
    // console.log(this.markers.length);
    // this.markerManager = new MarkerManager(this.map);
    var that = this;
  },

  deleteOverlays: function() {
    var that = this;
    that.markers = [];
  },

  openSideBar: function(company) {
    var that = this;
    var hoodData = "<h1 class='grade'>" + company.neighborhood_grade + "</h1>";
    console.log("The hood data...");
    console.log(hoodData);
    var companyData = that.renderSideBar(company);
    $("#hood-info").children().remove();
    $("#hood-info").append(hoodData);
    $("#biz-info").children().remove();
    $("#biz-info").append(companyData);
  },

  renderSideBar: function(company) {
    return $("<h3>" + company["trade_name"] + "</h3>" +
             "<h3>" + company["letter_grade"] + "</h3>" +
             "<span class='fade'>" + company["street"] + "<br/>" + company["city"] + ", " + company["state"] + " " + company["zip"] + "</span>" +
             "<p>... has " + company["flsa_cl_violtn_count"] + " child labor violations.</p>" +
             "<p>...has paid $" + company["flsa_ot_bw_atp_amt"] + " dollars for violating overtime laws</p>" +
             "<a href='/companies/" + company['id'] + "' alt='" + company['trade_name'] + "'>" + company['trade_name'] + "</a>");
  },
  getNeighborhood: function(latlng, callbacks) {
    geocoder = new google.maps.Geocoder();

    geocoder.geocode({latLng: latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var neighborhood = results[0]["address_components"][2]["short_name"];
        var zip          = results[0]["address_components"][7]["short_name"];

        callbacks.success({neighborhood: neighborhood, zip: zip});
      } else {
        return {error: "Not Available"};
      }
    });
  },
  getTheBounds: function() {
    var bounds = this.map.getBounds();
    var neLat = this.map.getBounds().getNorthEast().lat();
    var neLng = this.map.getBounds().getNorthEast().lng();
    var seLat = this.map.getBounds().getSouthWest().lat();
    var seLng = this.map.getBounds().getSouthWest().lng();
    var centerLat = this.map.getCenter().lat();
    var centerLng = this.map.getCenter().lng();

    return {ne: {lat: neLat, lng: neLng}, sw: {lat: seLat, lng: seLng}, center: {lat: centerLat, lng: centerLng} };
  },
  geolocateUser: function(callbacks) {
    var that = this;
    if(navigator.geolocation) {
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition(function(position) {
        var coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        callbacks.success(coords);
      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
    }
  // Browser doesn't support Geolocation
    else {
      browserSupportFlag = false;
      handleNoGeolocation(browserSupportFlag);
    }
  },
  handleNoGeoLocation: function(errorFlag) {
    if (errorFlag === true) {
      alert("Geolocation service failed.");
    } else {
      alert("Your browser doesn't support geolocation.");
    }
  }
};

$(document).ready(function(){
  MapView.init();
  $( "#pure-stats" ).accordion();
});

