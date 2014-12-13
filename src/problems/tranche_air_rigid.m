dxair=2e-1;
dyair=0.2e-1;
nx=20;
labelexcitation=10000;
ny=ceil(nx*dyair/dxair);
fid=fopen(nom_fichier_input_FreeFem,'w');
fprintf(fid,'%s\n',nom_fichier_msh);
fprintf(fid,'%12.8f\n',dxair);
fprintf(fid,'%12.8f\n',dyair);
fprintf(fid,'%d\n',nx);
fprintf(fid,'%d\n',ny);
fprintf(fid,'%d\n',labelexcitation);
fclose(fid);