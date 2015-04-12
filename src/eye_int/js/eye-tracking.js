
var level1 = 30;
var level2 = 50;
var size1 =  500;
var size2 = 3000;
var imgn = 8;
var matrix = new Array(320 * 240);

var col_r = new Array(200);
var col_g = new Array(200);
var col_b = new Array(200);

col_r[0] = 255;
col_g[0] = 255;
col_b[0] = 255;
col_r[1] = 0;
col_g[1] = 0;
col_b[1] = 0;
col_r[2] = 255;
col_g[2] = 255;
col_b[2] = 255;
for (var i = 3; i < 200 ; i++)
{
	col_r[i] = Math.floor(Math.random() * 256);
	col_g[i] = Math.floor(Math.random() * 192);
	col_b[i] = Math.floor(Math.random() * 256);
}

function grow(matrix, w, h, i, j, id)
{
	var x, y, p1, p2;

	// Add the fist item to the list
	p1 = i + j * w;
	var list = [p1];
	var size = 1;
	var next = 0;

	// Mark as done
	matrix[p1] = id; 

	while( size > next )
	{
		// Process the first item
		p1 = list[next];
		y = Math.floor(p1 / w);
		x = Math.floor(p1 - y * w);

		// Add not explored neighbors to the list
		p2 = p1 - w;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		p2 = p1 + w;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		p2 = p1 - 1;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}
		p2 = p1 + 1;
		if( matrix[p2] == 1 || matrix[p2] == 2 )
		{
			list.push(p2);
			size++;
			matrix[p2] = id;
		}

		// Parse next element of the list
		next++;
	}

	return size;
}

function segment(matrix, w, h)
{
	var id = 3, k = 0;
	var n = w * h;
	var size = new Array(256);
	for (var j = 0; j < h ; j++)
	{
		for (var i = 0; i < w ; i++)
		{
			if(matrix[k++] == 1)
			{
				size[id] = grow(matrix, w, h, i, j, id);
				id++;
			}
		}
	}
	var maxsize = 0, maxid;
	for (var i = 3; i <= id ; i++)
	{
		if(size[i] > maxsize && maxsize < size2)
		{
			maxsize = size[i];
			maxid = i;
		}
	}
	if(maxsize > size1)
	{
		var cx=0, cy=0;
		k = 0;
		for (var j = 0; j < h ; j++)
		{
			for (var i = 0; i < w ; i++)
			{
				if(matrix[k++] == maxid)
				{
					cx = cx + i;
					cy = cy + j;
				}
			}
		}
		cx = cx / maxsize;
		cy = cy / maxsize;
		$("#cx").text('pos-x: '+parseInt(cx));
		$("#cy").text('pos-y: '+parseInt(cy));
		$("#size").text('size: '+maxsize);
		matrix[parseInt(cx+1)+parseInt(cy) * w] = 1;
		matrix[parseInt(cx-1)+parseInt(cy) * w] = 1;
		matrix[parseInt(cx)+parseInt(cy+1) * w] = 1;
		matrix[parseInt(cx)+parseInt(cy-1) * w] = 1;
		matrix[parseInt(cx+1)+parseInt(cy+1) * w] = 1;
		matrix[parseInt(cx-1)+parseInt(cy-1) * w] = 1;
		matrix[parseInt(cx-1)+parseInt(cy+1) * w] = 1;
		matrix[parseInt(cx+1)+parseInt(cy-1) * w] = 1;
	}
}

function processImage()
{

	imgn = imgn + 0.1;
	if(imgn>=56){imgn=8;}

	// Get canvas element
	var elem = document.getElementById('myCanvas');
	if (!elem || !elem.getContext)
	{
		//return;
	}

	// Get canvas 2d context
	var context = elem.getContext('2d');
	if (!context || !context.getImageData || !context.putImageData || !context.drawImage) {
		//return;
	}

	// Create new image
	var img = new Image();

	// Once it's loaded analyze
	img.addEventListener('load', function () {
		var x = 0, y = 0;

		// Draw the image on canvas
		context.drawImage(this, x, y);

		// Get the pixels
		var imgd = context.getImageData(x, y, this.width, this.height);
		var pix = imgd.data;
		var grey;

		// Compute threshold
		for (var i = 0, j = 0, n = pix.length; i < n; i += 4, j++)
		{
			grey = (pix[i] + pix[i+1] + pix[i+2]) / 3;
			if(grey < level1)
			{
				matrix[j] = 1;
			}
			else if(grey < level2)
			{
				matrix[j] = 2;
			}
			else
			{
				matrix[j] = 0;
			}
		}

		// Clean border
		for (var i = 0, n = this.width * this.height; i < this.width; i++)
		{
			matrix[i] = 0;
			matrix[n-1-i] = 0;
		}
		for (var i = 0; i < this.height; i++)
		{
			matrix[i *  this.width] = 0
			matrix[(i + 1) * this.width - 1] = 0;
		}

		segment(matrix, this.width, this.height);

		// Draw groups
		for (var i = 0, j = 0, n = pix.length; i < n; i += 4, j++)
		{
			pix[i+0] = col_r[matrix[j]];
			pix[i+1] = col_g[matrix[j]];
			pix[i+2] = col_b[matrix[j]];
		}

		// Draw the ImageData object.
		context.putImageData(imgd, x, y);

		setTimeout(processImage, 1);

	}, false);

	//Test mode
    img.src = 'img/test-'+parseInt(imgn)+'.jpg';
    $("#img").attr("src", 'img/test-'+parseInt(imgn)+'.jpg');
    //Live mode
	//var rnd = Math.random();
	//img.src = 'php/proxy.php?'+rnd;
	//$("#img").attr("src", 'php/proxy.php?'+rnd);
}

window.addEventListener('load', function ()
{
	setTimeout(processImage, 1);
});

