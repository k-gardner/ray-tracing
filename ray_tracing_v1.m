%% user defines incident angle of laser beam and distance of photodiode

%user input here%
incident_angle=45; %incident angle of beam on viewport in degrees
alpha=deg2rad(10); %angle that microdisk is deflected by in rads
d=0.002; %viewport thickness in meters - depends on viewport
x3=0.1; %distance to photodiode in meters
h=0.01; %disk-viewport separation in meters - depends on microscope objective

%fixed values - do not change%
n1=1; %air refractive index
n2=1.77; %viewport refractive index

viewport_w=0.075; %viewport viewing diameter

theta_i=deg2rad(incident_angle); %incident angle of beam on viewport in rads
theta_r=asin((sin(theta_i))/n2); %refracted angle inside viewport in rads
phi=theta_i+alpha; %incident/reflected angle on microdisk relative to microdisk norm
theta_i2=phi+alpha; %angle of beam incident on lower face of viewport after reflection
theta_r2=asin((sin(theta_i2))/n2);

s1=h*tan(theta_i);
s2=d*tan(theta_r);     
s3=x3;

x1=h*tan(phi+alpha); %hz distance from beam on disk to viewport
x2=d*tan(theta_r2); %hz distance travelled through viewport
Py=x3/tan(theta_i2); %height of photodiode above viewport
Ly=s3/tan(theta_i); %height of laser above viewport

%% calculate the rays

%the x and y coordinates of the laser
laser_s=s1+s2+s3;
laser_y=h+d+Ly;

%the x and y coordinates of the laser incident on the upper face of the
%viewport
viewport_si=s1+s2;
viewport_yi=h+d;

%the x and y coordinates of the laser leaving the lower face of the
%viewport
viewport_sl=s1;
viewport_yl=h;

disk_x=0; %starting x coordinate of beam on microdisk
disk_y=0; %starting y coordinate of beam on microdisk

%the x and y coordinates of the reflected ray that hits the lower face of the
%viewport
viewport_x=x1;
viewport_y_lower=h;

%the x and y coordinates of the ray that hits the upper face of the
%viewport
air_x=x1+x2;
air_y=h+d;

%the x and y coordinates of the ray that hits the photodiode
photodiode_x=x1+x2+x3;
photodiode_y=h+d+Py;

%% make a diagram

%disk and viewport
fig1=figure;
viewport=rectangle('Position',[-viewport_w/2 h viewport_w d],'FaceColor',[0 .5 .5]);
microdisk=rectangle('Position',[-viewport_w/8 -d/8 viewport_w/4 d/8],'FaceColor',[.8 .8 .8]);
axis([-viewport_w 2*viewport_w -d/2 0.12]);

%draw the beam going from the laser to the viewport
Lx=[-laser_s -viewport_si];
Ly=[laser_y viewport_yi];
line(Lx,Ly,'Color','Red');

%draw the beam going through the viewport, downwards
Vx1=[-viewport_si -viewport_sl];
Vy1=[viewport_yi viewport_yl];
line(Vx1, Vy1, 'Color',  'Red');

%draw the beam going from the viewport to the disk
Vx1=[-viewport_sl disk_x];
Vy1=[viewport_yl disk_y];
line(Vx1, Vy1, 'Color',  'Red');

%draw the beam going from the microdisk to the viewport
Vx=[disk_x viewport_x];
Vy=[disk_y viewport_y_lower];
line(Vx,Vy,'Color','Red');

%draw the beam going through the viewport to air
Ax=[viewport_x air_x];
Ay=[viewport_y_lower air_y];
line(Ax,Ay,'Color','Red');

%draw the beam going to the photodiode
PDx=[air_x photodiode_x];
PDy=[air_y photodiode_y];
line(PDx,PDy,'Color','Red');

txt = 'viewport';
text(viewport_w/1.9,d+h,txt);

txt2 = 'microdisk';
text(viewport_w/4,2*d,txt2);