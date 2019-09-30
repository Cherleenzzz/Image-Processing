% Read images
I=imread('images/orange.jpg');
% Resize the image to reduce running time
I_background=imresize(I, 1);
% Get the size of the image
[row_s,col_s]=size(I_background);

% % Read images
% I=imread('images/hand.jpg');
% % Resize the image to reduce running time
% I_background=imresize(I, 1);
% % Get the size of the image
% [row_s,col_s]=size(I_background);

% Select the region and get the mask image
% Selected region is 1 and other region is 0
I_mask=roipoly(I_background);

% Initialise the result image
I_result=I_background;
% Change the color of image
I_changeR=I_background(:,:,1) * 0.9;
I_changeG=I_background(:,:,2) * 0.3;
I_changeB=I_background(:,:,3) * 0.2;

I_result(:,:,1)=localColorChanges(I_background(:,:,1),I_changeR,I_mask);
I_result(:,:,2)=localColorChanges(I_background(:,:,2),I_changeG,I_mask);
I_result(:,:,3)=localColorChanges(I_background(:,:,3),I_changeB,I_mask);

figure;
imshow(I_result),title('Result Image(task5)');