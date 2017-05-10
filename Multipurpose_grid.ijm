/*Makes grid based on multi-purpose grid from Gundersen & Jensen 
(J Microsc. 1987, 147:229-6) for stereological quantification as 
non-destructive overlay. 
Options include lines and crosses of differnet density.
Do not forget to "Set Scale" to get correct printout of grid parameters.
Parameters of the grid are reflected in the "Multipurpose grid parameters" window.

Grid constant a/l (area per line unit) is used to estimate total lenght
of a flat stucture. Total lenght equals to number of intersections (between 
linear feature and test lines) multiplied by PI/2 times the grid constant a/l.

Area per point can be used to estimate an area in 2D samples or volume density 
in isotropic uniform random sections.

Test line per point (l/p) constant is used to estimate surface density (surface
area per unit volume in isotropic uniform random sections. 

Version: 1.0
Date: 04/09/2014
Author: Aleksandr Mironov amj-box@mail.ru
*/

//help
html = "<html>"
	+"<h1><font color=navy>Multipurpose Stereological Grid</h1>"
	+"<font color=navy>based on Gundersen & Jensen (J Microsc. 1987, 147:229-6)<font color=black><br><br>"
	+"Standard grid tile includes 4 regular points and 2 segmented lines<br><br>"
	+"<b><font color=purple>Grid density</b> can be set by number of tiles or by area per point<br><br>"
	+"<font color=purple><b><u>Options:</u></b><br>"
	+"<b>New Overlay</b> - removes previous overlays<br>"
	+"<b>Random Offset</b> - randomizes grid location<br>"
	+"<b>Tile density</b> - determines density of the grid <br><br>"
	+"<b>Encircled Points</b> - one additional point per grid tile <br>"
	+"<b>Dense Points</b> - 16 additional points per grid tile <br><br>"
	+"<b><u>Points ratio:</u></b><br>"
	+"Encircled:Regular:Dense = 1:4:16<font color=black><br><br>"
	+"<b><font color=red>Set Scale<font color=black></b> to get correct printout of the grid parameters,<br>" 
	+"which are reflected in the 'Multipurpose grid parameters' window<br><br>"
	+"<b><font color=green>Useful parameters:</b><br><br>"
	+"<font color=green> <i><u>Area per point</u></i> can be used to estimate an area in 2D samples<br>" 
	+"or volume density isotropic uniform random sections<br><br>"
	+"<i><u>Test line per point</u></i> constant is used to estimate surface density<br>"
	+"(surface area per unit volume) in isotropic uniform random sections<br><br>"
	+"<i><u>Grid constant a/l (area per line unit)</u></i> is used to estimate total lenght<br>"
	+"of a flat stucture. Total lenght equals to number of intersections<br>"
	+"multiplied by PI/2 times the grid constant a/l<br>"
	
//Initial dialog
Dialog.create("Multipurpose Stereological Grid, ver. 1.0"); 
Dialog.setInsets(0, 20, 0);
Dialog.addChoice("Set grid dimensions:", newArray("by_tiles_density", "by_area_per_point"));
Dialog.addHelp(html);
Dialog.show();
dimensions = Dialog.getChoice();
getPixelSize(unit, pw, ph, pd);

//Main dialog box
Dialog.create("Grid parameters");
Dialog.addMessage("          GENERAL:");
Dialog.addCheckbox("Random Offset", true);
Dialog.addCheckbox("New Overlay", true);
Dialog.addNumber("Line thickness =", 1,0,2,"pixels");
if (dimensions=="by_tiles_density") { 
	Dialog.addNumber("Tile density  =", 3,0,2,"per short side"); 
	} else { 
	Dialog.addNumber("Area per point  =", 10000,2,8," "+unit+"^2"); 
	};  
