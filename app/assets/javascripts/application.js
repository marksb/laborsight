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
  $('#slider a').on('click', function(event){
    event.preventDefault();
    $('#slider a').removeClass('selected');
    $(this).addClass('selected');
    console.log($('#slider ul'))
    $('#slider ul').hide();
    var id = $(this).attr('id');
    $('slider ul #' + id).show();
  });
};

$( document ).ready(function() {
  MapView.init();
  stateOnClick();
});
