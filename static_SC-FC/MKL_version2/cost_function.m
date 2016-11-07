function [ J_alpha_best, alpha_best ] = cost_function( J_alpha_best, lambda_best, min_val, max_val, Psi, Phi, m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
step_size = (min_val + max_val)/2;
if step_size < 0.001
    alpha = (Psi'*Psi)\(Psi'*Phi + lambda_best*ones(m,1));
    J_alpha_best = (Psi*alpha - Phi)'*(Psi*alpha - Phi) + lambda_best*ones(1,m)*alpha;
    alpha_best = alpha;
else
    for lambda = min_val : step_size : max_val
        alpha = (Psi'*Psi)\(Psi'*Phi + lambda*ones(m,1));
        J_alpha = (Psi*alpha - Phi)'*(Psi*alpha - Phi) + lambda*ones(1,m)*alpha;
        if J_alpha_best > J_alpha
            J_alpha_best = J_alpha;
            lambda_best = lambda;
            %alpha_best = alpha;
        end
        [J_alpha_best, alpha_best] = cost_function(J_alpha_best, lambda_best, lambda-step_size, lambda+step_size, Psi, Phi, m);
    end
end
end

