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
  channel4_name = "C4-MAX_"+name;

run("Merge Channels...", "c1="+channel4_name+" c2="+channel1_name+" c4="+channel2_name+" create");
selectWindow("Composite");
run("Stack to RGB");
close("Composite");
close(name);
close(name2+".tif");
close("Drawing of "+name2+".tif");
run("Images to Stack", "name=Stack_verification title=[] use");
saveAs("Tiff", path_Stack);
exit("Now, use the Stack_verification file to categorize nuclei in the device,"+"\n"+"and delete overlapped/apoptotic nuclei.")