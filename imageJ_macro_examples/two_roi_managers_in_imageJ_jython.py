from ij.gui import Roi
from ij.plugin.frame import RoiManager
from ij import IJ


IJ.run("Close All", "")	
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif");
imp.show()

def showRoiInManager(rm):
	# Function that open a display Roi Manager and adds a hidden roi manager object to it
	# rm needs to have been started with RoiManager(False) call

	# Make visible Roi Manager
	rm_display = RoiManager.getRoiManager()
	rm_display.show()
	rm_display.reset()
	
	for r in rm.getRoisAsArray():
		rm_display.addRoi(r)
	

rm1 = RoiManager(False)
rm2 = RoiManager(False)

rm1.addRoi(Roi(0,0,10,10))
rm1.addRoi(Roi(0,0,20,30))





rm2.addRoi(Roi(10,10,10,10))
rm2.addRoi(Roi(10,10,20,30))
rm2.addRoi(Roi(10,10,40,15))

print( "RM1: " + str(rm1))
print( "RM2: " + str(rm2))

showRoiInManager(rm2)



	
	
	