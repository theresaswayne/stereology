// paste into the batch macro window, commenting out lines as needed
// For points:

run("Multipurpose gridMod", "set=by_tiles_density random new line_thickness=1 tile=3 encircled dense_points_x4 regular=magenta dense_points_color=black line_color=magenta");


// For lines:

run("Multipurpose gridMod", "set=by_tiles_density random new line_thickness=1 tile=2 regular=black dense_points_color=green horizontal_segmented line_color=black");

/* 
If using point overlays remove the counts thus:
roiManager("Add");
roiManager("Select", 0);
roiManager("Deselect");
roiManager("Delete");
roiManager("Show All");
*/