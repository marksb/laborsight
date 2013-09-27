function CustomPin(naic) {

  this.image ='/assets/maps/markerRed.png';
  var naic = naic;
  var restaurants = new RegExp(/72\d{4}/);
  var construction = new RegExp(/23\d{4}/);


  if (restaurants.test(naic))
    {
    this.image = '/assets/maps/marker3.png';
    }
  else if (construction.test(naic))
    {
    this.image = '/assets/maps/fast-food-24.png';
    }
   else 
    {
    this.image ='/assets/maps/markerRed.png';
    }  

  this.getImage = function(){
    return this.image
  }

}
