% SminusA_fluid_fluid.m
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
% https://github.com/OlivierDAZEL/PLANES
% or find more details on Olivier's webpage
% http://perso.univ-lemans.fr/~odazel/
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
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
%%


% Initialization of the State vectors in media 1 and 2
if multilayer(1).mat==0
    k_z_2=sqrt(k_air^2-k_x^2);
    SV_2=State_fluid_2D(k_x,k_z_2,air.K);
    dof_medium_2=nS_minus+[1:2];
else
    eval(['Mat_porous_' num2str(multilayer(1).mat-1000*floor(multilayer(1).mat/1000))])
    typ_mat=floor(multilayer(1).mat/1000);
    properties_eqf
    k_z_2=sqrt((omega*sqrt(rho_eq_til/K_eq_til))^2-k_x^2);
    SV_2=State_fluid_2D(k_x,k_z_2,K_eq_til);
    dof_medium_2=nS_minus+[1:2];
end

% Continuity of normal displacement
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,1)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(1,1);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(1,2)*exp(-1j*k_z_2*multilayer(1).d);
% Continuity of the pressure
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,2)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(2,1);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(2,2)*exp(-1j*k_z_2*multilayer(1).d);