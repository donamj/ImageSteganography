%Performing DWT on cover image

%Reading the cover image
ca='C:\Users\Others\Desktop\project\PIC.jpg';
cb=imread(ca,'jpg');

%Displaying the cover image
imtool(cb);

%Conversion of the image to gray scale
cgb=rgb2gray(cb);

%Displaying the gray scale cover image.
imtool(cgb);

%Performing dwt on cover image
%cA stores approximation band
%cH stores hoizontal band
%cV stores vertical band
%cD stores diagonal band
[cA,cH,cV,cD] = dwt2(cgb,'haar');

%Displaying the bands
cAs=mat2gray(cA);
cHs=mat2gray(cH);
cVs=mat2gray(cV);
cDs=mat2gray(cD);
dw=[cAs cHs ; cVs cDs];
imtool(dw);

