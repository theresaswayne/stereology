Information on stereology scripts
==================================

These scripts are designed to assist with performing unbiased stereology using the Fiji distribution of ImageJ.

## Credits

These scripts were written or modified, as noted, by Theresa Swayne, Ph.D., Columbia University, New York, NY, USA. This work is licensed under a Creative Commons Attribution-NonCommercial 3.0 Unported License. If you use the material, please [read the license](https://creativecommons.org/licenses/by-nc/3.0/) and give credit appropriately.

The original [Multipurpose Grid macro](https://imagej.nih.gov/ij/macros/Multipurpose_grid.txt) was written by Aleksandr Mironov.

## Installation

### For jython scripts (.py):

Use the [Fiji](http://imagej.net/Fiji) distribution of ImageJ. Plain ImageJ does not support Jython.

To run the script from anywhere on your computer, open Fiji, `File > Open`, select the script, and click `Run`.

To install so that the command appears in the ImageJ menu, follow instructions [here](http://imagej.net/Installing_3rd_party_plugins).

### For ImageJ1 macros (.ijm):

Use Fiji or plain ImageJ.

To run the macro from anywhere on your computer, open Fiji, `File > Open`, select the script, and click `Run`.

To install so that the command appears in the ImageJ menu, follow instructions [here](http://imagej.net/Installing_3rd_party_plugins).

### For Batch commands (.txt):

Use Fiji or plain ImageJ.

*Note that `batch apply grid.txt` requires the macro `Multipurpose_gridMod.ijm` to be installed in the plugins folder!*

1. Open the Batch Macro command (`Process > Macro...`).
2. Set the `Input` folder to the folder containing the images you want to process. All files in the folder will be processed.
1. Set the `Output` folder to a *different* folder where you would like the results to be saved.
1. Click `Open` and select the .txt file.
1. Click `Process`.

## Sample workflow

Here is one way to use these scripts.

1. Open a slide scanner image using [VSI Reader](http://biop.epfl.ch/TOOL_VSI_Reader.html), and create a grid of ROIs.
1. Use `random_ROI.py` to select a subset of the tissue for analysis.
1. Use `batch apply grid.txt` to overlay a non-destructive counting grid on the set of images.
1. During counting, if you have a large area containing many points, use `cross_count.ijm` to count black crosses within the area.

## Limitations

* To change the number of fields or grid characteristics you need to edit the scripts.
* Cross counting works only with black crosses, and assumes there is no black in the image.

## Disclaimer

I have tested these at the time of uploading. If you find a bug, please contact me.

## Contact

Theresa Swayne, Ph.D., [Confocal and Specialized Microscopy Shared Resource](http://www.hiccc.columbia.edu/research/sharedresources/confocal), Columbia University
