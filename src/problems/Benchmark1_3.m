dx=2e-2;
dy=2e-2;
nx=10;
ny=10;
labelexcitation=10060;
labelelement=3003;
fid=fopen(name_file_input_FreeFem,'w');
fprintf(fid,'%s\n',name_file_msh);
fprintf(fid,'%12.8f\n',dx);
fprintf(fid,'%12.8f\n',dy);
fprintf(fid,'%d\n',nx);
fprintf(fid,'%d\n',ny);
fprintf(fid,'%d\n',labelexcitation);
fprintf(fid,'%d\n',labelelement);
fclose(fid);

