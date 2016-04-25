% TR6_PML_axi.m%% Copyright (C) 2015 < Olivier DAZEL <olivier.dazel@univ-lemans.fr> >%% This file is part of PLANES.%% PLANES (Porous LAum NumErical Simulator) is a software to compute the% vibroacoustic response of sound packages containing coupled% acoustic/elastic/porous substructures. It is mainly based on the% Finite-Element Method and some numerical methods developped at% LAUM (http://laum.univ-lemans.fr).%% You can download the latest version of PLANES at% https://github.com/OlivierDAZEL/PLANES% or find more details on Olivier's webpage% http://perso.univ-lemans.fr/~odazel/%% For any questions or if you want to% contribute to this project, contact Olivier.%% PLANES is free software: you can redistribute it and/or modify% it under the terms of the GNU General Public License as published by% the Free Software Foundation, either version 3 of the License, or% (at your option) any later version.%% This program is distributed in the hope that it will be useful,% but WITHOUT ANY WARRANTY; without even the implied warranty of% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the% GNU General Public License for more details.%% You should have received a copy of the GNU General Public License% along with this program. If not, see <http://www.gnu.org/licenses/>.%%function [vh,vq] = TR6_PML_axi(coord_e,PML_parameter,PML_direction)% Gauss Points Data%------------------------------coord_e_0(1,:)=coord_e(1,:);if PML_direction.x==1    if PML_parameter.model==0        coord_e(1,:)=exp(1j*pi/4)*coord_e(1,:);    else        coord_e(1,:)=(1+1j*PML_direction.x*(PML_parameter.beta*(abs(coord_e(1,:))-PML_parameter.x0).^2)).*coord_e(1,:);    endendif PML_direction.y==1    if PML_parameter.model==0        coord_e(2,:)=exp(1j*pi/4)*coord_e(2,:);    else        coord_e(2,:)=(1+1j*PML_direction.y*(PML_parameter.beta*(abs(coord_e(2,:))-PML_parameter.y0).^2)).*coord_e(2,:);    endend%coord_e(1,:)=(sqrt(tau_x))*coord_e(1,:);%coord_e(2,:)=1*coord_e(2,:);% coord_e(1,:)=tau_x*coord_e(1,:);% coord_e(2,:)=tau_y*coord_e(2,:);npg=6;a=0.445948490915965;b=0.091576213509771;P1=0.111690794839005;P2=0.054975871827661;ksig=[  a, a;    1-2*a, a;    a,   1-2*a;    b, b;    1-2*b, b;    b, 1-2*b];w_g=[P1,P1,P1,P2,P2,P2];% Matrices initialization%-----------------------vh=zeros(6,6);vq=zeros(6,6);% Loop on Gauss Points%------------------for ipg=1:npg,    ksi=ksig(ipg,1);    eta=ksig(ipg,2);    lambda=1-ksi-eta;        Phi =  [ -lambda*(1-2*lambda)  4*ksi*lambda  -ksi*(1-2*ksi) 4*ksi*eta -eta*(1-2*eta) 4*eta*lambda];    dPhi  = [ 1-4*lambda 4*(lambda-ksi) -1+4*ksi 4*eta 0 -4*eta; ...             1-4*lambda -4*ksi 0 4*ksi -1+4*eta 4*(lambda-eta)];    J = dPhi*coord_e.';    r=Phi*coord_e_0(1,:).';        weight = r*w_g(ipg) * det(J);        vB =J\dPhi;       Gd=[vB(1,1) vB(1,2) vB(1,3) vB(1,4) vB(1,5) vB(1,6);           vB(2,1) vB(2,2) vB(2,3) vB(2,4) vB(2,5) vB(2,6)];    vh=vh+Gd.'*Gd*weight;    vq=vq+Phi.'*Phi*weight;end;  