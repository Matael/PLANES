function FSIe = TR6_FSI(a1,a2)    J=norm(a2-a1)/2.00D+00;            npg=4;    ksi_g(1)= 0.339981043584856;    ksi_g(2)=-0.339981043584856;    ksi_g(3)= 0.861136311594053;    ksi_g(4)=-0.861136311594053;          p_g(1)=   0.652145154862546;    p_g(2)=   0.652145154862546;    p_g(3)=   0.347854845137454;    p_g(4)=   0.347854845137454;        FSIe=0.00D+00;	        for ipg=1:npg        	ksi=ksi_g(ipg);    	    	N(1,1)=-(1-ksi)*ksi/2;    	N(2,1)= (1+ksi)*ksi/2;    	N(3,1)= (1-ksi)*(1+ksi);    	    	FSIe=FSIe+N*N'*J*p_g(ipg);     end    