for s=1:2
    if s==1
        %Input Image
        F=imread('lena-d.bmp');
    else
        F=imread('lena-l.bmp');
    end


F=im2double(F);

% covert color from RGB to HSI
r=F(:,:,1);
g=F(:,:,2);
b=F(:,:,3);

th=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b)))+eps));
H=th;
H(b>g)=2*pi-H(b>g);
H=H/(2*pi);
S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
I=(r+g+b)/3;
hsi=cat(3,H,S,I);

HE=H*2*pi;

HE=histeq(HE);
HE=HE/(2*pi);

SE=histeq(S);
IE=histeq(I);

% hue component is unchanged
RV=cat(3,H,SE,IE);
% covert color from HSI to RGB , call hsitorgb.m function
C=hsitorgb(RV);

% laplacian filter of r g b components
[m n]=size(r);
for i=1:m
    for j=1:n
        ip=i+1;
        im=i-1;
        jm=j-1;
        jp=j+1;
        if(im<1)
            im=i;
        elseif (ip>m)
            ip=i;
        end
        if(jm<1)
            jm=j;
        elseif (jp>n)
            jp=j;
        end
        rt(i,j)=-4*r(i,j)+ 1*(r(i,jm)+r(i,jp)+r(ip,j)+r(im,j));
        gt(i,j)=-4*g(i,j)+ 1*(g(i,jm)+g(i,jp)+g(ip,j)+g(im,j));
        bt(i,j)=-4*b(i,j)+ 1*(b(i,jm)+b(i,jp)+b(ip,j)+b(im,j));
       end
end
% substract laplacian filter 
rt=r-rt;
gt=g-gt;
bt=b-bt;

T=cat(3,rt,gt,bt);

figure,
subplot(1,3,1),imshow(F),title('Oringinal Image');
subplot(1,3,2),imshow(C),title('RGB Image (histeq in HSI color space)');
subplot(1,3,3),imshow(T),title('Sharpened Image');
end
