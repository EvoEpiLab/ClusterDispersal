%==========================================================================
% Function: bimodality_coefficient
% Calculates the Bimodality Coefficient (BC) of a data vector
% Created by Loïc Marrec
%==========================================================================
function BC = bimodality_coefficient(x)

    % Ensure input is a column vector
    if isvector(x)
        x = x(:);
    end

    % Number of data points
    N = size(x, 1);

    % Unbiased sample skewness
    S = skewness(x, 0);  % 0 indicates unbiased (corrected) estimation

    % Unbiased sample excess kurtosis (subtract 3 to center at normal distribution)
    K = kurtosis(x, 0) - 3;

    % Compute the Bimodality Coefficient
    % Formula:
    %   BC = (S^2 + 1) / [K + (3*(N-1)^2) / ((N-2)*(N-3))]
    denominator = K + (3 * (N - 1)^2) / ((N - 2) * (N - 3));
    BC = (S.^2 + 1) ./ denominator;

end
