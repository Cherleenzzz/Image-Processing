function [ii] = computeIntegralImage(image)

%REPLACE THIS
 %image = double(image);
 % Add up the pixel values cumulativitly for each column
 cumColSum = cumsum(image,1);
 % Add up the cumulative sum(row-wise) for each row
 ii = cumsum(cumColSum , 2);

 
% ii = zeros(size(image));
% [rowLen, colLen, dimensions] = size(image);
% Calculate the cumulative sum for each row
% for i = 1:1:rowLen
%     cumulativeSum = cumsum(image(i, :));
%     if i == 1
%        ii(i, :) = cumulativeSum;
%     else
%         for j = 1:1:colLen
%            ii(i, j) = ii(i-1, j) + cumulativeSum(j);
%         end
%     end
% 
% ii = cumsum(cumsum(image,2),1);

end