period=60e-3;
thicknessporous=5.5e-2;
labelporous=5005;
labelinclusion=1004;
radius=20e-3;
nx=20;



fid=fopen(name_file_input_FreeFem,'w');
fprintf(fid,'%s\n',name_file_msh);
fprintf(fid,'%12.8f\n',period);
fprintf(fid,'%12.8f\n',thicknessporous);
fprintf(fid,'%d\n',labelporous);
fprintf(fid,'%d\n',labelinclusion);
fprintf(fid,'%12.8f\n',radius);
fprintf(fid,'%d\n',nx);
fclose(fid);


nb_layers=1;
multilayer(1).d=thicknessporous;
multilayer(1).mat=labelporous;
% Termination condition // 0 for rigid backing 1 for radiation
termination=0;

% Number of waves (two ways) in each layer
% For the resolution, the incident waves is included in the system and put to RHS at the
% end of the procedure

% Addition of a new layer for the incident medium
l0.d=0;
l0.mat=0;
multilayer=[l0 multilayer];
nb_layers=nb_layers+1;

compute_number_PW_TMM