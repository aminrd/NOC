module out_validity (VR, VL, VU, VD, VEJ, clk,e_empl, w_empl, n_empl, s_empl, eject_empl,reset, R_status, L_status, U_status, D_status, EJ_status);

  output reg VR, VL, VU, VD, VEJ;
  input [2:0] e_empl, w_empl, n_empl, s_empl, eject_empl;
  input reset, R_status, L_status, U_status, D_status, EJ_status,clk;
  
  always @(*)
	if(reset)
		{VR, VL, VU, VD, VEJ} = 5'b11111;
	else
	begin
		{VR, VL, VU, VD, VEJ} = 'b0;
		if(R_status == 0 && (e_empl > 3'd0))  		  VR = 1;
		if(L_status == 0 && (w_empl > 3'd0))  		  VL = 1;
		if(U_status == 0 && (n_empl > 3'd0))  		  VU = 1;
		if(D_status == 0 && (s_empl > 3'd0))          VD = 1;
		if(EJ_status == 0 && (eject_empl > 3'd0))     VEJ = 1;
	end

endmodule
