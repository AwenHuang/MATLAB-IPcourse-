
output_dir=dir(fullfile('*.bmp'));
[u,v]=size(output_dir);
% �Q�ΰj��Ū���ؿ��U�h�ӹ���
for s=1:u
   I=imread(fullfile(output_dir(s).name));
 

A=double(I); % �N�v�����ƭ��ഫ���A 
[m,n]=size(A);  % �N���v���x�}A���j�p�Ȥ��O��im,n

c=255; 
result=0; 

% �إߤT��1*256���s�x�} 
x=zeros(1,256);  
y=zeros(1,256); 
z=zeros(1,256); 

% �p���ϨC��pixel graylevel���Ӽ� , �N������graylevel�ȩ�bx�x�}����m�A�ӭӼƫh�s�b�Ӧ�m�W
for i=1:m    
    for j=1:n      
        t=A(i,j);     
        x(t+1)=x(t+1)+1;   
    end
end
% �N�C��graylevel���Ӽ�,���H��Ϥj�p,�|�o��C��graylevel�b��Ϫ��K�סC�������graylevel�ȩ�by�x�}����m�A�ӱK�׼ƭȫh�s��b�Ӧ�m�W 
for k=1:256  
    y(k)=x(k)/(m*n); 
end
% ���F�C��graylevel�Ȫ��K�׫�A�i�H�p��C��graylevel���ֿn�����C��C��graylevel���ֿn�ȩ�bz�x�}����m�W
for q=1:256      
    result=result+y(q);     
    z(q)=result; 
end

% �Nz�x�}���C�@�Ӥ�����*255�A�å|�ˤ��J�A�o��s��graylevel
z=round(c*z);   
% �N�s��graylevel���M�x�}�A��ϯx�}A�Ypixel��graylevel = z�x�}���Y��m�A���Xz�x�}���Y��m����(new graylevel)�A��J�쥻�������Ypixel��m
for i1=1:m  
    for j1=1:n   
        M(i1,j1)=z(A(i1,j1)+1);  
    end
end

% �N�o�쪺�x�}M�ഫ��bit�줸
P=uint8(M);

% �ͦ��ϧ�
figure; % ��ܦh�ӵ��f
subplot(2,2,1);imshow(I);title('original image'); 
subplot(2,2,2);imhist(I);title('original histogram '); 
subplot(2,2,3);imshow(P);title(' Image equalization '); 
subplot(2,2,4);imhist(P);title(' Histogram equalization ');
end

