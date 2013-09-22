var MapView = {
  init: function() {
    var mapOptions = {
      zoom: 10,
      maxZoom: 15,
      minZoom: 2,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: style,
      disableDefaultUI: true,
      scaleControlOptions: {
      }
    };

    var that = this;

    this.markers = [];

    this.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    this.infoWindow = new google.maps.InfoWindow({
      content: "",
      size: new google.maps.Size(500,100),
      maxWidth: 500,
    });

    this.placesMarkers = [];

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
    }
  });
    google.maps.event.addListener(that.map, 'idle', function() {
      that.loadData();
    });
    this.search();
  },
  getNeighborhoodGrade: function(neighborhood_info) {
    var that = this;
    var data = neighborhood_info;
    $.get('/companies/neighborhood', data, function(response) {
      that.renderInitialNeighborhoodGrade(response);
    });
  },
  renderInitialNeighborhoodGrade: function(data) {
    var that = this;
    var hoodData = "<h3 class='hood'>" + data.neighborhood + "</h3>" +
    "<h4 class='side-grade'>" + data.grade + "</h4>";
    $("#hood-info").append(hoodData);
  },
  renderPlaceMarker: function(place) {
    var that = this;
    var marker = new google.maps.Marker({
      map: that.map,
      title: place.name,
      position: place.geometry.location
    });

    google.maps.event.addListener(marker, 'click', function() {
      windowOptions = {
        content: place.name,
        size: new google.maps.Size(500,100),
        maxWidth: 300
      };
      var infoWindow = new google.maps.InfoWindow(windowOptions);
    });

    return marker;
  },
  search: function() {
    var that = this;
    var input = (document.getElementById('target'));
    //var autocomplete = new google.maps.places.Autocomplete(input, options);

    var options = {
      types: ['(postal_code)'],
      componentRestrictions: {country: "us"}
    };

    this.searchBox = new google.maps.places.SearchBox(input);

    google.maps.event.addListener(this.searchBox, 'places_changed', function() {
      var places = that.searchBox.getPlaces();

      var bounds = new google.maps.LatLngBounds();

      bounds.extend(places[0].geometry.location);

      that.map.fitBounds(bounds);
      that.map.setZoom(15);
    });

    google.maps.event.addListener(this.map, 'bounds_changed', function() {
      var bounds = that.map.getBounds();
      that.searchBox.setBounds(bounds);
    });
  },
  // TODO: move this out of this object
  loadData: function() {
    var bounds = this.getTheBounds();
    var that = this;
    Company.getWithinBounds(bounds, function(response) {
      that.clearMapMarkers();
      for (var i=0; i < response.length; i++) {
        var company = $.parseJSON( response[i] );
        that.markers.push(that.renderMarker(company));
      }
    that.markerClusterer = new MarkerClusterer(that.map, that.markers, {
        gridSize: 100,
        maxZoom: 14
      });
    });

  },
  renderMarker: function(company) {
    var that = this;

    var customPin = '/assets/maps/markerRed.png';

    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(company["latitude"], company["longitude"]),
      icon: customPin,
      map: that.map
    });

    google.maps.event.addListener(marker, 'click', function() {
      if (that.oldMarker !== undefined) {
        that.oldMarker.setIcon('/assets/maps/markerRed.png');
      }
      that.activeMarker = marker;
      that.activeMarker.setIcon('/assets/maps/marker2.png');
      that.oldMarker = that.activeMarker;
      that.showInfoBox(company, that.activeMarker);
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
  deleteOverlays: function() {
    var that = this;
    that.markers = [];
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
  showInfoBox: function(company, marker) {
    var that = this;
    
    var contentString = "<div id='info-box' class='title-case'><h4>"
    + company.trade_name + "<hr class='divider'></h4> <span class='fade'>"
    + company["street"] + "<br/>" + company["city"] + ", "
    + company["state"] + " " + company["zip"] + "</span> <h2 class='popup-grade'>" + company.letter_grade + "</h2></div>" +
    "<a class='more-info title-case' href='/companies/" + company['id'] + "' alt='More information on" + company['trade_name'] + "'> More information on " + company['trade_name'] + "</a>";
    that.infoWindow.setContent(contentString);
    that.infoWindow.open(this.map, marker);
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
        var coords = new google.maps.LatLng(38.91775, -77.03624);
        callbacks.success(coords);
      });
    }
  }
};

$(document).ready(function(){
  myTabs(); // Tabs MUST be called within this document.ready
  stateOnClick();
  industryOnLoad();
  renderChart();
});



