[i_temp,j_temp,s_temp] = find(vk0);
ll=length(i_temp);
i_k0_pem98=[i_k0_pem98;index_e(i_temp)'];
j_k0_pem98=[j_k0_pem98;index_e(j_temp)'];
v_k0_pem98(1:end+ll,element_num_mat(ie))=[v_k0_pem98(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vk1);
ll=length(i_temp);
i_k1_pem98=[i_k1_pem98;index_e(i_temp)'];
j_k1_pem98=[j_k1_pem98;index_e(j_temp)'];
v_k1_pem98(1:end+ll,element_num_mat(ie))=[v_k1_pem98(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vm);
ll=length(i_temp);
i_m_pem98=[i_m_pem98;index_e(i_temp)'];
j_m_pem98=[j_m_pem98;index_e(j_temp)'];
v_m_pem98(1:end+ll,element_num_mat(ie))=[v_m_pem98(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vh);
ll=length(i_temp);
i_h_pem98=[i_h_pem98;index_p(i_temp)'];
j_h_pem98=[j_h_pem98;index_p(j_temp)'];
v_h_pem98(1:end+ll,element_num_mat(ie))=[v_h_pem98(:,element_num_mat(ie));s_temp];
[i_temp,j_temp,s_temp] = find(vq);
ll=length(i_temp);
i_q_pem98=[i_q_pem98;index_p(i_temp)'];
j_q_pem98=[j_q_pem98;index_p(j_temp)'];
v_q_pem98(1:end+ll,element_num_mat(ie))=[v_q_pem98(:,element_num_mat(ie));s_temp];

[i_temp,j_temp,s_temp] = find(vc);
ll=length(i_temp);
i_c_pem98=[i_c_pem98;index_e(i_temp)'];
j_c_pem98=[j_c_pem98;index_p(j_temp)'];
v_c_pem98(1:end+ll,element_num_mat(ie))=[v_c_pem98(:,element_num_mat(ie));s_temp];

