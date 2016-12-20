%Embedding the secret image in the cover image.

%bx and by contains size of the bands;
[bx by] = size(cA); 

%sA has he approximation band
%sH has the horizontal band
%sV contains the vertical band
%sD contains the diagonal band
[sA sH sV sD] = dwt2(cgb,'haar'); %For stego-image.

%First select the diagonal band for embedding.
bcnt = length(blk); %bcnt contains the length of blk.
cnt = 1;
fl = 0; %fl will be 1 if all blocks are coded, else 0.
i = 1; %Keep track of x coordinate of band.
while i<=bx
    j = 1; %Keep track of y coordinate.
    while j<=by
        if cnt<=bcnt
            num = bin2dec(blk(cnt,:)); %Converting binary block to decimal.
            sD(i,j)=sD(i,j) - mod(sD(i,j),8) + num; %Embedding the 3 bit block.
            cnt = cnt + 1;
        else
            fl = 1;
            break;
        end
        j = j + 1;
            
    end
    if fl==1
        break;
    end
    i = i + 1;
end




%Performing idwt on the stego image
stegoimg = idwt2(sA,sH,sV,sD,'haar');
%stegoimg contains the stego image to be transmitted.
stego = idwt2(sA,sH,sV,sD,'haar');
%Scaling the idwt performed image.
stegoimg = stegoimg./255;

%Displaying the stegoimg.
imtool(stegoimg);
