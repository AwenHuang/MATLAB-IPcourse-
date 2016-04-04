for s=1:2
    if s==1
        %Input Image
        O=imread('blurry_moon.tif');
    else
        O=imread('skeleton_orig.bmp');
        O=rgb2gray(O);
    end

%Preallocate the matrices with zeros
I1=O;
I=zeros(size(O));
I2=zeros(size(O));

%��ر`����Filter Masks 
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

%�X�R���A�~�򪺹���,�קK�v���~�h�������F�~����9��,��R��=0
O=padarray(O,[1,1]);
% �N�v�����ƭ��ഫ���A
O=double(O);

%��@Laplacian mask
for i=1:size(O,1)-2
    for j=1:size(O,2)-2
       
        I(i,j)=sum(sum(F2.*O(i:i+2,j:j+2)));
       
    end
end


% =============high-boost=============

A=1.7;
[m n]=size(I1);
af=zeros(size(I1));
for i=1:m-1
for j=1:n-1
af(i,j)=A*I1(i,j);
end
end

I=uint8(I);
AF=uint8(af);
%Sharpenend Image
B=I1-I;
HB = AF - I;

figure;
subplot(1,3,1);imshow(I1);title(' original image ');
subplot(1,3,2);imshow(B);title(' sharpened image (Laplacian) '); 
subplot(1,3,3),imshow(HB),title('sharpened Image (High-Boost)');

end
