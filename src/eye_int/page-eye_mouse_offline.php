<div class="row">
    <div class="col-md-12">
        <h3 class="page_title">EYE INTERFACE CALIBRATION</h3>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <img id="img" width="320" height="240" src="img/test-8.jpg">
    </div>
    <div class="col-md-4">
        <canvas id="myCanvas" width="320" height="240"></canvas>
    </div>
    <div class="col-md-4">
        <span class="label label-primary">DETECTED COORDINATES</span>
        <br><br>

        <div class="coordinates">
            <p id="cx" class="label label-info"></p>
            <br><br>

            <p id="cy" class="label label-info"></p>
            <br><br>

            <p id="size" class="label label-info"></p>
            <br><br>
        </div>

    </div>
</div>
<hr>
<div class="row">
    <div class="col-md-4 settings">
        <span class="label label-primary">SETTINGS</span>
        <br><br>
        <span>Luminosity Min</span>
        <input type="range" id="level1" value="30" min="0" max="255">
        <br>
        <span>Luminosity Max</span>
        <input type="range" id="level2" value="50" min="0" max="255">
        <br>
        <span>Size Max</span>
        <input type="range" id="size1"  value="500" min="0" max="1000">
        <br>
        <span>Size Min</span>
        <input type="range" id="size2" value="3000" min="0" max="5000">
    </div>
    <div class="col-md-4">
        <span class="label label-primary">SET WORKING AREA</span>
        <br><br>
        <input type="button" class="btn btn-info" value="c1" id="c1">
        <input type="button" class="btn btn-info" value="c2" id="c2"></br></br>
        <input type="button" class="btn btn-info" value="c3" id="c3">
        <input type="button" class="btn btn-info" value="c4" id="c4">
        <br><br>
    </div>
    <div class="col-md-4">
        <span class="label label-primary">SYSTEM ENABLE</span>
        <br><br>
        <input type="checkbox" id="start_button">
        <br><br>
    </div>
</div>


