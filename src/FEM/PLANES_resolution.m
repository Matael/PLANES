% PLANES_resolution.m
%
% Copyright (C) 2015 < Olivier DAZEL <olivier.dazel@univ-lemans.fr> >
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


tic

if (nb.dof_DGM+nb.dof_FEM)>0
    for i_f=1:abs(frequency.nb)
        PLANES_resolution_progress=100*i_f/abs(frequency.nb)
        
        freq=frequency.vec(i_f);
        omega=2*pi*freq;
        k_air=omega/air.c;
        
        if (nb.R+nb.T)~=0
            [k_x,k_z,nb,vec_k_x,vec_k_x_t,vec_k_z,vec_k_z_t]=create_wave_vectors(omega,air,nb,data_model.theta_inc,period);
        end
        
        % Construction of the linear system
        nb.dof_total=nb.dof_FEM+nb.dof_DGM;
        if nb.R>0
            nb.dof_total=nb.dof_total+nb.R*size_info_vector_R;
        end
        if nb.T>0
            nb.dof_total=nb.dof_total+nb.T*size_info_vector_T;
        end
        A=sparse(nb.dof_total,nb.dof_total);
        F=zeros(nb.dof_total,1);
        
        if nb.dof_FEM>0
            if (nb.media.acou~=0)
                A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_acou/(air.rho*omega^2)-Q_acou/(air.K);
            end
            
            if (nb.media.PML~=0)
                A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_PML/(air.rho*omega^2)-Q_PML/(air.K);
            end
            
            
            if (nb.media.elas~=0)
                for i_mat=1:nb.media.elas
                    eval(['Mat_elas_' num2str(num_media.elas(i_mat))])
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+(lambda_solide+2*mu_solide)*K0_elas_',num2str(i_mat),'+mu_solide*K1_elas_',num2str(i_mat),'-omega^2*rho_solide*M_elas_',num2str(i_mat),';']);
                end
            end
            if (nb.media.eqf~=0)
                for i_mat=1:nb.media.eqf
                    eval(['Mat_PEM_' num2str(num_media.eqf(i_mat))])
                    properties_eqf
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_eqf_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_eqf_',num2str(i_mat),'/(K_eq_til);']);
                end
            end
            
            if (nb.media.limp~=0)
                for i_mat=1:nb.media.limp
                    eval(['Mat_PEM_' num2str(num_media.limp(i_mat))])
                    properties_limp
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_limp_',num2str(i_mat),'/(rho_limp*omega^2)-Q_limp_',num2str(i_mat),'/(K_eq_til);']);
                end
            end
            if (nb.media.pem98~=0)
                for i_mat=1:nb.media.pem98
                    eval(['Mat_PEM_' num2str(num_media.pem98(i_mat))])
                    properties_eqf
                    properties_PEM
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+P_hat*K0_pem98_',num2str(i_mat),'+N*K1_pem98_',num2str(i_mat),'-omega^2*rho_til*M_pem98_',num2str(i_mat),';']);
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_pem98_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_pem98_',num2str(i_mat),'/(K_eq_til);']);
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)-gamma_til*(C_pem98_',num2str(i_mat),'+C_pem98_',num2str(i_mat),'.'');']);
                end
            end
            if (nb.media.pem01~=0)
                for i_mat=1:nb.media.pem01
                    eval(['Mat_PEM_' num2str(num_media.pem01(i_mat))])
                    properties_jca
                    properties_PEM
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+P_hat*K0_pem01_',num2str(i_mat),'+N*K1_pem01_',num2str(i_mat),'-omega^2*rho_til*M_pem01_',num2str(i_mat),';']);
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)+H_pem01_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_pem01_',num2str(i_mat),'/(K_eq_til);']);
                    eval(['A(1:nb.dof_FEM,1:nb.dof_FEM)=A(1:nb.dof_FEM,1:nb.dof_FEM)-(gamma_til+1)*(C_pem01_',num2str(i_mat),'+C_pem01_',num2str(i_mat),'.'')-(Cp_pem01_',num2str(i_mat),'+Cp_pem01_',num2str(i_mat),'.'');']);
                end
            end
        end

        if (nb.internal>0)
            apply_FSI
        end
        
        
        if (nb.loads>0)
            loads_application
        end
        if (nb.DtN>0)
            DtN_application
        end
        

        
        if (nb.dirichlets>0)
            for ie=1:nb.dirichlets
                if ismember(elem.model(edges.dirichlets(ie,3)),[10 11])
                    boundary_rigid_wall_fluid
                end
            end
        end
        
        if nb.ZOD~=0
 
           switch floor(elem.ZOD_moins/1000)
                case {0 2 3}
                    switch floor(elem.ZOD_plus/1000)
                        case {0 2 3}
                            ZOD_fluid_fluid
                    end
                case 1
                    switch floor(elem.ZOD_plus/1000)
                        case 1
                            ZOD_elas_elas
                    end
            end
        end
                
        
        
        if nb.flux>0
            for ie=1:nb.flux
                if ((ismember(elem.model(edges.flux(ie,3)),[1 2 3]))&&(ismember(elem.model(edges.flux(ie,4)),[1 2 3])))
                    internal_fluid_FEM_FEM
                end
                if ((ismember(elem.model(edges.flux(ie,3)),[10 11]))&&(ismember(elem.model(edges.flux(ie,4)),[10 11])))
                    internal_fluid_DGM_DGM
                end
                if  ismember(elem.model(edges.flux(ie,3)),[1 2 3])&&ismember(elem.model(edges.flux(ie,4)),[10 11])
                    internal_fluid_FEM_DGM
                elseif ismember(elem.model(edges.flux(ie,3)),[10 11])&&ismember(elem.model(edges.flux(ie,4)),[1 2 3])
                    temp=edges.flux(ie,3);
                    edges.flux(ie,3)=edges.flux(ie,4);
                    edges.flux(ie,4)=temp;
                    internal_fluid_FEM_DGM
                end
            end
        end
        
 
        if (nb.periodicity>0)
            periodicity_condition_application
        end
        

        disp('Resolution of the system')
        X=A\F;
        disp('End of the resolution of the system')
        
        postprocess_solution
        
        if exist([name.project_full '_postprocess'])==2
            eval([name.project_full '_postprocess']) 
        end
    end
    time_PLANES=toc;
end

if exist('multilayer')
    
    PW_resolution
end
