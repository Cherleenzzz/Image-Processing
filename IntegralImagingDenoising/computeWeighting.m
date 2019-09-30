function [result] = computeWeighting(d, h, sigma)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    % result is weight between patches centered at p and q
    % d is Squared Patch Distance(SSD)
    % sigma is Noise Standard Deviation
    % h is Decay Parameter
    result = exp(-max(d-2*sigma^2,0)/(h^2));
end