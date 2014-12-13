% Initialization of the State vectors in media 1 and 2

eval(['Mat_PEM_' num2str(multilayer(end).mat-1000*floor(multilayer(end).mat/1000))])
properties_jca
properties_PEM
compute_Biot_waves
k_z_2=sqrt([delta_1 delta_2 delta_3].^2-k_x^2);
SV_2=State_PEM(k_x,delta_1,delta_2,delta_3,mu_1,mu_2,mu_3,N,A_hat,K_eq_til);
dof_medium_2=nS_minus+nb_amplitudes+1-[6:-1:1];



% Continuity of normal displacement
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,nS_minus+nb_amplitudes+1)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(3,1)*exp(-1j*k_z_2(1)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(3,2)*exp(-1j*k_z_2(2)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(3))=SV_2(3,3)*exp(-1j*k_z_2(3)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(4))=SV_2(3,4);
Mat_PW(number_of_eq,dof_medium_2(5))=SV_2(3,5);
Mat_PW(number_of_eq,dof_medium_2(6))=SV_2(3,6);
% Continuity of the pressure
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,nS_minus+nb_amplitudes+2)= -1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(5,1)*exp(-1j*k_z_2(1)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(5,2)*exp(-1j*k_z_2(2)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(3))=SV_2(5,3)*exp(-1j*k_z_2(3)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(4))=SV_2(5,4);
Mat_PW(number_of_eq,dof_medium_2(5))=SV_2(5,5);
Mat_PW(number_of_eq,dof_medium_2(6))=SV_2(5,6);

% Nullity of sigma_xz
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(1,1)*exp(-1j*k_z_2(1)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(1,2)*exp(-1j*k_z_2(2)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(3))=SV_2(1,3)*exp(-1j*k_z_2(3)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(4))=SV_2(1,4);
Mat_PW(number_of_eq,dof_medium_2(5))=SV_2(1,5);
Mat_PW(number_of_eq,dof_medium_2(6))=SV_2(1,6);

% Nullity of sigma_zz
number_of_eq=number_of_eq+1;
Mat_PW(number_of_eq,dof_medium_2(1))=SV_2(4,1)*exp(-1j*k_z_2(1)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(2))=SV_2(4,2)*exp(-1j*k_z_2(2)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(3))=SV_2(4,3)*exp(-1j*k_z_2(3)*multilayer(end).d);
Mat_PW(number_of_eq,dof_medium_2(4))=SV_2(4,4);
Mat_PW(number_of_eq,dof_medium_2(5))=SV_2(4,5);
Mat_PW(number_of_eq,dof_medium_2(6))=SV_2(4,6);