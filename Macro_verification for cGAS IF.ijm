dir = getDirectory("image"); 
  name = getTitle;
  dotIndex = indexOf(name, "."); 
            title = substring(name, 0, dotIndex); 
            //get rid of extension in file name
  name2 = title+"_Mask";
  name3 = title+"_Labeled";
  name4 = title+"_Stack";
  path_Stack = dir+name4;  
  channel1_name = "C1-MAX_"+name;
  channel2_name = "C2-MAX_"+name;
  channel3_name = "C3-MAX_"+name;
  channel4_name = "C4-MAX_"+name;
  channel5_name = "C5-MAX_"+name;

run("Merge Channels...", "c2="+channel1_name+" c4="+channel3_name+" create");
selectWindow("MAX_"+name);
run("Stack to RGB");
close("Composite");
close(name);
close(channel2_name);
close(name2+".tif");
close("Drawing of "+name2+".tif");
run("Images to Stack", "name=Stack_verification title=[] use");
saveAs("Tiff", path_Stack);
exit("Now, use the Stack_verification file to categorize nuelei in the device,"+"\n"+"and delete overlapped/apoptotic nuclei.")