
// contributed on IJ forum by Jan Eglinger
// modified by Theresa Swayne
// before running the macro, draw an ROI on an RGB image with grid overlay (use black crosses)

run("Flatten");
run("8-bit");
run("Restore Selection");
setThreshold(0, 1); 
run("Analyze Particles...", "size=4-32 clear summarize");
