dir = getDirectory("image"); 
  name = getTitle;
  dotIndex = indexOf(name, ".czi"); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  name2 = title+"_Normalized";
  name2_2 = name2+".tif";
  name3 = title+"_Normalized_masked";
  name3_2 = name3+".tif";
  path_Normalized = dir+name2;
  path_Normalized_masked = dir+name3; 
  channel1_name = "C1-"+name; //euchromatin
  channel4_name = "C4-"+name; //DAPI
  channel4_max_name = "MAX_C4-"+name;
  channel5_name = "C5-"+name; //heterochromatin

run("Split Channels");
selectWindow(channel1_name);
run("Macro...", "code=[if (v>=0 && v<=1) v=1] stack");
imageCalculator("Divide create 32-bit stack", channel5_name, channel1_name);
run("Z Project...", "projection=[Max Intensity]");
run("Invert LUT");
run("Median...", "radius=1");
saveAs("Tiff", path_Normalized);
//create a normalized image

selectWindow(channel4_name);
run("Z Project...", "projection=[Max Intensity]");
run("Median...", "radius=2");
setAutoThreshold("Triangle dark");
run("Threshold...");
waitForUser("Set the threshold and press OK, or cancel to exit");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Replace value", "pattern=255 replacement=1");
imageCalculator("Multiply", name2_2, channel4_max_name);
saveAs("Tiff", path_Normalized_masked);
//apply a nuclear mask to the normalized image

selectWindow(name3_2);
close("\\Others")
exit("All done! Now use the Normalized_masked image.")