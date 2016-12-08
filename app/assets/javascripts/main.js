$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();


    $(".slider-input").slider({
            min: 1,
            max: 100,
            value: [ 100 ],
            step: 0.5,
            slide: function(event, ui) {
                $(this).next('input').val(ui.value);
                $(this).parent().find('span.slider-value').html(ui.value);
            }
    });

    function setHeight() {
     windowHeight = $(window).innerHeight();
     $('.side_container').css('min-height', windowHeight);
     };
     setHeight();

     $(window).resize(function() {
       setHeight();
     });



});
