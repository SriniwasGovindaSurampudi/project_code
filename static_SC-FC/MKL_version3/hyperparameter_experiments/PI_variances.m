function [ PI_var, m_variations ] = PI_variances( m_variations, n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% to collect all pi_variations of a lambda
PI_var = cell(1, 9);

% all pi's collected together
for m = 5 : 13
    PI = zeros(m * n, n, 5);
    for i = 1 : 5
        PI(:, :, i) = m_variations{m - 4, i}{1, 1};
    end
    m_variations{m - 4, 8} = PI;
end

% compute variances and store in 9th column
for m = 5 : 13
    PI = zeros(m * n , n);
    for j = 1 : n
        PI(:, j) = var(squeeze(m_variations{m - 4, 8}(:, j, :)), 0, 2);
    end
    m_variations{m - 4, 9} = PI;
end

% collect all pi_variations
for i = 1 : 9
    PI_var{1, i} = m_variations{i, 9};
end
end

