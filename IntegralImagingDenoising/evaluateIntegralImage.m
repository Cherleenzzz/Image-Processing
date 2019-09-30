function [patchSum] = evaluateIntegralImage(ii, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii
% REPLACE THIS!
L1 = ii(row, col,:);
L2 = ii(row+2*patchSize+1, col,:);
L3 = ii(row+2*patchSize+1, col+2*patchSize+1,:);
L4 = ii(row, col+2*patchSize+1,:);
patchSum = L3-L4+L1-L2;
patchSum = sum(patchSum(:));
end