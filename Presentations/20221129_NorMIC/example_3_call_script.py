import IJ

IJ.run("example 2 script parameters") # Will lauch the GUI
IJ.run("example 2 script parameters", "a=1 b=2 c=3 divide_by=2") # Will run the script without GUI

# PS You can also call the script with missing values. Then the GUI will only ask for the missng parameters

IJ.run("example 2 script parameters", "a=1 b=2 c=3") # Will run the script without GUI

