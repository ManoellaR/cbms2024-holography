close all;
clear all; 

for i = 1 : 1 : 200
    filename = fullfile('ScatteredLetters/', sprintf('%d.png', i));
    im = imread(filename);
    im = rgb2gray(im); 
    
    [ realp imagp ] = CV_FR_focus(im, 1.67e-6, 1.67e-6, -385e-9 * 50000, 385e-9); 
    
    imwrite(realp, strcat('ScatteredLettersResults/',num2str(i), '.jpg'));
end
