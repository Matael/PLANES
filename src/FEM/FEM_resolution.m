% FEM_resolution.m
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


tic
for i_f=1:abs(nb_frequencies)
    FEM_progress=100*i_f/abs(nb_frequencies)
    
    freq=vec_freq(i_f);
    omega=2*pi*freq;
    k_air=omega/air.c;
    create_wave_vectors
    
    % Construction of the linear system
    
    A= sparse(nb_dof_FEM,nb_dof_FEM);
    F=zeros(nb_dof_FEM,1);
    
    
    if (nb_media.acou~=0)
        A=A+H_acou/(air.rho*omega^2)-Q_acou/(air.K);
    end
    
    
    if (nb_media.elas~=0)
        for i_mat=1:nb_media.elas
            eval(['Mat_elas_' num2str(num_media.elas(i_mat))])
            eval(['A=A+(lambda_solide+2*mu_solide)*K0_elas_',num2str(i_mat),'+mu_solide*K1_elas_',num2str(i_mat),'-omega^2*rho_solide*M_elas_',num2str(i_mat),';']);
        end
    end
    
    
    if (nb_media.eqf~=0)
        for i_mat=1:nb_media.eqf
            eval(['Mat_PEM_' num2str(num_media.eqf(i_mat))])
            properties_jca
            eval(['A=A+H_eqf_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_eqf_',num2str(i_mat),'/(K_eq_til);']);
        end
    end
    
    if (nb_media.limp~=0)
        for i_mat=1:nb_media.limp
            eval(['Mat_PEM_' num2str(num_media.limp(i_mat))])
            properties_limp
            eval(['A=A+H_limp_',num2str(i_mat),'/(rho_limp*omega^2)-Q_limp_',num2str(i_mat),'/(K_eq_til);']);
        end
    end
    if (nb_media.pem98~=0)
        for i_mat=1:nb_media.pem98
            eval(['Mat_PEM_' num2str(num_media.pem98(i_mat))])
            properties_jca
            properties_PEM
            eval(['A=A+P_hat*K0_pem98_',num2str(i_mat),'+N*K1_pem98_',num2str(i_mat),'-omega^2*rho_til*M_pem98_',num2str(i_mat),';']);
            eval(['A=A+H_pem98_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_pem98_',num2str(i_mat),'/(K_eq_til);']);
            eval(['A=A-gamma_til*(C_pem98_',num2str(i_mat),'+C_pem98_',num2str(i_mat),'.'');']);
        end
    end
    if (nb_media.pem01~=0)
        for i_mat=1:nb_media.pem01
            eval(['Mat_PEM_' num2str(num_media.pem01(i_mat))])
            properties_jca
            properties_PEM
            eval(['A=A+P_hat*K0_pem01_',num2str(i_mat),'+N*K1_pem01_',num2str(i_mat),'-omega^2*rho_til*M_pem01_',num2str(i_mat),';']);
            eval(['A=A+H_pem01_',num2str(i_mat),'/(rho_eq_til*omega^2)-Q_pem01_',num2str(i_mat),'/(K_eq_til);']);
            eval(['A=A-(gamma_til+1)*(C_pem01_',num2str(i_mat),'+C_pem01_',num2str(i_mat),'.'')-(Cp_pem01_',num2str(i_mat),'+Cp_pem01_',num2str(i_mat),'.'');']);
        end
    end
    
    
    if nb_interfaces~=0
        apply_FSI
    end
    
    
    
    if nb_MMT~=0
        
        TT=build_FEM_transfer(k_air*sin(theta_MMT),element_MMT_moins,element_MMT_plus,omega,multilayer_femtmm,k_air,air);
        
        
        switch floor(element_MMT_moins/1000)
            case {0 2 3}
                switch floor(element_MMT_plus/1000)
                    case {0 2 3}
                        link_FEMTMM_fluid_fluid
                end
            case 1
                switch floor(element_MMT_plus/1000)
                    case 1
                        link_FEMTMM_elas_elas
                end
                
                
        end
    end
    
    
    if (nb_R+nb_T)>0
        DtN_application
    end
    
    
    if (nb_loads)>0
        loads_application
    end
    
    
    if length(periodicity)>0
        periodicity_condition_application
    end
    
    
    
    %disp('Resolution of the system')
    X=A\F;
    
        
    sol(dof_back)=X(1:nb_dof_FEM);
    
    if exist('DtN_plate_R')
        rflx=T_back*  X(nb_dof_FEM+(1:size_info_vector_R*nb_R));
    else
        rflx=X(nb_dof_FEM+(1:size_info_vector_R*nb_R));
    end
    
    if exist('DtN_plate_R')
        trans=T_back_T*X(nb_dof_FEM+size_info_vector_R*nb_R+(1:size_info_vector_T*nb_T));
    else
        trans=X(nb_dof_FEM+size_info_vector_R*nb_R+(1:size_info_vector_T*nb_T));
    end
    
    
    
    if export_profiles==1
        if i_f==1
            sol_export=sol.';
            rflx_export=rflx.';
            trans_export=trans.';
        else
            sol_export=[sol_export sol.'];
            rflx_export=[rflx_export rflx.'];
            trans_export=[trans_export trans.'];
        end
    
        
    end

    
    if plot_profiles==1
       plot_sol_TR6 
    end

    
    if export_nrj==1
        Ks(i_f)=(omega^2/4)*rho_1*X(1:nb_dof_FEM)'*M_pem01_1*X(1:nb_dof_FEM);
        Kf(i_f)=(omega^2/4)*(real(rho_f_til)*X(1:nb_dof_FEM)'*M_pem01_1*X(1:nb_dof_FEM)+real(1/conj(rho_eq_til*omega^4))*X(1:nb_dof_FEM)'*H_pem01_1*X(1:nb_dof_FEM)-(2/omega^2)*imag(phi/alpha_til)*imag(X(1:nb_dof_FEM)'*C_pem01_1*X(1:nb_dof_FEM)));
        Wdef(i_f)=(1/4)*(real(P_hat)*X(1:nb_dof_FEM)'*K0_pem01_1*X(1:nb_dof_FEM)+real(N)*X(1:nb_dof_FEM)'*K1_pem01_1*X(1:nb_dof_FEM)+(phi^2*real(R_til)/abs(R_til)^2)*X(1:nb_dof_FEM)'*Q_pem01_1*X(1:nb_dof_FEM));
        
        W_vis(i_f)=(-pi*omega^2)*(imag(rho_til)*X(1:nb_dof_FEM)'*M_pem01_1*X(1:nb_dof_FEM)-imag(1/(rho_eq_til*omega^4))*X(1:nb_dof_FEM)'*H_pem01_1*X(1:nb_dof_FEM)+(2/omega^2)*imag(phi/alpha_til)*real(X(1:nb_dof_FEM)'*C_pem01_1*X(1:nb_dof_FEM)));
        W_struct(i_f)=pi*(imag(P_hat)*X(1:nb_dof_FEM)'*K0_pem01_1*X(1:nb_dof_FEM)+imag(N)*X(1:nb_dof_FEM)'*K1_pem01_1*X(1:nb_dof_FEM));
        W_therm(i_f)=(pi*phi^2*imag(R_til)/abs(R_til)^2)*X(1:nb_dof_FEM)'*Q_pem01_1*X(1:nb_dof_FEM);
        
        W_dis(i_f)=W_vis(i_f)+W_struct(i_f)+W_therm(i_f);
  
        I_inc(i_f)=(period/air.Z)/(2*vec_freq(i_f));
    end
    
    if nb_R~=0
    R_EF(i_f)=rflx(1);
    abs_EF(i_f)=1-sum(real(vec_k_z).'.*abs(rflx(1:size_info_vector_R:end)).^2)/real(k_z);
    end     
    
    if nb_T~=0
        TL_EF(i_f)=full(-10*log10(abs(sum(real(vec_k_z_t).'.*abs(trans(1:size_info_vector_T:end)).^2)/real(k_z))));
        fprintf(file_TL_id,'%1.15e \t %1.15e \n',freq,TL_EF(i_f));
    end
        
end
time_FEM=toc;

info_FEM


