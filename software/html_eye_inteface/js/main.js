$().ready(function(){
    //Send the value selected in the input range
    $('#level1').on('input',function(){
        pupilMinLuminance = $('#level1').val();
    });
    $('#level2').on('input',function(){
        pupilMaxLuminance = $('#level2').val();
    });
    $('#size1').on('input',function(){
        pupilMinSize = $('#size1').val();
    });
    $('#size2').on('input',function(){
        pupilMaxSize = $('#size2').val();
    });

    //Switch control formatting
    $("#captureMouse").bootstrapSwitch();

    //System enable button
    $('#captureMouse').on('switchChange.bootstrapSwitch', function(event, state) {
        if(state)
		{
			captureMouse = 1;
		}
		else
		{
			captureMouse = 0;
		}
    });

    //Switch control formatting
    $("#onlineMode").bootstrapSwitch();

    //System enable button
    $('#onlineMode').on('switchChange.bootstrapSwitch', function(event, state) {
        if(state)
		{
			onlineMode = 1;
		}
		else
		{
			onlineMode = 0;
		}
    });

    //Working area setting
    $('#c1').click(function(){
        pupilP1x = pupilPx;
		pupilP1y = pupilPy;
    });
    $('#c2').click(function(){
        pupilP2x = pupilPx;
		pupilP2y = pupilPy;
    });
    $('#c3').click(function(){
        pupilP3x = pupilPx;
		pupilP3y = pupilPy;
    });
    $('#c4').click(function(){
        pupilP4x = pupilPx;
		pupilP4y = pupilPy;
    });
});
