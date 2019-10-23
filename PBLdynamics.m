%****PBL dynamics
function [box] = PBLdynamics(dt,dmixed,nboxes,ncanopy,nmixed,start_t,location,time,box0,nsteps,tshift2)
daybox = zeros(nboxes,3600*24/dt);
daybox(:,1) = box0;
zenith= zeros(1,3600*24/dt);
zenith(1) = 180;
for s = 2:(3600*24/dt)
    t_sec = timesteptohr(0, s, dt);
         
     time.hour = mod(floor(t_sec/3600),24);
     time.min = floor((t_sec-time.hour*3600)/60);
     time.sec = t_sec - (time.min*60 + time.hour*3600);
         
     if time.hour == 0 && time.min ==0 && time.sec == 0
         time.day = time.day + 1;
     end
     
     if time.day > eomday(time.year,time.month)
        time.month = time.month + 1;
        time.day = 1;
     end   
     
     if time.month > 12
         time.month = 1;
         time.year = time.year + 1;
     end
        
     sun = sun_position(time, location);
     zenith(s)=sun.zenith;
end 

sunrise = min(find(zenith<100));
sunset = max(find(zenith<100));
for s = 2:(3600*24/dt)
    
     
     for z = 1:nboxes

  if z>ncanopy && z<=nmixed
           
                a =( (800*100/(nmixed-ncanopy))*(z-ncanopy) )-box0(z);
                b = tstep(start_t,tshift2,dt);
                c=(sunset-sunrise)/6;
                dml = a*exp(-(s-b)^2/(2*c^2)); %gaussian fit to PBL growth
 
                daybox(z,s) = box0(z)+dml;

        else
            daybox(z,s) = daybox(z,1);
         
        end
     end
end

for r = 1:nsteps
    if mod(r+ start_t*3600/dt   ,(3600*24/dt) ) == 0
        box(:,r) = daybox(:,(3600*24/dt));
    else
        box(:,r) = daybox(:,mod(r+ start_t*3600/dt   ,(3600*24/dt) ));
    end
end 


