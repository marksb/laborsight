//= require jquery
//= require jquery_ujs
//= require_tree .

function getCompanyInfo(id){
  $.get('/companies/' + id + '/chart', function(response){
    createChart();
  });
}

function myAccordion() {
  $( "#pure-stats" ).accordion({
    collapsible: true,
    autoHeight: true,
    active: false
  });
};

function stateOnClick(){
  $('#state').on('click', function(event){
    console.log("whatup");
    event.preventDefault();
    console.log($(this));
    console.log(this);
    $(this).addClass('selected');
  });
};

$( document ).ready(function() {
  MapView.init();
  myAccordion();
  stateOnClick();
});
