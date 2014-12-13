clear all
close all
clc
list_path=['''FEM'',''generate_mesh'',''Materials'',''Mesh'',''Physics'',''plots'',''Utils'',''validation'',''PW'',''analytical_solutions'''];
eval(['addpath(' list_path ');'])

% name_of_project='Benchmark5';
% subproject=0;
% nb_frequencies=10;%-50;
% freq_min=50;
% freq_max=5000;
% export_profiles=1;

name_of_project='FEM_TMM_pb1';
subproject=1;
nb_frequencies=-100;%-50;
freq_min=50;
freq_max=5000;
export_profiles=1;

%h= waitbar (0, 'PLANES  INITIALIZATION');
init_PLANES
air_properties_maine
init_vec_frequencies

% Angle of incidence
theta=30*pi/180;
% Termination condition // 0 for rigid backing 1 for radiation
termination=1;

% Including the air incident medium (layer #1)
nb_layers=3;
multilayer(1).d=1e-3;
multilayer(1).mat=1001;
multilayer(2).d=20e-3;
multilayer(2).mat=0;
multilayer(3).d=1e-3;
multilayer(3).mat=1001;

% Number of waves (two ways) in each layer
% For the resolution, the incident waves is included in the system and put to RHS at the
% end of the procedure

% Addition of a new layer for the incident medium
l0.d=0;
l0.mat=0;
multilayer=[l0 multilayer];
nb_layers=nb_layers+1;



compute_number_PW_TMM


% Frequency loop

for i_freq=1:abs(nb_frequencies)

    omega=2*pi*vec_freq(i_freq);
    k_air=omega/c_0;
    k_x=k_air*sin(theta);
    
    build_global_PW_matrices
    solve_PW_global
    
end


if termination==0
    figure
    maine=load('../../Maine/TCLTK/out.dat');
    plot(maine(:,1),maine(:,4))
    hold on
    plot(vec_freq,abs_PW,'r.')
else
    figure
    maine=load('../../Maine/TCLTK/out.dat');
    
    semilogx(maine(:,1),maine(:,2))
    hold on
    semilogx(vec_freq,TL_PW,'r.')
end


%
% %plot(vec_theta,abs_analytic,'r.')
%
% plot(vec_theta,abs_theta(:,1),'m.')
%
% %plot(vec_theta,abs(abs_theta(:,1)),'r.')
% %plot(vec_theta,abs(abs_theta(:,1)-maine(:,4)),'r.')
%
% plot(vec_theta,abs(abs_theta(:,1)-abs_analytic'),'m.')
% %plot(vec_theta,abs_theta(:,2),'m')
% %plot(vec_theta,abs(abs_theta(:,2)-maine(:,4)),'m.')
% %plot(vec_theta,abs_theta(:,3),'c')
% %plot(vec_theta,abs(abs_theta(:,3)-maine(:,4)),'c.')


% surf(vec_theta,vec_theta_MMT,(abs(abs_theta)))
% view([0 90])
% shading interp
% colorbar
% print('-djpeg','toto.jpg')
