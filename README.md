# hello-world
a few simple codes for testing

There are three simple programs to achieve specific functions.

"Color mask"

In this folder, "main.m" is a test program, and "color_mask.m" is the kernel function. "main.m" shows an example of the application of this function. 

In image processing area, especially for image segmentation, there are always needs to reveal segmentation results, i.e., the masks, together with the original image. However, there is no direct function in matlab to achieve this function. Thus, I wrote this program to show different masks with different colors in the original image.

"Data input"

In this folder, "data_input.m" is the main body of the program, "name_match.m" is a function to check whehter two patient names are equal or not, and "data_test.xlsx" is an excel file to store patients information. Considering privacy protection, I have replaced patients' names with "Test Name X" and removed other related information. 

The aim of this program is to input SEP data for certain patients recorded in the excel files. If you directly input SEP data into excel files, you need to index patient's name to target his records and fill in his SEP data in corresponding blanks. It's not easy to find certain patient's name and the SEP data are also easily put in a wrong blanks. This program can provide a more friendly way for this job. In my program, you should only need to input patient name and his SEP records. The program can match your inputs with the stored patients' names, find records of target patient and add his SEP data into corresponding blanks in the excel file. Also, if you put into a wrong name, i.e., name not recored in the excel file, the program can remind you the wrong inputs; while, if the SEP data for your input patient's name has already existed in the excel file, the program will ask you whether to overwirte it. 

The operation of this program is simple. Just run and input corresponding inforamtion as the hints. Type "stop" for the name to end the program. 

"Radar plot"

In this folder, “radar_plot.m" is the main program and "polar_pww.m" is a function revised from one matlab function "polar.m" to draw lines in polar coordinates. 

You can change radar data, plots' names, axes' names and plots' colors in "radar_plot.m" to draw radar plots for your own problem. 

The major revision for "polar_pww.m" is to change input arguments to make the function available for line properties setting, e.g., color, linewidth and linestyle. 
