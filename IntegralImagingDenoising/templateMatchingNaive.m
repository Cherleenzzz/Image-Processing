function [distances,searchWindow] = templateMatchingNaive(row, col, image, patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD(squared patch distance) over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% If size(offsetsRows,1)=10 and size(offsetsCols,1)=10: then
% size(differences,1)=100

%REPLACE THIS

% Suppose that searchWindowSize = 2, we have 5 by 5 matrics for distance.
% Initialze the distance matrix
distances = zeros(2*searchWindowSize+1, 2*searchWindowSize+1);
patchRange = -patchSize:1:patchSize;
searchWindowRange = -searchWindowSize:1:searchWindowSize;
searchWindow = image(row+searchWindowRange,col+searchWindowRange,:);

% Calculate SSD values between each patch(q) and reference patch(p) in the
% range of offset.
 for offsetsRows = -searchWindowSize:1:searchWindowSize
     for offsetsCols= -searchWindowSize:1:searchWindowSize
         distances(offsetsRows+searchWindowSize+1,offsetsCols+searchWindowSize+1) =...
             sum(sum(sum((image(row+patchRange,col+patchRange,:)-image(row+offsetsRows+patchRange,col+offsetsCols+patchRange,:)).^2)))/(3*((2*patchSize+1)^2));
     end
 end

%  for offsetsRows = -searchWindowSize:1:searchWindowSize
%      for offsetsCols= -searchWindowSize:1:searchWindowSize
%          for m = -patchSize:1:patchSize
%              for n= -patchSize:1:patchSize
%                  distances(offsetsRows+searchWindowSize+1, offsetsCols+searchWindowSize+1)=...
%                      distances(offsetsRows+searchWindowSize+1, offsetsCols+searchWindowSize+1)+...
%                      sum((image(row+m,col+n,:)-image(row+offsetsRows+m,col+offsetsCols+n,:)).^2);
%              end
%          end
%          distances(offsetsRows+searchWindowSize+1, offsetsCols+searchWindowSize+1)=distances(offsetsRows+searchWindowSize+1, offsetsCols+searchWindowSize+1)/(3*((2*patchSize+1)^2));
%      end
%      
%  end

end