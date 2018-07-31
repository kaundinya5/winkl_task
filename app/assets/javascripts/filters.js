var WINKL = WINKL || {}
WINKL.Filters = new function() {
  this.init = function() {
    
  };
  this.apply = function (){
      $("#js-users-profiles-result").empty();
      var selectedFiltersJSON ={};
      $('input[type=radio]:checked').each(function () {
          var typeOfFilter = $(this).attr('name');
          var valueOfFilter = $(this).val();
          selectedFiltersJSON[typeOfFilter] = valueOfFilter;
      });
      $.ajax({
          url: "/filter",
          type: "GET",
          async: true,
          data: {filter: selectedFiltersJSON},
          dataType: "json"
      }).success(function(data) {
          console.log(data);
          var users = data.users;
          users.forEach(function(v,i){
              var profileCard = '<div class="individual-profile" id="user_id_'+v.id+'">'+
                  '<h5  class="individual-profile-name">'+ v.name+'</h5>'+
                  '<div class="individual-profile-data">'+
                  '<p><span>'+ v.number_of_posts +'</span> Posts</p>'+
                  '<p><span>'+ v.following+'</span> Following</p>'+
                  '<p><span>'+ v.followers+'</span> Followers</p>'+
                  '</div>'+
                  '</div>';
              $("#js-users-profiles-result").append(profileCard)
          });

      });
  }
};