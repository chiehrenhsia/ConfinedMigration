dir = getDirectory("image"); 
  name = getTitle;
  dotIndex = indexOf(name, "."); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  name2 = title+"_Mask";
  name3 = title+"_Labeled"; 
  path_Mask = dir+name2;
  path_Labeled = dir+name3; 
  channel5_name = "C5-MAX_"+name; //568-heterochromatin
  channel2_name = "C2-MAX_"+name; //647-euchromatin
  channel4_name = "C4-MAX_"+name; //DAPI

run("Z Project...", "projection=[Max Intensity]");
run("Subtract Background...", "rolling=50 stack");
//get maximum intensity projection with background subtraction
run("Split Channels");
selectWindow(channel4_name);
run("Median...", "radius=2");
setAutoThreshold("Triangle dark");
run("Threshold...");
waitForUser("Set the threshold and press OK, or cancel to exit");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Watershed"); 
saveAs("Tiff", path_Mask);
//threshold using DAPI channel and create a Mask file

run("Set Measurements...", "area mean redirect="+channel2_name+" decimal=3");
run("Analyze Particles...", "size=10.00-Infinity show=Outlines display exclude clear");
selectWindow("Drawing of "+name2+".tif");
saveAs("Tiff", path_Labeled);
//create a labeled file
String.copyResults();
waitForUser("Paste euchromatin values to excel and press OK, or cancel to exit");

selectWindow(name2+".tif");
run("Set Measurements...", "area mean redirect="+channel5_name+" decimal=3");
run("Analyze Particles...", "size=10.00-Infinity show=Outlines display exclude clear");
String.copyResults();
selectWindow(name);
exit("Paste heterochromatin values to excel for processing. Proceed with macro_varification."+"\n"+"(No need to close any window)")