% Read images
I1=imread('images/girl.jpg');
I2=imread('images/orange.jpg');
% Resize images
I1_resize=imresize(I1, 1);
I2_resize=imresize(I2, 1);
% Transform the images to grayscale images
I_source=rgb2gray(I1_resize);
I_background=rgb2gray(I2_resize);

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

I_result=importingGradients(I_source,I_background,I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint);
 
figure;
imshow(I_result),title('Result Image(task2a)');