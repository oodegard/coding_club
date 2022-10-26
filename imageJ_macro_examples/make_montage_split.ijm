
// Import sample image
// Remove these two lines for use on 
run("Close All");
run("Fluorescent Cells");

run("Duplicate...", "title=duplicate_image duplicate");

selectWindow("duplicate_image");
run("Split Channels");

// Change lookup table for all images
// This will only work if number of channels = 3
selectWindow("C1-duplicate_image");
run("Enhance Contrast", "saturated=0.35");
run("Magenta");

selectWindow("C2-duplicate_image");
run("Enhance Contrast", "saturated=0.35");
run("Green");

selectWindow("C3-duplicate_image");
run("Enhance Contrast", "saturated=0.35");
run("Cyan");

// Make an overlay image
run("Merge Channels...", "c1=C1-duplicate_image c2=C2-duplicate_image c3=C3-duplicate_image keep");

// Make a stack not a multichannel image
selectWindow("RGB");
rename("RGB_duplicate_image");
run("Images to Stack", "  title=duplicate_image use"); // will combine all images with the phrase duplicate_image in its tile

// Make the montage
run("Make Montage...", "columns=4 rows=1 scale=0.50");

// Close Stack window
selectWindow("Stack");
run("Close");

// Homework
// 1) This script will not work if there are less or more than 3 channels
// Can you try to fix this

// 2) What happens to this script if you have more than one z slice?

// 3) Can you change the code so that it will work on your images?

