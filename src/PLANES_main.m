% PLANES_main.m
%
% Copyright (C) 2014 < Olivier DAZEL <olivier.dazel@univ-lemans.fr> >
%
% This file is part of PLANES.
%
% PLANES (Porous LAum NumErical Simulator) is a software to compute the
% vibroacoustic response of sound packages containing coupled
% acoustic/elastic/porous substructures. It is mainly based on the
% Finite-Element Method and some numerical methods developped at
% LAUM (http://laum.univ-lemans.fr).
%
% You can download the latest version of PLANES at
%                 https://github.com/OlivierDAZEL/PLANES
% or find more details on Olivier's webpage
%                  http://perso.univ-lemans.fr/~odazel/
%
% For any questions or if you want to
% contribute to this project, contact Olivier.
%
% PLANES is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%

clear all
close all
clc
list_path=['''FEM'',''problems'',''Materials'',''Mesh'',''Physics'',''plots'',''Utils'',''validation'',''PW'',''analytical_solutions'''];
eval(['addpath(' list_path ');'])

name_of_project='sandwich';
subproject=0;
% Number of frequencies
% If the number is negative then a logscale is chosen
% If the number is equal to 1, then the frequency is equal to freq_min
nb_frequencies=-100;%-50;
freq_min=100;
freq_max=3000;
export_profiles=0;
plot_profiles=0;
export_nrj=1;


%% Initialization of PLANES
init_PLANES
air_properties_maine
init_vec_frequencies

%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call to FreeFEM++ to create the Mesh and importation of the mesh
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval([name_of_project_full])

system(['/usr/local/bin/FreeFem++ ' name_file_edp])

tic

disp('Importing Mesh')

[nb_nodes,nb_elements,nb_edges,nodes,elements,element_label,edges,nb_media,num_media,element_num_mat,nb_interfaces,interfaces,...
    nb_MMT,edges_MMT,nb_loads,loads,nb_dirichlets,dirichlets,nb_periodicity,periodicity]=msh2TR6(name_file_msh,0);


analyze_mesh


disp('End of mesh importation')
toc


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Construction of global shape matrices
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp('Building shape matrices')

EF_TR6_global_build

disp('Assembling the problem')


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Frequency loop
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


file_abs_id=fopen(name_file_abs,'w');
if nb_T~=0
    file_TL_id=fopen(name_file_TL,'w');
end


vec_theta=45;
vec_theta_MMT=0;


for i_theta=1:length(vec_theta)
    i_theta/length(vec_theta)
    theta=vec_theta(i_theta)*pi/180;
    
    for i_theta_MMT=1:length(vec_theta_MMT)
        
        theta_MMT=vec_theta_MMT(i_theta_MMT)*pi/180;
        disp('FEM Resolution')
        FEM_resolution
        
        
        disp('PW Resolution')
        PW_resolution
        
    end
end

fclose(file_abs_id);

if nb_T~=0
    fclose(file_TL_id);
end


figure
semilogx(vec_freq,TL_EF,'.')
hold on
semilogx(vec_freq,TL_PW)
xlabel('Frequency [Hz]')
ylabel('Transmission Loss [dB]')
legend('FEM','Plane Waves','Location','SouthEast')


eval(['rmpath(' list_path ');'])