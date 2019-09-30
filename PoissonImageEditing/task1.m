% Read image
I=imread('images/dog.jpg');
% Resize the image to reduce running time
I_resize=imresize(I, 0.6);
% Transform the image to grayscale image
I_source=rgb2gray(I_resize);
% Get the size of the image
[row_s,col_s]=size(I_source);

% Select the region and get the mask image
% Selected region is 1 and other region is 0
I_mask=roipoly(I_source);

% Convert image values to double values
I_source=double(I_source);

% unknown_index is the indeices of the the unknown pixels in image
% For example, if I_mask=[0 1 0
%                         1 1 0
%                         0 0 1], unknown_index =find(I_mask)
% unknown_index= 2
%                4
%                5
%                9
unknown_index=find(I_mask);
% Get the number of unknown pixels
unknown_pixels=size(unknown_index, 1);

% Initialise the result image
I_result=I_source;
% Initialise the b vector
b=zeros(unknown_pixels, 1);
% Initialise the A matrix by function sparse
A=sparse(unknown_pixels, unknown_pixels);

% Reset indices to the unknown pixels
% The indices will help to set values in matrix A
mask_index=zeros(row_s, col_s);
mask_index(unknown_index)=1:unknown_pixels;

% Initialize r which is the row index of matrix A
r=1;
% For loop over the whole mask image
for j=1:col_s
    for i=1:row_s
        % If the pixel is in selected region(unknown), check the four neighbours of the pixel
        if(I_mask(i,j)==1)
             % The values in the diagnal line of matrix A are 4
             A(r,r)=4;
             % If the neighbour of the pixel is also in selected region(unknown),
             % set -1 to the neighbour.
             % If the neighbour of the pixel is not in selected region(known),
             % we can know that the pixel in the boundary,
             % then the corresponding value in b will plus the neighbour's pixel value
             
             % Check the upper neighbour 
             if(I_mask(i-1,j)==1)
                 A(r, mask_index(i-1,j))=-1;
             else
                 b(r)=b(r)+I_source(i-1,j);
             end
             
             % Check the left neighbour 
             if(I_mask(i,j-1)==1)
                 A(r, mask_index(i,j-1))=-1;
             else
                 b(r)=b(r)+I_source(i,j-1);
             end
             
             % Check the lower neighbour
             if(I_mask(i+1,j)==1)
                 A(r, mask_index(i+1,j))=-1;
             else
                 b(r)=b(r)+I_source(i+1,j);
             end
             
             % check the right neighbour 
             if(I_mask(i,j+1)==1)
                 A(r,mask_index(i,j+1))=-1;
             else
                 b(r)= b(r)+I_source(i,j+1);
             end
             r=r+1;
        end
    end
end

% Solve SLE: Ax = b
x = A\b;
% Put the least square solution into result image
I_result(unknown_index) = x(1:unknown_pixels);

% Normalize the result image
I_result = uint8(I_result);
figure;
imshow(I_result),title('Result Image(task1)');

% As the size of the selected region increases,
% the result region will more smooth.
