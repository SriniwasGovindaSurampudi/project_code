function [ Rotation,Translation ] = transformation( theta,translate )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Rotation = [cos(theta) sin(theta) 0 0;-sin(theta) cos(theta) 0 0;0 0 1 0;0 0 0 1];
Translation = [1 0 0 translate(1);0 1 0 translate(2);0 0 1 translate(3);0 0 0 1];
end

