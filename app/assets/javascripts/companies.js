var Company = {
  getWithinBounds: function(bounds, callback) {
    $.get('/companies/data', bounds, function(response) {
      callback(response)
    });
  }
}
