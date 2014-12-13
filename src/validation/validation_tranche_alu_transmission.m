k_0=omega/c_0;

% Dans l'alu
%% u^s= A sin(k_e*(z-dyair-dyalu))
%% sigma=(lambda+2mu)*k_e*A*cos(k_e*(z-dyair-dyalu));
% Dans l'air
%% p^a= e^(-jk_0z)+R e^(jk_0z)
%% u^a= (jk_0/(rho_0*omega^2)) [R e^(jk_0z)-e^(-jk_0z)]

rho=2700.0000000000000     ;
lambda=51083591331.269348*(1+0.01*j);
mu=    26315789473.684208*(1+0.01*j);

%rho=rho_0;
%lambda=1e-3*rho_0*c_0^2;
%mu=0;

M_an=zeros(4,4);
F_an=zeros(4,1);

z=dyair;

k_e=omega*sqrt(rho/(lambda+2*mu));

z=dyair;
M_an(1,1)=-(lambda+2*mu)*k_e*cos(k_e*z);
M_an(1,2)= (lambda+2*mu)*k_e*sin(k_e*z);
M_an(1,3)=-exp( j*(k_0*z));
F_an(1,1)= exp(-j*(k_0*z));

M_an(2,1)=(rho_0*omega^2/(j*k_0))*sin(k_e*z);
M_an(2,2)=(rho_0*omega^2/(j*k_0))*cos(k_e*z);
M_an(2,3)=-exp( j*(k_0*z));
F_an(2,1)=-exp(-j*(k_0*z));

z=dyair+dyalu;
M_an(3,1)=-(lambda+2*mu)*k_e*cos(k_e*z);
M_an(3,2)= (lambda+2*mu)*k_e*sin(k_e*z);
M_an(3,4)=- exp(-j*(k_0*z));


M_an(4,1)=(rho_0*omega^2/(j*k_0))*sin(k_e*z);
M_an(4,2)=(rho_0*omega^2/(j*k_0))*cos(k_e*z);
M_an(4,4)=exp(-j*(k_0*z));




X_an=M_an\F_an;

A=X_an(1);
B=X_an(2);
R=X_an(3)
T=X_an(4)


z_air=linspace(0,dyair,100);
z_alu=linspace(dyair,dyair+dyalu,100);
z_trans=linspace(dyair+dyalu,2*dyair+dyalu,100);

%% u= A sin(k_e*(z-dyair-dyalu))
%% sigma=(lambda+2mu)*k_e*A*cos(k_e*(z-dyair-dyalu));
% Dans l'air
%% p^a= e^(-jk_0z)+R e^(jk_0z)
%% u^a= (jk_0/(rho_0*omega^2)) [R e^(jk_0z)-e^(-jk_0z)]


u_alu=A*sin(k_e*(z_alu))+B*cos(k_e*(z_alu));
sigma_alu=A*(lambda+2*mu)*k_e*cos(k_e*(z_alu))-B*(lambda+2*mu)*k_e*sin(k_e*(z_alu));

u_air=(j*k_0/(rho_0*omega^2))*(R*exp(j*k_0*z_air)-exp(-j*k_0*z_air));
sigma_air=-(R*exp(j*k_0*z_air)+exp(-j*k_0*z_air));

u_trans=(j*k_0/(rho_0*omega^2))*(T*exp(-j*k_0*z_trans));
sigma_trans=-(T*exp(-j*k_0*z_trans));



figure(567)
hold on
plot(z_air,abs(sigma_air))
plot(z_alu,abs(sigma_alu),'r')
plot(z_trans,abs(sigma_trans),'m')


figure(5678)
hold on
plot(z_air,abs(u_air))
plot(z_alu,abs(u_alu),'r')
plot(z_trans,abs(u_trans),'m')

figure(5679)
hold on
plot(z_air,angle(-sigma_air))
plot(z_alu,angle(-sigma_alu),'r')
plot(z_trans,angle(-sigma_trans),'m')


figure(56789)
hold on
plot(z_air,angle(u_air))
plot(z_alu,angle(u_alu),'r')
plot(z_trans,angle(u_trans),'m')