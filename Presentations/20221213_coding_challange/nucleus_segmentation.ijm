#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

/*
 * If there is a file called processing_parameters.yml in the output folder those settings will be used
 * If not, use will be asked to fill it in
 * file should contain e.g.: 
 * nuc_ch: 3
 * min_nuc_size: 200
 */

main();

function main(){
	// Initiate
	run("Close All");
	run("Clear Results");
	Table.create("Results");
	
	// Read parameter file
	parameters = getParameters();
	nuc_ch = parameters[0];
	min_nuc_size = parameters[1];
	
	// Run
	processFolder(input);
	saveAs("Results", output + File.separator + "Results.csv");
	
	if(!File.exists(output + File.separator + "processing_parameters.yml")){
		processing_parameters = "nuc_ch: " + nuc_ch + "\n" + "min_nuc_size: " + min_nuc_size + "\n";
		File.saveString(processing_parameters, output + File.separator + "processing_parameters.yml");
	}
}




// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// open nucleus channel image
	open(input + File.separator + file);
	out_basename = File.nameWithoutExtension; // Basename used for saving later
	run("Duplicate...", "duplicate channels=" + nuc_ch);
	
	// Locate nuclei and add to ROI manager
	run("Auto Threshold", "method=Otsu white");
	run("Analyze Particles...", "size=" + min_nuc_size + "-Infinity exclude add");
	
	// Let the user evaluate te results
	//waitForUser("Manual curation", "press OK to proceed");
	
	// Close all images
	run("Close All");
	
	nrowResults = Table.size();
	Table.set("File_name", nrowResults, file);
	Table.set("Nuclei", nrowResults, roiManager("count"));
	Table.update;
	
	// Remove old Saved ROI Manager files
	if(File.exists(output + File.separator +  out_basename + ".zip")){
		File.delete(output + File.separator +  out_basename + ".zip");
	}
	if(File.exists(output + File.separator +  out_basename + ".txt")){
		File.delete(output + File.separator +  out_basename + ".txt");
	}
	
	// Save Roi manager file
	if(roiManager("count")>0){		
		roiManager("Deselect");
		roiManager("Save", output + File.separator +  out_basename + ".zip");	
	}else{
		File.saveString("No nucleus detected", output + File.separator +  out_basename + ".txt");
	}
	
	// Clean up ROI Manager 	
	if(roiManager("count")>0){
		roiManager("Deselect");
		roiManager("Delete");
	}
}

function getParameters() {
	file_path = output + File.separator + "processing_parameters.yml"
	return_values = newArray(2);
	check = 0;
	
	if(File.exists(file_path)){
		str = File.openAsString(file_path);
		lines = split(str,"\n");
		
		
		 // Used to check that all required fields are in yml file	
		for (i = 0; i < lines.length; i++) {
			if(startsWith(lines[i], "nuc_ch:")){
				return_values[0] = parseInt(replace(lines[i], "nuc_ch: ", ""));
				check++;
			}
			if(startsWith(lines[i], "min_nuc_size:")){
				return_values[1] = parseInt(replace(lines[i], "min_nuc_size: ", ""));
				check++;
			}		
		}
	}else{
		Dialog.create("Input parameters");
		Dialog.addNumber("Nucleus channel: ", 3);
		Dialog.addNumber("Minimum nucleus size:", 200);
		Dialog.show();
		return_values[0] = Dialog.getNumber();
		return_values[1] = Dialog.getNumber();
		check = 2;
	}
	
	if(check < 2){
		waitForUser();
		exit("Missing parameter file!!");
	}
	
	return return_values;
}
// function description

