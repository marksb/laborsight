//= require jquery
//= require jquery_ujs
//= require_tree .


// function getCompanyInfo(id){
//   $.get('/companies/' + id + '/chart_industry', function(response){
//     createChart();
//   });
// }

function myTabs() {
  $( "#pure-stats" ).tabs({
  });
};

function stateOnClick(){
  $('#slider a').on('click', function(event){
    event.preventDefault();
    $('#slider a').removeClass('selected');
    $(this).addClass('selected');
  });
};

function industryOnLoad(){
  $.get('/companies/' + id + '/chart_industry', function(response){
    createChart();
  });
}

function renderChart(){
    $("nav #industry").on('click', function() {
    $.get('/companies/' + id + '/chart_industry', function(response){
    createChart();
    });
  });

  $("nav #state").click(function() {
    $.get('/companies/' + id + '/chart_local', function(response){
    createChart();
    });
  });

  $("nav #national").click(function() {
    $.get('/companies/' + id + '/chart_national', function(response){
    createChart();
    });
  });
}

$(document).ready(function(){
  MapView.init();
});
