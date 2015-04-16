/*
* JavaScript eye tracking library developed
* during the NASA Space Apps Challenge
* https://github.com/Makeroni/Eye-of-Horus
*
* Copyright 2015, Borja Latorre
* Copyright 2015, Jose Luis Berocal
*
* Licensed under the GNU GPL version 3.0
* http://opensource.org/licenses/GPL-3.0
*/

// Image analysis parameters
var pupilMinLuminance =   45;
var pupilMaxLuminance =   50;
var pupilMinSize      =  400;
var pupilMaxSize      = 3000;

// Pupil mobility area
var pupilP1x =   0, pupilP1y =   0;
var pupilP2x = 320, pupilP2y =   0;
var pupilP3x = 320, pupilP3y = 240;
var pupilP4x =   0, pupilP4y = 240;

/*
* Segmentation enumerating all compact groups
*
* Input matrix must contain the following values:
*   0: void
*   1: group kernel
*   2: group boundary (optional)
*
*  Groups are numbered from 3 as shown bellow:
*
*   | 1 2 0 0 1 |       | 3 3 0 0 4 |
*   | 0 0 0 0 1 |       | 0 0 0 0 4 |
*   | 0 2 1 0 1 |  -->  | 0 5 5 0 4 |
*   | 0 2 2 0 0 |       | 0 5 5 0 0 |
*   | 0 0 0 0 2 |       | 0 0 0 0 0 |
* 
*/

function segmentation(matrix, w, h)
{
	// First group has id 3 as lower vales are reseved
	var id = 3, k = 0;

	// Matrix elements
	var n = w * h;

	// Array to store groups size
	var groupSize = new Array(256);

	// Read matrix
	for (var j = 0; j < h ; j++)
	{
		for (var i = 0; i < w ; i++)
		{
			// If a kernel is found
			if(matrix[k++] == 1)
			{
				// Grow the group and store its size
				groupSize[id] = morfologyGrow(matrix, w, h, i, j, id);
				id++;
			}
		}
	}

	// Locate the pupil among the found groups
	var pupilId = 0, pupilSize;
	for (var i = 3; i <= id ; i++)
	{
		if(groupSize[i] > pupilMinSize && groupSize[i] < pupilMaxSize)
		{
			pupilId = i;
		}
	}

	// Compute the pupil center of mass
	var cx = 0, cy = 0;
	if(pupilId > 0)
	{
		pupilSize = groupSize[pupilId];

		k = 0;
		for (var j = 0; j < h ; j++)
		{
			for (var i = 0; i < w ; i++)
			{
				if(matrix[k++] == pupilId)
				{
					cx = cx + i;
					cy = cy + j;
				}
			}
		}
		cx = cx / pupilSize;
		cy = cy / pupilSize;

		pupilPx = cx / 320;
		pupilPy = cy / 240;

		if(captureMouse)
		{
			$.get('php/xdotool.php?x=' + 
				parseFloat(pupilPx).toFixed(3) + '&y=' +
				parseFloat(pupilPy).toFixed(3), null);
		}

		// Update UI
		$("#cx").text('x: ' + parseFloat(pupilPx).toFixed(3));
		$("#cy").text('y: ' + parseFloat(pupilPy).toFixed(3));
		$("#size").text('size: ' + pupilSize);

		// Mark a cross in the pupil center
		cx = parseInt(cx);
		cy = parseInt(cy);
		for (var i = 1; i < 4 ; i++)
		{
			matrix[cx + (cy + i) * w] = 1;
			matrix[cx + (cy - i) * w] = 1;
			matrix[cx + i + cy * w] = 1;
			matrix[cx - i + cy * w] = 1;
		}

		return 1;
	}

	return 0;
}

