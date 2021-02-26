dir = getDirectory("image"); 
  name = getTitle;
    dotIndex = indexOf(name, "."); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  channel1_name = "C1-"+title+"-1.czi"; //HDAC3-488
  channel2_name = "C2-"+title+"-1.czi"; //phalloidin-647
  channel4_name = "C4-"+title+"-1.czi"; //DAPI


run("Duplicate...","duplicate");
run("Subtract Background...", "rolling=50 stack");
//background subtraction
run("Split Channels");
selectWindow(channel2_name);
run("Z Project...", "projection=[Max Intensity]");
//create a maximum intensity projection for outline tracing
setTool("freehand");
run("Brightness/Contrast...");
waitForUser("Adjust brightness and contrast if needed."+"\n"+"Draw the outline of your selected cell and press OK, or esc to exit");
setBackgroundColor(0, 0, 0);
run("Clear Outside");
waitForUser("Now save the file as a cell outline");
run("Tiff...");
//create and save an whole cell Outline file

run("Set Measurements...", "area mean redirect="+channel1_name+" decimal=3");
selectWindow(channel1_name);
run("Restore Selection");
setOption("Stack position", true); 
  for (s=1; s<=nSlices; s++){
        setSlice(s); 
        run("Measure"); 
	} 
String.copyResults();
waitForUser("Paste whole cell values to excel and press OK, or esc to exit");

run("Clear Results");
selectWindow(channel4_name);
run("Restore Selection");
run("Clear Outside", "stack");
run("Median...", "radius=2 stack");
setAutoThreshold("Triangle dark");
setOption("BlackBackground", true);
run("Convert to Mask", "method=Triangle background=Dark calculate black");
//threshold using DAPI channel and create a nuclear Mask file

run("Set Measurements...", "area mean redirect="+channel1_name+" decimal=3");
setOption("Stack position", true);
selectWindow(channel4_name);
  for (s=1; s<=nSlices; s++){ 
        setSlice(s);
        run("Create Selection");
        run("Make Inverse"); 
        run("Measure"); 
	} 
waitForUser("Now save the file as a nuclear mask");
run("Tiff...");

String.copyResults();
run("Clear Results");
selectImage(name);
close("\\Others"); 
waitForUser("Paste nuclear values to excel and press OK to end macro."+"\n"+"You can directly run this macro again to proceed with the next cell.");