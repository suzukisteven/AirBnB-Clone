// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// Initiaize flatpickr object
$(document).on('turbolinks:load',function(){
  flatpickr(".datePicker", {});
})

// Sticky sidebar for listings show page
// $(document).on('turbolinks:load', function () {
//   var top = $('#booking-sidebar').offset().top;
//   $(window).scroll(function (event) {
//     var y = $(this).scrollTop();
//     if (y >= top)
//       $('#booking-sidebar').addClass('fixed');
//     else
//       $('#booking-sidebar').removeClass('fixed');
//     $('#booking-sidebar').width($('#booking-sidebar').parent().width());
//   });
// });

// Ajax for autocomplete search bar and profile delete
$(document).on('turbolinks:load', function(){
  $('.booking-delete').on('click', function(e){
    let bookingId = this.value
    $.ajax({
      url: `/bookings/${bookingId}`,
      method: "DELETE",
      success: function(e){
        e.target.parentElement.parentElement.parentElement.remove()
      }
    })
  })

  $('#main-search').on('keyup', function(){
    let searchData = this.value
    $.ajax({
      url: "/listings/autofill",
      method: "GET",
      data: {searchvalue: searchData },
      dataType: "JSON",
      success: function(data){
        let unique = data.filter((v, i, a) => a.indexOf(v) === i);
        console.log(unique)
        $('#autofill').html("")
        unique.forEach(fill => {
          $('#autofill').append(`<option value="${fill}">`)
        })
      }
    })
  })
})
