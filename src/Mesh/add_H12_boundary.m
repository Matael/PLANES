function [nb_out,nodes_out,elem_out,edge_msh_out] = add_H12_boundary(l_supp,label_boundary,label_elem_ajoute,model_elem_ajoute,edge_msh,nodes,elem,nb)


temp=find(edge_msh(:,3)==51)
num_nodes_edge=unique(reshape(edge_msh(temp,1:2),[],1))
edge_msh(temp,:)=[];

nodes_edge=nodes(num_nodes_edge,:)
nb_nodes_edge=length(nodes_edge)

fit_x=polyfit(nodes_edge(:,1),nodes_edge(:,2),1)
fit_y=polyfit(nodes_edge(:,2),nodes_edge(:,1),1)
if abs(fit_x(1))<abs(fit_y(1))
    nodes_temp=nodes_edge;
    nodes_temp(:,2)=nodes_temp(:,2)-fit_x(2)-fit_x(1)*nodes_temp(:,1)
    [~,order_nodes]=sort(nodes_temp(:,1))
    nodes_edge=nodes_edge(order_nodes,:)
    num_nodes_edge=num_nodes_edge(order_nodes);
    length_edge=norm(nodes_edge(1,:)-nodes_edge(end,:))
    
    v_dir=nodes_edge(2,:)-nodes_edge(1,:)
    v_dir=v_dir/norm(v_dir)
    v_orth=[-v_dir(2) v_dir(1)]
    nb_y=ceil((length(nodes_edge)-1)*l_supp/length_edge)
    l_y_elem=l_supp/nb_y;
    for i_y=1:nb_y
        for i_x=1:nb_nodes_edge
            nodes=[nodes;nodes_edge(i_x,:)+l_y_elem*v_orth*i_y];
        end
    end
    i_y=1
    for i_x=1:nb_nodes_edge-1
            elem.nodes(end+1,1:4)=[num_nodes_edge(i_x) num_nodes_edge(i_x+1) nb.nodes+i_x+1 nb.nodes+i_x];
    end
    for i_y=2:nb_y
        for i_x=1:nb_nodes_edge-1
            elem.nodes(end+1,1:4)=[nb.nodes+nb_nodes_edge*(i_y-2)+i_x nb.nodes+nb_nodes_edge*(i_y-2)+i_x+1 nb.nodes+nb_nodes_edge*(i_y-1)+i_x+1 nb.nodes+nb_nodes_edge*(i_y-1)+i_x];
        end
    end
    
    
    
    
else
    rzerzeerzerz
    nodes_temp=nodes_edge;
    nodes_temp(:,1)=nodes_temp(:,1)-fit_y(2)-fit_y(1)*nodes_temp(:,2)
    [~,order_nodes]=sort(nodes_temp(:,2))
end



edge_msh=[edge_msh; num_nodes_edge(1) nb.nodes+1 1]
edge_msh=[edge_msh; num_nodes_edge(end) nb.nodes+nb_nodes_edge 1]
for ii=1:nb_y-1
    edge_msh=[edge_msh; nb.nodes+1+(ii-1)*nb_nodes_edge nb.nodes+1+ii    *nb_nodes_edge 1]
    edge_msh=[edge_msh; nb.nodes+nb_nodes_edge+(ii-1)*nb_nodes_edge nb.nodes+nb_nodes_edge+(ii)*nb_nodes_edge 1] 
end
for ii=1:nb_nodes_edge-1
    edge_msh=[edge_msh; nb.nodes+(nb_y-1)*nb_nodes_edge+ii nb.nodes+(nb_y-1)*nb_nodes_edge+ii+1 1]
end



nb.edges=size(edge_msh,1);





nb.nodes=size(nodes,1);
nb.elements=size(elem.nodes,1);

elem.label(end+1:nb.elements)=label_elem_ajoute;
elem.model(end+1:nb.elements)=model_elem_ajoute;

nb_out=nb;
nodes_out=nodes;
elem_out=elem;
edge_msh_out=edge_msh
end

