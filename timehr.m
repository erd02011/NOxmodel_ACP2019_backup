function [ t_hr ] = timehr( start_t, t_step, dt)
%UNTITLED2 Summary of this function goes here
%  converts time step to time after midnight in seconds
% start_t is assumed to be time in hours after midnight(0)
start_t = start_t * 3600;
t_hr = (start_t + (t_step-1)*dt)/3600;



end

