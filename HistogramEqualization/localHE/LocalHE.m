
output_dir=dir(fullfile('*.bmp'));
[u,v]=size(output_dir);
% �Q�ΰj��Ū���ؿ��U�h�ӹ���
for s=1:u
   I=imread(fullfile(output_dir(s).name));
 

A=double(I); % �N�v�����ƭ��ഫ���A 
[m,n]=size(A);  % �N���v���x�}A���j�p�Ȥ��O��im,n

% ���Ϥ���16��64*64���x�}
S=mat2cell(A,ones(256/64,1)*64,ones(256/64,1)*64);

% ��Output���x�}�]����16��64*64
Out=magic(256);
Outcut=mat2cell(Out,ones(256/64,1)*64,ones(256/64,1)*64);

% �]16��Global HE
for cuti=1:4
    for cutj=1:4
        
c=255; 
result=0; 

% �إߤT��1*256���s�x�} 
x=zeros(1,256);  
y=zeros(1,256); 
z=zeros(1,256); 

% �p���ϨC��pixel graylevel���Ӽ� , �N������graylevel�ȩ�bx�x�}����m�A�ӭӼƫh�s�b�Ӧ�m�W
for i=1:64    
    for j=1:64      
        t=S{cuti,cutj}(i,j);     
        x(t+1)=x(t+1)+1;   
    end
end

% �N�C��graylevel���Ӽ�,���H��Ϥj�p,�|�o��C��graylevel�b��Ϫ��K�סC�������graylevel�ȩ�by�x�}����m�A�ӱK�׼ƭȫh�s��b�Ӧ�m�W 
for k=1:256  
    y(k)=x(k)/(64*64); 
end

% ���F�C��graylevel�Ȫ��K�׫�A�i�H�p��C��graylevel���ֿn�����C��C��graylevel���ֿn�ȩ�bz�x�}����m�W
for q=1:256      
    result=result+y(q);     
    z(q)=result; 
end

% �Nz�x�}���C�@�Ӥ�����*255�A�å|�ˤ��J�A�o��s��graylevel
z=round(c*z);   
% �N�s��graylevel�����Ϊ�64*64���x�}
for i1=1:64  
    for j1=1:64   
        Outcut{cuti,cutj}(i1,j1)=z(S{cuti,cutj}(i1,j1)+1);  
    end
end

    end
end

% ��16�����n���x�}�b�X�֦��@��256*256��M�x�}
M=cell2mat(Outcut);

% �N�o�쪺�x�}M�ഫ��bit�줸
P=uint8(M);

% �ͦ��ϧ�
figure; % ��ܦh�ӵ��f
subplot(2,2,1);imshow(I);title('original image'); 
subplot(2,2,2);imhist(I);title('original histogram '); 
subplot(2,2,3);imshow(P);title(' Image equalization '); 
subplot(2,2,4);imhist(P);title(' Histogram equalization ');
end

