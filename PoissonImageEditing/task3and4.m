% % Read images
% I1=imread('images/girl.jpg');
% I2=imread('images/orange.jpg');
% % Resize images
% I_source=imresize(I1, 1);
% I_background=imresize(I2, 1);

% % Read images
% I1=imread('images/dogs.jpg');
% I2=imread('images/school.jpg');
% % Resize images
% I_source=imresize(I1, 0.3);
% I_background=imresize(I2, 0.5);

% % Read images
% I1=imread('images/cat.jpg');
% I2=imread('images/street.jpg');
% % Resize images
% I_source=imresize(I1, 0.2);
% I_background=imresize(I2, 0.9);

% % Read images
% I1=imread('images/rainbow.jpg');
% I2=imread('images/rainbow.jpg');
% % Resize images
% I_source=imresize(I1, 0.3);
% I_background=imresize(I2, 0.3);

% Read images
I1=imread('images/erkang1.jpg');
I2=imread('images/blank2.jpg');
% Resize images
I_source=imresize(I1, 2);
I_background=imresize(I2, 0.8);

% % Read images
% I1=imread('images/erkang2.jpg');
% I2=imread('images/hand.jpg');
% % Resize images
% I_source=imresize(I1, 1);
% I_background=imresize(I2, 1);

% Select the region and get the mask image
I1_mask=roipoly(I_source);

figure;
% Show the target image and select the interpolation point
imshow(I_background),title('Please select the interpolation point');
% Get the coordinates of selected point
[col_interpolation,row_interpolation]=ginput(1);
% Make sure that the coordinates are integers.
col_interpolation=round(col_interpolation);
row_interpolation=round(row_interpolation);

% Initialize the mask image of background image
I2_mask=zeros(size(I_background));

% Get the coordinates of selected region in source image
[row_m, col_m]=find(I1_mask);
% The coordinates of the first point of the selected region is [min(rowMask),min(colMask)]
firstpoint=[min(row_m),min(col_m)];

% r_range is the row indices of unknown pixels in background image
r_range=row_interpolation+row_m-firstpoint(1);
% c_range is the col indices of unknown pixels in background image
c_range=col_interpolation+col_m-firstpoint(2);

% Set 1 to the unknown pixels in background image
% Use sub2ind to find the indices of unknown pixels in background image
% according to r_range and c_range
I2_mask(sub2ind(size(I_background),r_range,c_range))=1;

% Initialize result image
I_result=I_background;
I_result(:,:,1)=mixingGradients(I_source(:,:,1),I_background(:,:,1),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
I_result(:,:,2)=mixingGradients(I_source(:,:,2),I_background(:,:,2),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
I_result(:,:,3)=mixingGradients(I_source(:,:,3),I_background(:,:,3),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);

% % Initialize result image
% I_result=I_background;
% I_result(:,:,1)=importingGradients(I_source(:,:,1),I_background(:,:,1),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
% I_result(:,:,2)=importingGradients(I_source(:,:,2),I_background(:,:,2),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
% I_result(:,:,3)=importingGradients(I_source(:,:,3),I_background(:,:,3),I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
 
figure;
imshow(I_result),title('Result Image(task3and4)');