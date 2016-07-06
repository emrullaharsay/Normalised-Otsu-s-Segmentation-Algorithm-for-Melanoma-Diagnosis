%%% Normalised Otsu’s Segmentation Algorithm for Melanoma Diagnosis %%%

clc,clear all;
A=imread('melanoma.jpg');
B=rgb2gray((A));
% B=imread('tire.tif');
[M ,N]=size(B);
C=zeros(size(B));

%NORMALIZATION
summ=0;
sum1=0;
diff=0;

% for i=1:M
%     for j=1:N
        summ=sum(B(:));
%     end
% end
 globalmean=summ/(M*N);
% 

for i=4:110
    for j=223:134
       C(i,j)=B(i,j);
    end
end


sum1=sum(sum(C));
localmean=sum1/(105*109);


diff = B - localmean;
%normalize B
newImage = diff +globalmean;

%OTSU
Z=imhist(newImage);
teta1=zeros(256,1);
meant1=zeros(256,1);
%t=min(Z);
Z=reshape(Z,[],1);
px=Z/sum(Z);
X=size(B);
% teta=sum(G(1:t))/sum(G); %?(t)
meen= sum((reshape((1:256),[],1)).*px);
% mean value of gray levels



for i=1:256 
    
    for j=1:i
        teta1(i)=teta1(i)+px(j);
       
    end
    temp=px.*(1:256)';
    %finding teta(t)
    for j=1:i
        meant1(i)=meant1(i)+temp(j);
         
    end
    
   
    varB1=(((meant1-(teta1*(meen))).^2)./(teta1.*(1-teta1)));
    
end

maxval=max(varB1);
esikNormalize = Z(find(varB1 == maxval))

for i=1:M
    for j=1:N
        if B(i,j)<=esikNormalize
            X(i,j)=0;
        else 
            X(i,j)=1;
        end
    end
end



G=imhist(B);
teta2=zeros(256,1);
meant2=zeros(256,1);
t=min(G);
G=reshape(G,[],1);
pxx=G/sum(G);
y=size(B);
% teta=sum(G(1:t))/sum(G); %?(t)
meeen= sum((reshape((1:256),[],1)).*pxx);% mu




for i=1:256 %G 256 elemnl? old için
    
    for j=1:i
        teta2(i)=teta2(i)+pxx(j);
    end
    temp1=pxx.*(1:256)';
    
    for j=1:i
        meant2(i)=meant2(i)+temp1(j);
    end
    
   
    varB2=(((meant2-(teta2*(meeen))).^2)./(teta2.*(1-teta2)));
    
end

maxval1=max(varB2);
esik = G(find(varB2 == maxval1))

for i=1:M
    for j=1:N
        if B(i,j)<=esik
            y(i,j)=0;
        else 
            y(i,j)=1;
        end
    end
end




figure
subplot(2,2,1);imshow(B);title('Original Photo') 
subplot(2,2,2);imshow(newImage);title('Normalised Photo') 
subplot(2,2,3);imshow(X);title('Normalised Otsu Algorithm') 
subplot(2,2,4);imshow(y);title(' Otsu Algorithm')     


    