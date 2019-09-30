function [result] = nonLocalMeansWithIntergralImage(image, sigma, h, patchSize, windowSize)

%REPLACE THIS
result = zeros(size(image));
% Extend the edge of the image to make sure it can work on the border
extendImage = padarray(image, [windowSize+patchSize+1, windowSize+patchSize+1],'symmetric','both');

[rowLen,colLen,dimensions] = size(image);
% Initialize the ssd matrix for the whole image
differenceValue = zeros(rowLen+2*patchSize+2, colLen+2*patchSize+2, (2*windowSize+1)^2);
% k is the index of the numbers of offsets.
k=1;
% Calculate the ssd for the whole image
for j = -windowSize:1:windowSize
    for i=-windowSize:1:windowSize
        differencep_q=((extendImage(1+windowSize : 2*patchSize+2+windowSize+rowLen, 1+windowSize : 2*patchSize+2+windowSize+colLen,:)...
                -extendImage(1+windowSize+i : 2*patchSize+2+windowSize+rowLen+i, 1+windowSize+j : 2*patchSize+2+windowSize+colLen+j,:)).^2);
        % The ssd for kth offsets
        differenceValue(:,:,k) = (differencep_q(:,:,1)+differencep_q(:,:,2)+differencep_q(:,:,3))/(3*((2*patchSize+1)^2));
        k=k+1;
    end
end

% Initialize the intergral image matrix
ii= ones(size(differenceValue));
% Calculate the intergral image for each offeset
for m = 1:1:(2*windowSize+1)^2
    ii(:,:,m) = computeIntegralImage(differenceValue(:,:,m));
end

% Loop over the whole image
for i = 1:1:rowLen
    disp(i);
    for j = 1:1:colLen
        % Get SSD values between each patch(q) and reference patch(p) and
        % searchwindow
        [distances, searchWindow] = templateMatchingIntegralImage(i, j, extendImage, ii, patchSize, windowSize);
        weight = computeWeighting(distances, h, sigma);
        % cp is weight sum between patches centered at p and q
        % noisyWeightSum is the sum that noisy pixel at q mutiply weight(p,q)
        cp = sum(sum(weight));
        noisyWeightSum = sum(sum(searchWindow.*weight));
        result(i,j,:) = (1/cp)*noisyWeightSum;
    end
end


% % Loop over the whole image
% for i = 1:1:rowLen
%     for j = 1:1:colLen
%         % cp is weight sum between patches centered at p and q
%         % noisyWeightSum is the sum that noisy pixel at q mutiply
%         % weight(p,q)
%         cp=0;
%         noisyWeightSum=0;
%         % Get SSD values between each patch(q) and reference patch(p)
%         distance=templateMatchingIntegralImage(i+patchSize+windowSize, j+patchSize+windowSize, extendImage, patchSize, windowSize);
%         for offsetsRows = -windowSize:1:windowSize
%             for offsetsCols= -windowSize:1:windowSize
%                 % d is the SSD value between current patch(qi) and
%                 % reference patch(p)
%                 d=distance(offsetsRows+windowSize+1, offsetsCols+windowSize+1);
%                 % Weight between current patch(qi) and reference patch(p)
%                 weight=computeWeighting(d, h, sigma);
%                 cp=cp+weight;
%                 noisyWeightSum=noisyWeightSum+weight*extendImage(i+offsetsRows+patchSize+windowSize,j+offsetsCols+patchSize+windowSize,:);     
%             end
%                 
%         end
%         
%         result(i,j,:)=(1/cp)*noisyWeightSum;
%                  
%     end
% end
end
