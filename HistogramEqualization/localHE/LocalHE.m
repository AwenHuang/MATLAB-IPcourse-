
output_dir=dir(fullfile('*.bmp'));
[u,v]=size(output_dir);
% 利用迴圈讀取目錄下多個圖檔
for s=1:u
   I=imread(fullfile(output_dir(s).name));
 

A=double(I); % 將影像的數值轉換型態 
[m,n]=size(A);  % 將此影像矩陣A的大小值分別丟進m,n

% 把原圖切成16塊64*64的矩陣
S=mat2cell(A,ones(256/64,1)*64,ones(256/64,1)*64);

% 把Output的矩陣也切成16塊64*64
Out=magic(256);
Outcut=mat2cell(Out,ones(256/64,1)*64,ones(256/64,1)*64);

% 跑16次Global HE
for cuti=1:4
    for cutj=1:4
        
c=255; 
result=0; 

% 建立三個1*256的零矩陣 
x=zeros(1,256);  
y=zeros(1,256); 
z=zeros(1,256); 

% 計算原圖每個pixel graylevel的個數 , 將相應的graylevel值放在x矩陣的位置，而個數則存在該位置上
for i=1:64    
    for j=1:64      
        t=S{cuti,cutj}(i,j);     
        x(t+1)=x(t+1)+1;   
    end
end

% 將每個graylevel的個數,除以原圖大小,會得到每個graylevel在原圖的密度。把相應的graylevel值放在y矩陣的位置，而密度數值則存放在該位置上 
for k=1:256  
    y(k)=x(k)/(64*64); 
end

% 有了每個graylevel值的密度後，可以計算每個graylevel的累積分布。把每個graylevel的累積值放在z矩陣的位置上
for q=1:256      
    result=result+y(q);     
    z(q)=result; 
end

% 將z矩陣的每一個元素都*255，並四捨五入，得到新的graylevel
z=round(c*z);   
% 將新的graylevel放到切割的64*64的矩陣
for i1=1:64  
    for j1=1:64   
        Outcut{cuti,cutj}(i1,j1)=z(S{cuti,cutj}(i1,j1)+1);  
    end
end

    end
end

% 把16塊做好的矩陣在合併成一個256*256的M矩陣
M=cell2mat(Outcut);

% 將得到的矩陣M轉換成bit位元
P=uint8(M);

% 生成圖形
figure; % 顯示多個窗口
subplot(2,2,1);imshow(I);title('original image'); 
subplot(2,2,2);imhist(I);title('original histogram '); 
subplot(2,2,3);imshow(P);title(' Image equalization '); 
subplot(2,2,4);imhist(P);title(' Histogram equalization ');
end

