function [result] = nonLocalMeans(image, sigma, h, patchSize, windowSize)

%REPLACE THIS

% Extend the edge of the image to make sure it can work on the border
extendImage = padarray(image, [windowSize+patchSize, windowSize+patchSize],'symmetric','both');

% Initialize the denoise image matrics
result = zeros(size(image));
[rowLen,colLen,dimensions] = size(image);

% Loop over the whole image
for i = 1:1:rowLen
    disp(i);
    for j = 1:1:colLen
        % Get SSD values between each patch(q) and reference patch(p) and
        % searchwindow
        [distances, searchWindow] = templateMatchingNaive(i+patchSize+windowSize, j+patchSize+windowSize, extendImage, patchSize, windowSize);
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
%         distance=templateMatchingNaive(i+patchSize+windowSize, j+patchSize+windowSize, extendImage, patchSize, windowSize);
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