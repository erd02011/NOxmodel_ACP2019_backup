function [ t_step ] = tstep(start_t,t_hr,dt)
%converts hour after midnight to the timestep
t_step = ((t_hr-start_t)*3600/dt)+1;

end

