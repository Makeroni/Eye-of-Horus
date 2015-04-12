$().ready(function(){
    //Send the value selected in the input range
    $('#level1').on('input',function(){
        level1 = $('#level1').val();
    });
    $('#level2').on('input',function(){
        level2 = $('#level2').val();
    });
    $('#size1').on('input',function(){
        size1 = $('#size1').val();
    });
    $('#size2').on('input',function(){
        size2 = $('#size2').val();
    });

    //Switch control formatting
    $("#start_button").bootstrapSwitch();

    //System enable button
    $('#start_button').on('switchChange.bootstrapSwitch', function(event, state) {
        console.log(this); // DOM element
        console.log(event); // jQuery event
        console.log(state); // true | false
    });

    //Working area setting
    $('#c1').click(function(){
        console.log('c1 clicked!');
    });
    $('#c2').click(function(){
        console.log('c2 clicked!');
    });
    $('#c3').click(function(){
        console.log('c3 clicked!');
    });
    $('#c4').click(function(){
        console.log('c4 clicked!');
    });
});
