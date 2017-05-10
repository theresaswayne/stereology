# random_ROI.py
# ImageJ Python (Jython) script by Theresa Swayne, Columbia University, 2016
# Purpose:  Select random ROIs from a grid produced by EPFL VSI Reader

# to start with, open your VSI and select a rectangular area of tissue, then click Grid.
# if you have a lot of ROIs that have no tissue, delete these before running

from ij import IJ
from ij.plugin.frame import RoiManager
from ij.gui import Roi

rm = RoiManager.getInstance()
if not rm:
  rm = RoiManager()

# number of squares in the grid = number of values to choose from
gridSquares = rm.getCount()

# number of fields you need (must be <= gridSquares)
fieldsNeeded = 6

# get path for temp file

import os
from ij.io import DirectoryChooser

dc = DirectoryChooser("Pick folder for saving ROI temp file")
folder = dc.getDirectory()

# make a list of random integers
# ROI manager indices start with 0

from java.util import Random
import random

fields = random.sample(range(0, gridSquares), fieldsNeeded)
# print fields

# convert the list to an array that is usable by ROI Manager

from array import array

aFields = array('i', [0] * fieldsNeeded)
aFields = fields

# select the rois and save as temp

rm.setSelectedIndexes(aFields)
rm.runCommand("save selected", os.path.join(folder, "selected.zip"))

# reset ROI mgr, open the temp

rm.reset()
rm.runCommand("Open", os.path.join(folder, "selected.zip"))

# rename the remaining ROIs so that VSI can deal with them
# i is the index within ROI Mgr. i+1 is the number given by VSI Reader

# get base name of ROIs
# searching the last 5 characters for the hashmark because there are usually 2 in the ROI name

oldname = rm.getName(0)
hashPos = oldname.find("#",-5) + 1
# print hashPos
basename = oldname[0:hashPos]
# print "Basename is " + basename

nROIs = rm.getCount()

for i in range(0, nROIs):
  roiNum = i + 1
  rm.select(i)
  rm.runCommand("Rename", basename + str(roiNum))
  rm.deselect()

rm.runCommand("Save", os.path.join(folder, "renamed.zip"))

# finally, user should select all the ROIs and click Extract Current Image
# and save a copy with the overlay of ROIs
# for serial sections, use a large thumbnail to make ROIs. 
# Re-open the "renamed" file and the 2nd series, activate ROIs on the other series image, adjust positions, RENAME TO SERIES 2 and extract
 
