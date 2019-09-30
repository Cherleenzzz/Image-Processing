function I_result=importingGradients(I_source,I_background,I1_mask,I2_mask,row_interpolation,col_interpolation,firstpoint)

% Convert image values to double values
I_source=double(I_source);
I_background=double(I_background);

% Get the size of the background image
[row_b,col_b]=size(I_background);

% unknown_index is the indeices of the the unknown pixels in image
% For example, if I_mask=[0 1 0
%                         1 1 0
%                         0 0 1], unknown_index =find(I_mask)
% unknown_index= 2
%                4
%                5
%                9
unknown_index=find(I2_mask);
% Get the number of unknown pixels
unknown_pixels=size(unknown_index, 1);

% Initialise the result image
I_result=I_background;
% Initialise the b vector
b=zeros(unknown_pixels, 1);
% Initialise the A matrix by function sparse
A=sparse(unknown_pixels, unknown_pixels);
 
% Reset indices to the unknown pixels
% The indices will help to set values in matrix A
mask_index=zeros(row_b, col_b);
mask_index(unknown_index)=1:unknown_pixels;

% Initialize r which is the row index of matrix A
r = 1;
% For loop over the whole mask image of background image
for j=1:col_b
    disp (j)
    for i=1:row_b
        % If the pixel is in selected region(unknown), check the four neighbours of the pixel
        if(I2_mask(i,j) == 1)             
             % The values in the diagnal line of matrix A are 4
             A(r,r)=4;
             % If the neighbour of the pixel is also in selected region(unknown),
             % set -1 to the neighbour and the corresponding value in b will plus Vpq=gp-gq.
             % If the neighbour of the pixel is not in selected region(known),
             % we can know that the pixel in the boundary,
             % then the corresponding value in b will plus the neighbour's pixel value
             
             % We need know the corresponding coordinates in source image to
             % calculate Vpq=gp-gq             
             % x is the corresponding row index in source image 
             x=i-row_interpolation+firstpoint(1);
             % y is the corresponding column index in source image 
             y=j-col_interpolation+firstpoint(2);
             % if the pixel is unknown, check the neighbours of the pixel
             
             % Check upper neighbour 
             Vpq1=I_source(x,y)-I_source(x-1,y);
             if(I2_mask(i-1,j)==1)
                 A(r, mask_index(i-1,j))=-1;
                 b(r)=b(r)+Vpq1;
             else
                 b(r)=b(r)+I_background(i-1,j)+Vpq1;
             end
             
             % Check the left neighbour
             Vpq2=I_source(x,y)-I_source(x,y-1);
             if(I2_mask(i,j-1)==1)
                 A(r, mask_index(i,j-1))=-1;
                 b(r)=b(r)+Vpq2;
             else
                 b(r)= b(r)+I_background(i,j-1)+Vpq2;
             end
             
             % Check the lower neighbour
             Vpq3=I_source(x,y)-I_source(x+1,y);
             if(I2_mask(i+1,j)==1)
                 A(r, mask_index(i+1,j))=-1;
                 b(r)=b(r)+Vpq3;
             else
                 b(r)=b(r)+I_background(i+1,j)+Vpq3;
             end
             
             % Check the right neighbour
             Vpq4=I_source(x,y)-I_source(x,y+1);
             if(I2_mask(i,j+1)==1)
                 A(r, mask_index(i,j+1))=-1;
                 b(r)=b(r)+Vpq4;
             else
                 b(r)=b(r)+I_background(i,j+1)+Vpq4;
             end
             r = r+1;
        end
    end
end


% Solve SLE: Ax = b
x = A\b;

% Put the least square solution into result image
I_result(unknown_index) = x(1:unknown_pixels);

% Normalize the result image
I_result = uint8(I_result);
end

