stegoimg=stegoimg.*255;
%Performing dwt on stego-image
[A H V D] = dwt2(stegoimg,'haar');
%A has approximation band.
%H has horizontal band.
%V has vertical band.
%D has diagonal band.
[bx by] = size(A); %To store the size of the bands.
%lbit contains the total number of bits in the bit stream.
lbit=bcnt*3;
%The bits are stored in the diagonal.
x=1; %Tracks x coordinate.
%bits = zeros(1,lbit); %To store the bits.
bits = ''; %To store the bits.
while x<=bx
    y=1;
    while y<=by
        num = int8(mod(sD(x,y),8));
        bnum = dec2bin(num);
        if num==0 ||  num==1
            bits=[bits '00'];
        end
        if num==2 || num==3
            bits = [bits '0'];
        end
        bits = [bits bnum];
        y =  y + 1;
    end
    x = x + 1;
end

bits=bits(1,1:lbit);

%Traverse through the huffman tree to find the corresponding pixel values 
%and then assign it to the new image matrix to obtain the secret image.
i=1;
cnt=1;
while i<=sx
    j=1;
    while j<=sy
        temp=hufftree;
        while isa(temp,'cell')
            if bits(cnt)=='0'
                temp=temp{1};
            else
                temp=temp{2};
            end
            cnt=cnt+1;
        end
        simg(i,j)=temp-1;
        j=j+1;
    end
    i=i+1;
end

%Displaying the secret image.
secretimg=mat2gray(simg);
imtool(secretimg);