// Grow group from a kernel and mark with id
function morfologyGrow(matrix, w, h, i, j, id)
{
	var x, y, p1, p2;

	// Add the first element to the list
	p1 = i + j * w;
	var list = [p1];
	var size = 1;
	var next = 0;

	// Mark as done
	matrix[p1] = id; 

	while( size > next )
	{
		// Process the current element
		p1 = list[next];
		y = Math.floor(p1 / w);
		x = Math.floor(p1 - y * w);

		// Add not explored neighbors to the list
		// Try left
		p2 = p1 - w;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		// Try right
		p2 = p1 + w;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		// Try down
		p2 = p1 - 1;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		// Try up
		p2 = p1 + 1;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}

		// Parse next element
		next++;
	}

	// Return group size
	return size;
}

// Global counter for offline analysis
var offlineFrame = 12;

// Analyze a video stream for eye tracking
function processStream()
{
	// Image luminance matrix
	var luminanceMatrix = new Array(320 * 240);

	// Get the canvas element
	var elem = document.getElementById('eyeCanvas');

	// Get canvas 2d context
	var context = elem.getContext('2d');

	// Create new image
	var img = new Image();

	// Once it's loaded analyze
	img.addEventListener('load', function () {
		var x = 0, y = 0;

		// Draw the image on canvas
		context.drawImage(this, x, y);

		// Read the pixel values
		var imgd = context.getImageData(x, y, this.width, this.height);
		var pix = imgd.data;
		var luminance;

		// Threshold luminance
		for (var i = 0, j = 0, n = pix.length; i < n; i += 4, j++)
		{
			luminance = ( pix[i] + pix[i+1] + pix[i+2] ) / 3;
			if(luminance < pupilMinLuminance)
			{
				luminanceMatrix[j] = 1;
			}
			else if(luminance < pupilMaxLuminance)
			{
				luminanceMatrix[j] = 2;
			}
			else
			{
				luminanceMatrix[j] = 0;
			}
		}

		// Clear matrix border to avoid overflows
		for (var i = 0, n = this.width * this.height; i < this.width; i++)
		{
			luminanceMatrix[i] = 0;
			luminanceMatrix[n-1-i] = 0;
		}
		for (var i = 0; i < this.height; i++)
		{
			luminanceMatrix[i *  this.width] = 0
			luminanceMatrix[(i + 1) * this.width - 1] = 0;
		}

		// Segment matrix
		if(segmentation(luminanceMatrix, this.width, this.height))
		{
			// Colorize groups
			for (var i = 0, j = 0, n = pix.length; i < n; i += 4, j++)
			{
				// Mark detected groups with blue
				if(luminanceMatrix[j] > 1)
				{
					pix[i+0] = 255;
					pix[i+1] =   0;
					pix[i+2] =   0;
					pix[i+3] =  64;
				}
				// Mark pupil center with green
				else if(luminanceMatrix[j] == 1)
				{
					pix[i+0] =   0;
					pix[i+1] = 255;
					pix[i+2] =   0;
					pix[i+3] = 255;
				}
				// The rest is transparent
				else
				{
					pix[i+0] = 255;
					pix[i+1] = 255;
					pix[i+2] = 255;
					pix[i+3] =   0;
				}
			}

			// Draw the ImageData object.
			context.putImageData(imgd, x, y);
		}

		// Process next frame in offline analysis
		if(!onlineMode)
		{
			offlineFrame = offlineFrame + 0.1;
			if(offlineFrame > 45)
			{
				offlineFrame = 0;
			}
		}

		// Main loop without blocking the UI
		setTimeout(processStream, 1);

	}, false);

 	// Video stream source in online mode
	if(onlineMode)
	{
		var rnd = Math.random();
		img.src = 'php/proxy.php?' + rnd;
		$("#eyeImg").attr("src", 'php/proxy.php?' + rnd);
	}
	// Video stream source in offline mode
	else
	{
	    img.src = 'img/offline-frame-' + parseInt(offlineFrame) + '.jpg';
	    $("#eyeImg").attr("src", 'img/offline-frame-' + parseInt(offlineFrame) + '.jpg');
	}

}

// Pupil position
var pupilPx, pupilPy;

// Online mode
var onlineMode = 0;

// Capture mouse
var captureMouse = 0;

// Start processing once the page is loaded
window.addEventListener('load', function ()
{
	setTimeout(processStream, 1);
});

