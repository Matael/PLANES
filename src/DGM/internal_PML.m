c_e=air.c;
k_e=omega/c_e;
Z_e=air.Z;


parameter_element
tau_x
tau_y

M_e=diag([air.rho,air.rho,1/air.K]);

[F_plus,F_moins]=Split_PML(nx,ny,Z_e,tau_x,tau_y);

delta_test=k_e;
delta_champs=k_e;


nx=cos(vec_theta);
ny=sin(vec_theta);
Phi=Phi_fluid_vector(nx,ny,air.Z,Shift_fluid);

II=int_edge_2vectorielle(1j*delta_test*[nx*tau_x;ny*tau_y],-1j*delta_champs*[nx*tau_x;ny*tau_y],a,b,[c_2 c_2]);
MM=kron(II,F_plus);
indice_test  =((1:nb_theta)-1)+dof_start_element(e_2);  
indice_champs=((1:nb_theta)-1)+dof_start_element(e_2);
A(indice_test,indice_champs)=A(indice_test,indice_champs)+Phi.'*MM*Phi*tau_x*tau_y;

        
II=int_edge_2vectorielle(1j*delta_test*[nx*tau_x;ny*tau_y],-1j*delta_champs*[nx*tau_x;ny*tau_y],a,b,[c_2 c_1]);
MM=kron(II,F_moins);
indice_test  =((1:nb_theta)-1)+dof_start_element(e_2);  
indice_champs=((1:nb_theta)-1)+dof_start_element(e_1);
A(indice_test,indice_champs)=A(indice_test,indice_champs)+Phi.'*MM*Phi*tau_x*tau_y;

II=int_edge_2vectorielle(1j*delta_test*[nx*tau_x;ny*tau_y],-1j*delta_champs*[nx*tau_x;ny*tau_y],a,b,[c_1 c_2]);
MM=kron(II,-F_plus);
indice_test  =((1:nb_theta)-1)+dof_start_element(e_1);  
indice_champs=((1:nb_theta)-1)+dof_start_element(e_2);
A(indice_test,indice_champs)=A(indice_test,indice_champs)+Phi.'*MM*Phi*tau_x*tau_y;

II=int_edge_2vectorielle(1j*delta_test*[nx*tau_x;ny*tau_y],-1j*delta_champs*[nx*tau_x;ny*tau_y],a,b,[c_1 c_1]);
MM=kron(II,-F_moins);
indice_test  =((1:nb_theta)-1)+dof_start_element(e_1);  
indice_champs=((1:nb_theta)-1)+dof_start_element(e_1);
A(indice_test,indice_champs)=A(indice_test,indice_champs)+Phi.'*MM*Phi*tau_x*tau_y;

