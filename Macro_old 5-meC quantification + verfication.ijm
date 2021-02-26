dir = getDirectory("image"); 
  name = getTitle;
  dotIndex = indexOf(name, ".czi"); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  name2 = title+"_Mask";
  name3 = title+"_Labeled";
  name4 = title+"_Stack"; 
  path_Mask = dir+name2;
  path_Labeled = dir+name3;
  path_Stack = dir+name4;  
  channel1_name = "C1-MAX_"+name;
  channel2_name = "C2-MAX_"+name;
  channel3_name = "C3-MAX_"+name;

run("Z Project...", "projection=[Max Intensity]");
run("Subtract Background...", "rolling=50 stack");
//get maximum intensity projection with background subtraction
run("Split Channels");
selectWindow(channel3_name);
run("Duplicate...", " ");
run("Median...", "radius=2");
setAutoThreshold("Triangle dark");
run("Threshold...");
waitForUser("Set the threshold and press OK, or cancel to exit");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Watershed"); 
saveAs("Tiff", path_Mask);
//threshold using heterochrimatin channel and create a Mask file

run("Set Measurements...", "area mean redirect="+channel1_name+" decimal=3");
run("Analyze Particles...", "size=10.00-Infinity show=Outlines display exclude clear");
selectWindow("Drawing of "+name2+".tif");
saveAs("Tiff", path_Labeled);
//create a labeled file
String.copyResults();
waitForUser("Paste 488/5-meC values to excel and press OK, or cancel to exit");

selectWindow(name2+".tif");
run("Set Measurements...", "area mean redirect="+channel3_name+" decimal=3");
run("Analyze Particles...", "size=10.00-Infinity show=Outlines display exclude clear");
String.copyResults();
selectWindow(name);
waitForUser("Paste 568/heterochromatin values to excel for processing. Click ok to continue with macro_varification."+"\n"+"(No need to close any window)")

run("Merge Channels...", "c1="+channel3_name+" c2="+channel1_name+" c4="+channel2_name+" create ignore");
selectWindow("Composite");
run("Stack to RGB");
close("Composite");
close(name);
close(name2+".tif");
close("Drawing of "+name2+".tif");
run("Images to Stack", "name=Stack_verification title=[] use");
saveAs("Tiff", path_Stack);
exit("Now, use the Stack file to categorize nuclei in the device,"+"\n"+"and delete overlapped/apoptotic nuclei.")