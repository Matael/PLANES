function M=Phi_fluid_vector(nx,ny,Z_e,Shift)

n=length(nx);
M(1:3,1:n)=[-nx;-ny;Z_e*ones(1,n)];
M=repmat(M,n,1);

M=Shift.*M;
