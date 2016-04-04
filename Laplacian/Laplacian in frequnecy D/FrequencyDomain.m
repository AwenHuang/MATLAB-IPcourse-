clear all; 
close all ;
clc;

for s=1:2
    if s==1
        %Input Image
        f=imread('blurry_moon.tif');
    else
        f=imread('skeleton_orig.bmp');
        f=rgb2gray(f);
    end

f = double(f);

h=[0,1,0;1,-4,1;0,1,0]; % Laplacian Mask in spatiak domain
[M N] = size(f);

% 計算Fourier transform前把輸入影像乘上(-1)x+y
for x=1:M
    for y=1:N
        f(x,y) = f(x,y)*(-1)^(x+y);
    end
end

F = fft2(f);

% Frequency respones of h (Filter)
H =  freqz2(h,[M N]); 

% G(u,v) = H(u,v)F(u,v) , G(u,v) = Laplacian filter
G = H.*F;  

% g = Laplacian filter image
% 取Filtered image的實部，並乘上(-1)x+y來抵銷一開始對輸入影像乘(-1)x+y的結果
g = real(ifft2(G)); 
for x=1:M
    for y=1:N
        g(x,y) = g(x,y)*(-1)^(x+y);
    end
end

% subtracting the Laplacian from original image
f = uint8(f);
g = uint8(g);
g1= f-g; 

figure;
subplot(1,2,1),imshow(f),title('Original Image');
subplot(1,2,2),imshow(g1),title('Enhanced image');
end