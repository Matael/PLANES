[i_temp,j_temp,s_temp] = find(vk0);
ll=length(i_temp);
i_k0_pem01=[i_k0_pem01;index_e(i_temp)'];
j_k0_pem01=[j_k0_pem01;index_e(j_temp)'];
v_k0_pem01(1:end+ll,element_num_mat(ie))=[v_k0_pem01(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vk1);
ll=length(i_temp);
i_k1_pem01=[i_k1_pem01;index_e(i_temp)'];
j_k1_pem01=[j_k1_pem01;index_e(j_temp)'];
v_k1_pem01(1:end+ll,element_num_mat(ie))=[v_k1_pem01(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vm);
ll=length(i_temp);
i_m_pem01=[i_m_pem01;index_e(i_temp)'];
j_m_pem01=[j_m_pem01;index_e(j_temp)'];
v_m_pem01(1:end+ll,element_num_mat(ie))=[v_m_pem01(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vh);
ll=length(i_temp);
i_h_pem01=[i_h_pem01;index_p(i_temp)'];
j_h_pem01=[j_h_pem01;index_p(j_temp)'];
v_h_pem01(1:end+ll,element_num_mat(ie))=[v_h_pem01(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vq);
ll=length(i_temp);
i_q_pem01=[i_q_pem01;index_p(i_temp)'];
j_q_pem01=[j_q_pem01;index_p(j_temp)'];
v_q_pem01(1:end+ll,element_num_mat(ie))=[v_q_pem01(:,element_num_mat(ie));s_temp];

[i_temp,j_temp,s_temp] = find(vc);
ll=length(i_temp);
i_c_pem01=[i_c_pem01;index_e(i_temp)'];
j_c_pem01=[j_c_pem01;index_p(j_temp)'];
v_c_pem01(1:end+ll,element_num_mat(ie))=[v_c_pem01(:,element_num_mat(ie));s_temp];

[i_temp,j_temp,s_temp] = find(vcp);
ll=length(i_temp);
i_cp_pem01=[i_cp_pem01;index_e(i_temp)'];
j_cp_pem01=[j_cp_pem01;index_p(j_temp)'];
v_cp_pem01(1:end+ll,element_num_mat(ie))=[v_cp_pem01(:,element_num_mat(ie));s_temp];
