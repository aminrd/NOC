module IO_request (R_req, L_req, U_req, D_req, EJ_req,R_vcg, L_vcg, U_vcg, D_vcg, EJ_vcg,reset,e_req, w_req, n_req, s_req, j_req);
  
  output reg R_req, L_req, U_req, D_req, EJ_req;//responds	
  input R_vcg, L_vcg, U_vcg, D_vcg, EJ_vcg,reset;
  input [2:0] e_req, w_req, n_req, s_req, j_req;//requests
  always @(*)
	if (reset)
		{R_req, L_req, U_req, D_req, EJ_req} = 'b0;//reset
	else
	begin
		{R_req, L_req, U_req, D_req, EJ_req} = 'b0;//reset
		if(R_vcg == 1)
		  case (e_req)
			3'b000:  R_req = 1;
			3'b001:  L_req = 1;
			3'b010:  U_req = 1;
			3'b011:  D_req = 1;
			3'b100:  EJ_req = 1;
		  endcase
		if(L_vcg == 1)
		  case (w_req)
			3'b000:  R_req = 1;
			3'b001:  L_req = 1;
			3'b010:  U_req = 1;
			3'b011:  D_req = 1;
			3'b100:  EJ_req = 1;
		  endcase
		if(U_vcg == 1)
		  case (n_req)
			3'b000:  R_req = 1;
			3'b001:  L_req = 1;
			3'b010:  U_req = 1;
			3'b011:  D_req = 1;
			3'b100:  EJ_req = 1;
		  endcase
		if(D_vcg == 1)
		  case (s_req)
			3'b000:  R_req = 1;
			3'b001:  L_req = 1;
			3'b010:  U_req = 1;
			3'b011:  D_req = 1;
			3'b100:  EJ_req = 1;
		  endcase
		if(EJ_vcg == 1)
		  case (j_req)
			3'b000:  R_req = 1;
			3'b001:  L_req = 1;
			3'b010:  U_req = 1;
			3'b011:  D_req = 1;
			3'b100:  EJ_req = 1;
		  endcase
	end	
  
endmodule

