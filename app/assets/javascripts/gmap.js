var MapView = {

  init: function() {
    var mapOptions = {
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.TERRAIN,
        scaleControlOptions: {
      }
    };

    this.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    // set map center
    this.setUserLocation();
    var that = this;

    google.maps.event.addListener(this.map, 'bounds_changed', function() {
      that.getCompanies();
    });
  },
  getCompanies: function() {
    var bounds = this.getTheBounds();
    var that = this;

    $.get('/companies/data', bounds, function(response) {
      for (var i=0; i < response.length; i++) {
        var company = $.parseJSON( response[i] );
        that.renderMarker(company);
      }
    });
  },
  renderMarker: function(company) {
    var that = this;
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(company["latitude"], company["longitude"]),
      map: that.map
    });

    google.maps.event.addListener(marker, 'click', function() {
      that.openSideBar(company);
      console.log(company);
    });
  },

  openSideBar: function(company) {
    var that = this;
    var companyData = that.renderSideBar(company);
    $("#side-bar").children().remove();
    $("#side-bar").append(companyData);
  },

  renderSideBar: function(company) {
    return $("<h1>" + company["trade_name"] + "</h1>" +
             "<h2>" + company["letter_grade"] + "</h2>" +
             "<h2>" + company["street"] + "<br/>" + company["city"] + ", " + company["state"] + " " + company["zip"] + "</h2>" +
             "<p>... has " + company["flsa_cl_violtn_count"] + " child labor violations.</p>" +
             "<p>...has paid $" + company["flsa_ot_bw_atp_amt"] + " dollars for violating overtime laws</p>" +
             "<a href='/companies/" + company['id'] + "' alt='" + company['trade_name'] + "'>" + company['trade_name'] + "</a>")
  },

  getTheBounds: function() {
    var bounds = this.map.getBounds();

    var neLat = this.map.getBounds().getNorthEast().lat();
    var neLng = this.map.getBounds().getNorthEast().lng();
    var seLat = this.map.getBounds().getSouthWest().lat();
    var seLng = this.map.getBounds().getSouthWest().lng();

    return {ne: {lat: neLat, lng: neLng}, sw: {lat: seLat, lng: seLng}};
  },
  setUserLocation: function() {
    var that = this;

    if(navigator.geolocation) {
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition(function(position) {
        initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
        that.map.setCenter(initialLocation);

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
});