Dialog.addMessage("          TEST POINTS:");
Dialog.addCheckbox("Encircled Points (1/4 of regular)", true);
Dialog.addCheckbox("Dense Points (x4 of regular)", true);
Dialog.addChoice("Regular points color:", newArray("cyan", "red", "yellow", "green", "blue", "magenta", "orange", "black", "white"));
Dialog.addChoice("Dense points color:", newArray("green", "yellow", "red", "blue", "cyan", "magenta", "orange", "black", "white"));
Dialog.addMessage("          TEST LINES:");
Dialog.addCheckbox("Horizontal segmented", true);
Dialog.addCheckbox("Vertical segmented", false);
Dialog.addCheckbox("Horizontal solid (x3 of segmented)", false);
Dialog.addCheckbox("Vertical solid (x3 of segmented)", false);
Dialog.addChoice("Line color:", newArray("cyan", "red", "green", "magenta", "blue", "yellow", "orange", "black", "white")); 
Dialog.addHelp(html);
Dialog.show(); 

name = getTitle();

//grid parameters 
offset = Dialog.getCheckbox();
new = Dialog.getCheckbox();
t = Dialog.getNumber();
dimens = Dialog.getNumber();
circ = Dialog.getCheckbox();
dense = Dialog.getCheckbox();
rpcolor = Dialog.getChoice(); 
dpcolor = Dialog.getChoice();
hor_seg = Dialog.getCheckbox();
ver_seg = Dialog.getCheckbox();
hor_sol = Dialog.getCheckbox();
ver_sol= Dialog.getCheckbox();
lcolor = Dialog.getChoice();

//initial settings for l/p
vsg=hsg=vsl=hsl=0;

//tile size
getDimensions(width, height, channels, slices, frames);
if (dimensions=="by tiles density") {
	if (width>=height) { 
	ss = height; 
	} else { 
	ss = width; 
	} 
	tileside = ss/dimens;
	}else {
	tileside = sqrt(4*dimens/ph/pw);
	}
pointd = tileside/4;
pointr = tileside/2;

//check overlay
if (new == true) Overlay.remove;

//creating random offset 
off1 = random; 
off2 = random; 
if (offset == false) off1 = off2 = 0.5; 
xoff = round(pointd*off1);
yoff = round(pointd*off2);

setColor(lcolor);
setLineWidth(t);

//Horizonal solid lines
if (hor_sol == true){	
	y = yoff;
	while (true && y<height) { 
		Overlay.drawLine(0, y, width, y);
		Overlay.add;
		y += pointr;
		}
	Overlay.show;
	hsl = 2;
	}

//Vertical solid lines
if (ver_sol == true){
	x = xoff;
	while (true && x<width) { 
		Overlay.drawLine(x, 0, x, height);
		Overlay.add;
		x += pointr;
		}
	Overlay.show;
	vsl = 2;
	}

//Horizonal segmented lines
if (hor_seg == true){
hsg = 1;

//Y loop1
y1 = yoff;
while (y1<height) { 
		
		//X loop1
		x1 = xoff; 
		while (x1<width) {   
			Overlay.drawLine(x1, y1, x1+pointr, y1);
			Overlay.add;
			x1 += tileside;  
		}
	Overlay.show;	 
	y1 += tileside;  
	}
	
//Y loop2
y1 = yoff+pointr;
while (y1<height) { 
 
		//X loop2 
		x2 = xoff;
		x1 = 0;	
		while (x1<width) {   
			Overlay.drawLine(x1, y1, x2, y1);
			Overlay.add;
			x1 = x2 + pointr;
			x2 += tileside;
		}
	Overlay.show; 
	y1 += tileside;  
	}
}

//Vertical segmented lines
if (ver_seg == true){
vsg = 1;

//X loop1
x1 = xoff;
while (x1<width) { 
		
		//Y loop1
		y1 = yoff; 
		while (y1<height) {   
			Overlay.drawLine(x1, y1, x1, y1+pointr);
			Overlay.add;
			y1 += tileside;  
		} 
	Overlay.show;
	x1 += tileside;  
	}
	
//X loop2
x1 = xoff+pointr;
while (x1<width) { 
 
		//Y loop2 
		y2 = yoff;
		y1 = 0;	
		while (y1<height) {   
			Overlay.drawLine(x1, y1, x1, y2);
			Overlay.add;
			y1 = y2 + pointr;
			y2 += tileside;
		} 
	Overlay.show;
	x1 += tileside;  
	}
}
	
 //Regular points

