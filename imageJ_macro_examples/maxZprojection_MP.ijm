
run("Bio-Formats Macro Extensions");

dir = getDirectory("Choose a Directory ");
out_dir = dir+"max_projected";
File.makeDirectory(out_dir);

list = getFileList(dir); 
    
for (i=0; i<list.length; i++) {
	
    if (endsWith(list[i], ".nd2")){
    	
    
id = dir+list[i];

print(id);
Ext.setId(id);
Ext.getSeriesCount(seriesCount);
print(seriesCount);

for (s=0; s<seriesCount; s++) {
	
  Ext.setSeries(s);
  Ext.getSeriesName(seriesName);
  print(seriesName);
  
  //run("Bio-Formats Importer", "open='" + id + "' color_mode=Default view=[Hyperstack] stack_order=Default use_virtual_stack series_"+d2s(s+1,0)); 
  //run("Bio-Formats Importer", "open='" + id + "' color_mode=Default view=[Hyperstack] stack_order=Default series_"+d2s(s+1,0)); 
  run("Bio-Formats Importer", "open='" + id + "' color_mode=Default view=[Hyperstack] stack_order=XYCZT series_"+d2s(s+1,0)); 

rename(list[i]+"_s"+d2s(s+1,0));
name = getTitle;
selectWindow(name);

//run("8-bit");

run("Z Project...", "projection=[Max Intensity] all");

selectWindow("MAX_"+name);

Stack.setChannel(1);
run("Magenta");
run("Enhance Contrast", "saturated=0.35");

Stack.setChannel(2);
run("Green");
run("Enhance Contrast", "saturated=0.35");

Stack.setChannel(3);
run("Grays");
run("Enhance Contrast", "saturated=0.35");

Stack.setDisplayMode("composite");

saveAs("Tiff", out_dir+File.separator+"MAX_"+name);
close();
selectWindow(name);
close();
  
call("java.lang.System.gc"); 

}
Ext.close();

    }
}
