function CustomPin(naic) {

  this.image ='/assets/maps/markerRed.png';
  var naic = naic;

  if (naic === 722211)
    {
    this.image = '/assets/maps/marker2.png';
    };
   

  this.getImage = function(){
    return this.image
  }

}