setColor(rpcolor);
//Initial coordinates X
x1 = xoff;
x2 = x1 - pointd/16; 
x3 = x1 + pointd/16;

//X loop 
while (x1<width) { 
 
		//initial coordinates Y 
		y1 = yoff; 
		y2 = y1 - pointd/16; 
		y3 = y1 + pointd/16; 

		//Y loop 
		while (y1<height) {  
		 
			//horizontal line	 
			Overlay.drawLine(x2,y1,x3,y1); 
			Overlay.add; 
			//vertical line 
			Overlay.drawLine(x1,y2,x1,y3); 
			Overlay.add; 	
		y1 += pointr; 
		y2 += pointr; 
		y3 += pointr; 
		} 
	Overlay.show;
	x1 += pointr; 
	x2 += pointr; 
	x3 += pointr; 
	} 

//Dense points 
setColor(dpcolor);
if (dense == true){
	//Initial coordinates X;
	x1 = xoff - pointd/2;
	x2 = x1 - pointd/16; 
	x3 = x1 + pointd/16;
	
	//X loop 
	while (x1<width) { 
 
		//initial coordinates Y 
		y1 = yoff - pointd/2; 
		y2 = y1 - pointd/16; 
		y3 = y1 + pointd/16;
		 
		//Y loop 
		while (y1<height) {  
			//horizontal line	 
			Overlay.drawLine(x2,y1,x3,y1); 
			Overlay.add; 
			//vertical line 
			Overlay.drawLine(x1,y2,x1,y3); 
			Overlay.add; 
		y1 += pointd; 
		y2 += pointd; 
		y3 += pointd; 
		} 
	Overlay.show;
	x1 += pointd; 
	x2 += pointd; 
	x3 += pointd; 
	} 
}

//Encircled points
setColor(lcolor);
if (circ == true){
	
	//Initial coordinates X
	x1 = xoff;
	x2 = x1 - pointd/16;
	
	//X loop 
	while (x2<width) { 
 
		//Initial coordinates Y 
		y1 = yoff; 
		y2 = y1 - pointd/16; 
		 
		//Y loop 
		while (y2<height) {  
			Overlay.drawEllipse(x2, y2, pointd/8, pointd/8);
			Overlay.add; 
		y2 += tileside;  
		}
	Overlay.show;
	x2 += tileside;  
	} 
}

//  Printing the parameters of the grid

window = isOpen("Multipurpose grid parameters"); 
title = "[Multipurpose grid parameters]"; 
if (window == false){  
	run("Text Window...", "name="+ title +"width=60 height=16 menu"); 
	setLocation(0, 0); 
	};
	
print(title, "\nMultipurpose Grid for sample ["+name+"]");  
print(title, "\n\nImage size = "+width+"x"+height+" pixels");
print(title, "\nPixel size = "+pw+" "+unit);
print(title, "\nScale = "+1/pw+" pixels/"+unit);
print(title, "\n\nArea per regular point ="+tileside*tileside*pw*ph/4+"  "+unit+"^2");
if (dense == true){ 
	n = 16;
	}else{
	n = 0;
	};
if (circ == true){ 
	print(title, "\nArea per encircled point ="+tileside*tileside*pw*ph+"  "+unit+"^2"); 
	};
print(title, "\nArea per any point ="+tileside*tileside*pw*ph/(4+n)+"  "+unit+"^2");
	
if (ver_seg && ver_sol == true)
vsg = 0; 
if (hor_seg && hor_sol == true)
hsg = 0; 
z = vsg+hsg+vsl+hsl;
lp = pw*tileside*z;
if (hor_seg || ver_seg ||hor_sol || hor_sol == true){
	print(title, "\nTest line per any point(l/p) ="+lp/(4+n)+"  "+unit);
		if (circ == true){
		print(title, "\nTest line per encircled point(l/p) ="+lp+"  "+unit);
		}
		if (hor_seg || ver_seg ||hor_sol || hor_sol == true){
		print(title, "\nTest line per regular point(l/p) ="+lp/4+"  "+unit);
		}
	print(title, "\nGrid constant a/l = "+2*pw*tileside/z+" "+unit);
	}
print(title, "\n _______________________\n");
