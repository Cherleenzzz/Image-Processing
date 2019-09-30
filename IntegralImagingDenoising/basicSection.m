%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 10;
col = 10;

% Patchsize - make sure your code works for different values
patchSize = 1;

% Search window size - make sure your code works for different values
searchWindowSize = 2;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
image = imread('images/alleyNoisy_sigma20.png');
image = double(image);

% TODO - Fill out this function
image_ii = computeIntegralImage(image);

% I compared the obtained result with the MATLAB integralImage function
MATLAB_image_ii = integralImage(image);

% TODO - Display the normalised Integral Image
% NOTE: This is for display only, not for template matching yet!
figure('name', 'Normalised Integral Image');
imshow(image_ii./max(max(image_ii)));

figure('name', 'Normalised Integral Image_Matlab');
imshow(MATLAB_image_ii./max(max(MATLAB_image_ii)));

% TODO - Template matching for naive SSD (i.e. just loop and sum)
[distances_naive, searchWindow_naive] = templateMatchingNaive(row, col, image, patchSize, searchWindowSize);

% TODO - Template matching using integral images
[distances_ii, searchWindow_ii] = templateMatchingIntegralImage(row, col, image, patchSize, searchWindowSize);

%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for offsetsRows = -searchWindowSize:1:searchWindowSize
    for offsetsCols= -searchWindowSize:1:searchWindowSize
    disp(['offset rows: ', num2str(offsetsRows), '; offset cols: ',...
        num2str(offsetsCols), '; Naive Distance = ', num2str(distances_naive(offsetsRows+searchWindowSize+1,offsetsCols+searchWindowSize+1),10),...
        '; Integral Im Distance = ', num2str(distances_ii(offsetsRows+searchWindowSize+1,offsetsCols+searchWindowSize+1),10)]);
    end
end
