
%% Some parameters to set - make sure that your code works at image borders!
patchSize = 1;
sigma = 20; % standard deviation (different for each image!)
h = 0.5; %decay parameter
windowSize = 5;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
imageNoisy = double(imread('images/alleyNoisy_sigma20.png'));
imageReference = double(imread('images/alleyReference.png'));
tic;
%TODO - Implement the non-local means function
filtered1 = nonLocalMeansWithIntergralImage(imageNoisy, sigma, h, patchSize, windowSize);
filtered1n = uint8(filtered1);
% filtered2 = nonLocalMeans(imageNoisy, sigma, h, patchSize, windowSize);
% filtered2n= uint8(filtered2);
toc

%% Let's show your results!

%Show the denoised image
figure('name', 'NL-Means(Intergral Image) Denoised Image');
imshow(filtered1n);

% figure('name', 'NL-Means Denoised Image');
% imshow(filtered2n);

%Show difference image
diff_image = abs(imageReference - filtered1);
figure('name', 'Difference Image');
imshow(diff_image ./ max(max((diff_image))));

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered1, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);


% Feel free (if you like only :)) to use some other metrics (Root
% Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)