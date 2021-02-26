dir = getDirectory("image"); 
  name = getTitle;
  dotIndex = indexOf(name, ".czi"); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  name2 = title+"_MAX"; 
  path_MAX = dir+name2;
  channel1_name = "C1-MAX_"+name;
  channel2_name = "C2-MAX_"+name;
  channel3_name = "C3-MAX_"+name;
  channel4_name = "C4-MAX_"+name;

run("Z Project...", "projection=[Max Intensity]");
run("Subtract Background...", "rolling=50 stack");
//get maximum intensity projection with background subtraction
saveAs("Tiff", path_MAX);
exit("Maximum intensity projection and background subtraction are done and saved.")