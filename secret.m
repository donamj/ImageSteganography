%Performing huffman coding on secret image

%Reading secret image
sa='C:\Users\Others\Desktop\project\PIC2.jpg';
sb=imread(sa,'jpg');

%Displaying the secret image.
imtool(sb);

%Converting secret image to gray scale
sgb=rgb2gray(sb);
imtool(sgb);

%Calculating the probabilities
%count contains the frequencies and x contains corresponding values
[count,x]=imhist(sgb);
tot=sum(count);
%prob contains the probabilies of each pixel values.
prob = count/tot;

%Creating huffman table
[huff,hufftree]=huffman(prob);

%Huffman coding of image
%cimg contains the coded image
[sx,sy]=size(sgb); %Size of the gray sclae secret image.
%Declaring the cell array to store the huffman coded form of image.
cimg = cell (sx,sy); 
for i=1:sx
    for j=1:sy
        val=sgb(i,j); %Taking the pixel value.
        cval=huff(val+1); %Taking the huffman code for the pixel value.
        cimg(i,j)={cval}; 
    end
end
%Preparation of 3 bit blocks
%blk contains the 3 bit blocks
i = 1;
blok='';
while i<=sx
    j = 1; 
    while j<=sy
        word = cell2mat(cimg{i,j}); %Converting the cell to matrix.
        blok=[blok word];
        j=j+1;
    end
    i=i+1;
end

if mod(length(blok),3)==1
    blok=[blok '00'];
else
    if mod(length(blok),3)==2
        blok=[blok '0'];
    end
end

i=1;
bcnt=1;
while i<=length(blok)
    blk(bcnt,1)=blok(i);
    blk(bcnt,2)=blok(i+1);
    blk(bcnt,3)=blok(i+2);
    i=i+3;
    bcnt=bcnt+1;
end    
bcnt=bcnt-1;
imtool(sgb);


