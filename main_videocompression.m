clear all
clc

% define quality quantize matrix there are two example select one of them

% Q quality=10% matrix for jpeg compression for
% q=[80 60 50 80 120 200 255 255;
%     55 60 70 95 130 255 255 255;
%     70 65 80 120 200 255 255 255;
%     70 85 110 145 255 255 255 255;
%     90 110 185 255 255 255 255 255;
%     120 175 255 255 255 255 255 255;
%     245 255 255 255 255 255 255 255;
%     255 255 255 255 255 255 255 255];

% define jpeg quantize matrix for quality=90
q=[3 2 2 3 5 8 10 12;
    2 2 3 4 5 12 12 11;
    3 3 3 5 8 11 14 11;
    3 3 4 6 10 17 16 12;
    4 4 7 11 14 22 21 15;
    5 7 11 13 16 12 23 18;
    10 13 16 17 21 24 23 21;
    14 18 19 20 22 20 20 20];

% cretae 3d quantize matrix
Q=zeros(8,8,8);
for i=1:8
    Q(:,:,i)=q;
end

% read so called video frame by frame from file and construc 3d matrix
V(:,:,1)=imread('Input/traffic1.png');
V(:,:,2)=imread('Input/traffic2.png');
V(:,:,3)=imread('Input/traffic3.png');
V(:,:,4)=imread('Input/traffic4.png');
V(:,:,5)=imread('Input/traffic5.png');
V(:,:,6)=imread('Input/traffic6.png');
V(:,:,7)=imread('Input/traffic7.png');
V(:,:,8)=imread('Input/traffic8.png');

V=double(V);
% calculate the video consist of how many bytes.
nbyte=size(V,1)*size(V,2)*size(V,3);

nrow=size(V,1);
ncol=size(V,2);

%% Compression section

% create blank compressed video vector
C=[];
% divide video 8x8x8 block and implement dct
for i=0:8:nrow-1
    fprintf('Encoding for line: %g \n',i);
    for j=0:8:ncol-1
        % take 8x8x8 block with zero mean
        tmp=V(i+1:i+8,j+1:j+8,:)-127;
        % calculate dct
        X=fast3DDCT(tmp);
        % quantize step
        X=round(X./Q);
        % scan element with 3d zigzag
        vector = zigzag3d(X);
        % keep dct results in an array
        C=[C;vector'];
    end
end
%encode quantized DCT result with Run Lenght Encoding
encode = rle(C,0);

% calculate the copressed video consist of how many bytes.
cbyte=length(encode);
% calc compression rate
cp=nbyte/length(encode);

%% reconstruction section
nV=zeros(nrow,ncol,8);

%decode rle data
data = rle(encode,1);

% number of element saved for each 8x8x8 block
ns=8*8*8;
itr=0;
for i=0:8:nrow-1
    fprintf('Decoding for line: %g \n',i);
    for j=0:8:ncol-1
        % extract consequent ns of element
        vec=data(itr+1:itr+ns)';
        itr=itr+ns;
        % contruct DCT matrix with inverse zigzag
        X = izigzag3d(vec);
        % dequantize saved DCT result
        X=X.*Q;
        % take inverse of DCT
        yx=IDCT3D(X);
        % put the value in the constructed video add 127
        nV(i+1:i+8,j+1:j+8,:)=yx+127;
    end
end
% saturate the result in range of [0 255]
nv=round(nV);
nV(nV>255)=255;
nV(nV<0)=0;


%% show and save results
h = figure;
axis tight manual
filename = 'result.gif';
for i=1:8
    imshow([uint8(V(:,:,i)) uint8(nV(:,:,i))]);
    IM=[uint8(V(:,:,i)) uint8(nV(:,:,i))];
    drawnow
    % Capture the plot as an image
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if i == 1        
        imwrite(IM,filename,'gif', 'Loopcount',inf);
    else        
        imwrite(IM,filename,'gif','WriteMode','append');
    end
end








