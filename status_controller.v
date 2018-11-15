module status_controller (R_req, L_req, U_req, D_req, EJ_req, R1, L1, U1, D1, EJ1,clk, reset, R2, L2, U2, D2, EJ2, en1, en2, en3, en4, en5,SR, SL, SU, SD, SEJ);

  output reg R_req, L_req, U_req, D_req, EJ_req;
  output reg  R1, L1, U1, D1, EJ1;
  input clk, reset;
  input R2, L2, U2, D2, EJ2;
  input en1, en2, en3, en4, en5;
  input [2:0] SR, SL, SU, SD, SEJ;
  
  always @(*)//combinational module
	if( reset)
		{R_req, L_req, U_req, D_req, EJ_req} = 'b0; // reset
	else
	begin
		{R_req, L_req, U_req, D_req, EJ_req} = 'b0; // reset	
		if(R2)
		  case (SR)
			3'b000: R_req = 1;
			3'b001: L_req = 1;
			3'b010: U_req = 1;
			3'b011: D_req = 1;
			3'b100: EJ_req = 1;      
			default:
			  {R_req, L_req, U_req, D_req, EJ_req} = 'b0;
		  endcase
		
		if(L2)
		  case (SL)
			3'b000: R_req = 1;
			3'b001: L_req = 1;
			3'b010: U_req = 1;
			3'b011: D_req = 1;
			3'b100: EJ_req = 1;      
			default:
			  {R_req, L_req, U_req, D_req, EJ_req} = 'b0;
		  endcase
		
		if(U2)
		  case (SU)
			3'b000: R_req = 1;
			3'b001: L_req = 1;
			3'b010: U_req = 1;
			3'b011: D_req = 1;
			3'b100: EJ_req = 1;      
			default:
			  {R_req, L_req, U_req, D_req, EJ_req} = 'b0;
		  endcase
		
		if(D2)
		  case (SD)
			3'b000: R_req = 1;
			3'b001: L_req = 1;
			3'b010: U_req = 1;
			3'b011: D_req = 1;
			3'b100: EJ_req = 1;      
			default:
			  {R_req, L_req, U_req, D_req, EJ_req} = 'b0;
		  endcase
		
		if(EJ2)
		  case (SEJ)
			3'b000: R_req = 1;
			3'b001: L_req = 1;
			3'b010: U_req = 1;
			3'b011: D_req = 1;
			3'b100: EJ_req = 1;      
			default:
			  {R_req, L_req, U_req, D_req, EJ_req} = 'b0;
		  endcase
	end
  
  
  always @(posedge clk)
	if( reset )
		{R1, L1, U1, D1, EJ1} = 'b0; // reset
	else
	begin
		{R1, L1, U1, D1, EJ1} = 'b0; // reset
		if(en1)
		  if(SR == 3'd0 && R2) 			R1 = 1;
		  else if(SL == 3'd0 && L2) 	L1 = 1;
		  else if(SU == 3'd0 && U2) 	U1 = 1;
		  else if(SD == 3'd0 && D2) 	D1 = 1;
		  else if(SEJ == 3'd0 && EJ2) 	EJ1 = 1;
		  
		if(en2)
		  if(SR == 3'd1 && R2) 			R1 = 1;
		  else if(SL == 3'd1 && L2) 	L1 = 1;
		  else if(SU == 3'd1 && U2) 	U1 = 1;
		  else if(SD == 3'd1 && D2) 	D1 = 1;
		  else if(SEJ == 3'd1 && EJ2) 	EJ1 = 1;
		  
		if(en3)
		  if(SR == 3'd2 && R2) 			R1 = 1;
		  else if(SL == 3'd2 && L2) 	L1 = 1;
		  else if(SU == 3'd2 && U2) 	U1 = 1;
		  else if(SD == 3'd2 && D2) 	D1 = 1;
		  else if(SEJ == 3'd2 && EJ2) 	EJ1 = 1;
		  
		if(en4)
		  if(SR == 3'd3 && R2) 			R1 = 1;
		  else if(SL == 3'd3 && L2) 	L1 = 1;
		  else if(SU == 3'd3 && U2) 	U1 = 1;
		  else if(SD == 3'd3 && D2) 	D1 = 1;
		  else if(SEJ == 3'd3 && EJ2) 	EJ1 = 1;
		  
		if(en5)
		  if(SR == 3'd4 && R2) 			R1 = 1;
		  else if(SL == 3'd4 && L2) 	L1 = 1;
		  else if(SU == 3'd4 && U2) 	U1 = 1;
		  else if(SD == 3'd4 && D2) 	D1 = 1;
		  else if(SEJ == 3'd4 && EJ2) 	EJ1 = 1;
	end
  
endmodule
