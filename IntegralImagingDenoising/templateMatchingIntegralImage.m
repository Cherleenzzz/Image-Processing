function [distances,searchWindow] = templateMatchingIntegralImage(row,col,image,ii,patchSize,windowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsX(1) = -1;
% offsetsY(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% This time, use the integral image method!
% NOTE: Use the 'computeIntegralImage' function developed earlier to
% calculate your integral images
% NOTE: Use the 'evaluateIntegralImage' function to calculate patch sums
%REPLACE THIS

searchWindowRange = -windowSize:1:windowSize;
searchWindow = image(row+searchWindowRange+patchSize+windowSize+1,col+searchWindowRange+patchSize+windowSize+1,:);

% Calcalue the patch sum for reference p
patchSum =  ii(row+2*patchSize+1, col+2*patchSize+1,:)-ii(row, col+2*patchSize+1,:)+ii(row, col,:)-ii(row+2*patchSize+1, col,:);
% In order to reshape the distance matrix to 5 by 5
distances = reshape(patchSum, [2*windowSize+1, 2*windowSize+1]);
end