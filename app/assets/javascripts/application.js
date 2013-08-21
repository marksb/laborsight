//= require jquery
//= require jquery_ujs
//= require_tree .

function createChart(){
  var ctx = document.getElementById("local-chart").getContext("2d");

  var data = {
      labels : ["January","February","March","April","May","June","July"],
      datasets : [
                  {
                      fillColor : "rgba(221, 86, 66, 0.5)",
                      strokeColor : "rgba(221, 86, 66, 1)",
                      data : [65,59,90,81,56,55,40]
                  },
                  {
                      fillColor : "rgba(93, 124, 168, 0.5)",
                      strokeColor : "rgba(93, 124, 168, 1)",
                      data : [28,48,40,19,96,27,100]
                  }
                 ]
            };

  options = {
      barDatasetSpacing : 15,
      barValueSpacing: 10
  };

    new Chart(ctx).Bar(data, options);
 }

     function accordion() {
      $( "#pure-stats" ).accordion({
        collapsible: true,
        autoHeight: false,
        active: false
      });
    };