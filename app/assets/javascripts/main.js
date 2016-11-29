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




});
