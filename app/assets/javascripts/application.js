//= require jquery
//= require jquery_ujs
//= require_tree .

function getCompanyInfo(id){
  $.get('/companies/' + id + '/chart', function(response){
    createChart();
  });
}

function myTabs() {
  $( "#pure-stats" ).tabs({
  });
};

function stateOnClick(){
  $('#state').on('click', function(event){
    console.log("whatup");
    event.preventDefault();
    $(this).addClass('selected');
  });
};

$( document ).ready(function() {
  MapView.init();
  myAccordion();
  stateOnClick();
});
