% Initialization of the State vectors in media 1 and 2
if multilayer(end).mat==0
    k_z_2=sqrt(k_air^2-k_x^2);
    SV_2=State_fluid(k_x,k_z_2,air.K);
    dof_medium_2=nS_minus+nb_amplitudes+1-[2:-1:1];
else
    eval(['Mat_fluid_' num2str(multilayer(end).mat-1000*floor(multilayer(end).mat/1000))])
    properties_jca
    k_z_2=sqrt((omega*sqrt(rho_eq_til/K_eq_til))^2-k_x^2);
    SV_2=State_fluid(k_x,k_z_2,K_eq_til);
    dof_medium_2=nS_minus+nb_amplitudes+1-[2:-1:1];
end

% Continuity of normal displacement
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,nS_minus+nb_amplitudes+1)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(1,1)*exp(-1j*k_z_2*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(1,2);
% Continuity of the pressure
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,nS_minus+nb_amplitudes+2)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(2,1)*exp(-1j*k_z_2*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(2,2);