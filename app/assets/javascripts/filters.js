var WINKL = WINKL || {}
WINKL.Filters = new function() {
  this.init = function() {
    
  };
  this.apply = function (){
       var selectedFiltersJSON ={};
      $('input[type=radio]:checked').each(function (val,index) {
          console.log(val)
          console.log(index)
      })
  }
};