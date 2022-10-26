
// Import sample image
// Remove these two lines for use on 
run("Close All");
run("Fluorescent Cells");

run("Duplicate...", "title=duplicate_image duplicate");

// Split channels
selectWindow("duplicate_image");
run("8-bit");

// Change lookup table for all images
// This will only work if number of channels = 3
Stack.setChannel(1);
run("Enhance Contrast", "saturated=0.35");
run("Magenta");

Stack.setChannel(2);
run("Enhance Contrast", "saturated=0.35");
run("Green");

Stack.setChannel(3);
run("Enhance Contrast", "saturated=0.35");
run("Cyan");

// make a duplicate that will be used to make an overlay
run("Duplicate...", "title=Overlay duplicate");

// Split channles
selectWindow("duplicate_image");
run("Split Channels");

// Make an overlay image
// I do this after i make the split, so that this image will come after the since channel images in the stack/montage
selectWindow("Overlay");
run("Flatten");
rename("C4_duplicate_image"); // Rename image so that it has the word duplicate_image in the title

// Make a stack from all channels and overlay image
run("Images to Stack", "  title=duplicate_image use"); // will combine all images with the phrase duplicate_image in its tile

// Make the montage
// This also converts all images to RGB if one of them is RGB
run("Make Montage...", "columns=4 rows=1 scale=0.50");

// Close tmp windows
selectWindow("Stack");
run("Close");
selectWindow("Overlay");
run("Close");

// Homework
// 1) This script will not work if there are less or more than 3 channels
// Can you try to fix this

// 2) What happens to this script if you have more than one z slice?

// 3) Can you change the code so that it will work on your images?

