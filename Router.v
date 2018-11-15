module Router (X, Y,R1, L1, U1, D1, EJ1,clk, reset, en_R, en_L, en_U, en_D, en_EJ,SR, SL, SU, SD, SEJ,
               R2, L2, U2, D2, EJ2,R_req, L_req, U_req, D_req, EJ_req,R3, L3, U3, D3, EJ3,
               R_ans, L_ans, U_ans, D_ans, EJ_ans,R4, L4, U4, D4, EJ4);
  parameter LL = 16;
  parameter MM = 2; // MM = (log2_LL)/2
  input [MM-1:0] X, Y;
  input [LL-1:0] R1, L1, U1, D1, EJ1;
  input clk, reset;
  input en_R, en_L, en_U, en_D, en_EJ;
  input SR, SL, SU, SD, SEJ;
  output [LL-1:0] R2, L2, U2, D2, EJ2;
  output R_req, L_req, U_req, D_req, EJ_req;
  output reg R3, L3, U3, D3, EJ3;
  input R_ans, L_ans, U_ans, D_ans, EJ_ans;
  output R4, L4, U4, D4, EJ4;
  
  wire [LL-1:0] TMP [4:0]; // U1. temperory wires
  wire [LL-1:0] temp[4:0]; // out. temperory wires
  
  wire [7:0] Rtmp,Rtemp;
  wire [7:0] Ltmp,Ltemp;
  wire [7:0] Utmp,Utemp;
  wire [7:0] Dtmp,Dtemp;
  wire [7:0] EJtmp,EJtemp;
  
  wire [2:0] RTT [3:0];
  wire [2:0] LTT [3:0];
  wire [2:0] UTT [3:0];
  wire [2:0] DTT [3:0];
  wire [2:0] EJTT [3:0];
  
  reg R5, L5, U5, D5, EJ5;
  
  always @(*)
	if (reset)
		{R3, L3, U3, D3, EJ3} = 'b0; // reset
	else
	begin
		{R3, L3, U3, D3, EJ3} = 'b0; // reset
		if(RTT[0] != 3'd0) 			R3 = 1;
		if(LTT[0] != 3'd0) 			L3 = 1;
		if(UTT[0] != 3'd0) 			U3 = 1;
		if(DTT[0] != 3'd0) 			D3 = 1;
		if(EJTT[0] == 3'd4) 		EJ3 = 1;
	end
  
  always @(*)
	if (reset)
		{R5, L5, U5, D5, EJ5} = 'b0; // reset
	else
	begin
		{R5, L5, U5, D5, EJ5} = 'b0; // reset	
		if(RTT[3] != 3'd0) 			R5 = 1;
		if(LTT[3] != 3'd0) 			L5 = 1;
		if(UTT[3] != 3'd0) 			U5 = 1;
		if(DTT[3] != 3'd0) 			D5 = 1;
		if(EJTT[3] != 3'd0) 			EJ5 = 1;
	end
       
  
//--------------------------------------------------------------------------------------------------------------------//
/*data_in modules for Routers + (input buffers)*/ 
  data_in bf_in1 (TMP[0], Rtmp[1], RTT[0], RTT[1], Rtmp[4], Rtmp[2], Rtmp[3], Rtemp[6],clk, reset, en_R, Rtmp[5], Rtmp[6], Rtmp[7], R1, X, Y, 3'b000, R4);
  data_in bf_in2 (TMP[1], Ltmp[1], LTT[0], LTT[1], Ltmp[4], Ltmp[2], Ltmp[3], Ltemp[6],clk, reset, en_L, Ltmp[5], Ltmp[6], Ltmp[7], L1, X, Y, 3'b001, L4);
  data_in bf_in3 (TMP[2], Utmp[1], UTT[0], UTT[1], Utmp[4], Utmp[2], Utmp[3], Utemp[6],clk, reset, en_U, Utmp[5], Utmp[6], Utmp[7], U1, X, Y, 3'b010, U4);
  data_in bf_in4 (TMP[3], Dtmp[1], DTT[0], DTT[1], Dtmp[4], Dtmp[2], Dtmp[3], Dtemp[6],clk, reset, en_D, Dtmp[5], Dtmp[6], Dtmp[7], D1, X, Y, 3'b011, D4);               
  data_in bf_in5 (TMP[4], EJtmp[1], EJTT[0], EJTT[1], EJtmp[4], EJtmp[2], EJtmp[3], EJtemp[6],clk, reset, en_EJ, EJtmp[5], EJtmp[6], EJtmp[7], EJ1, X, Y, 3'b100, EJ4);
					  
//--------------------------------------------------------------------------------------------------------------------//
/*data_out modules for Routers + (output buffers)*/

  data_out bf_out1	(R2, R_req, Rtemp[2],  RTT[3], clk, reset, Rtemp[1], SR, Rtemp[0], temp[0], R_ans);
  data_out bf_out2	(L2, L_req, Ltemp[2],  LTT[3], clk, reset, Ltemp[1], SL, Ltemp[0], temp[1], L_ans);
  data_out bf_out3	(U2, U_req, Utemp[2],  UTT[3], clk, reset, Utemp[1], SU, Utemp[0], temp[2], U_ans);
  data_out bf_out4	(D2, D_req, Dtemp[2],  DTT[3], clk, reset, Dtemp[1], SD, Dtemp[0], temp[3], D_ans);
  data_out bf_out5	(EJ2, EJ_req, EJtemp[2],  EJTT[3], clk, reset, EJtemp[1], SEJ, EJtemp[0], temp[4], EJ_ans);
  
//--------------------------------------------------------------------------------------------------------------------//
/*generating enable and selecting signals for directions*/  
direction direction_1(Rtemp[1], Ltemp[1], Utemp[1], Dtemp[1], EJtemp[1], RTT[2], LTT[2], UTT[2], DTT[2], EJTT[2], Rtemp[6], Ltemp[6], Utemp[6], Dtemp[6], EJtemp[6], reset);  
gn_select sample_sl_1(RTT[2], LTT[2], UTT[2], DTT[2], EJTT[2],Rtmp[6], Ltmp[6], Utmp[6], Dtmp[6], EJtmp[6], clk, reset, RTT[1], LTT[1], UTT[1], DTT[1], EJTT[1]);
 
//--------------------------------------------------------------------------------------------------------------------//
/*managin requests : IO_request module*/  
IO_request sac(Rtemp[0], Ltemp[0], Utemp[0], Dtemp[0], EJtemp[0], Rtmp[6], Ltmp[6], Utmp[6], Dtmp[6], EJtmp[6], reset,RTT[1], LTT[1], UTT[1], DTT[1], EJTT[1]);
    
//--------------------------------------------------------------------------------------------------------------------//
/*CrossBar*/              
CrossBar CB(temp[0], temp[1], temp[2], temp[3], temp[4], RTT[2], LTT[2], UTT[2], DTT[2], EJTT[2], TMP[0], TMP[1], TMP[2], TMP[3], TMP[4]);
  
//--------------------------------------------------------------------------------------------------------------------//
/*Port management : port_management module*/   
port_management vca(Rtmp[6], Ltmp[6], Utmp[6], Dtmp[6], EJtmp[6], clk, reset,RTT[1], LTT[1], UTT[1], DTT[1], EJTT[1], 
               Rtemp[3], Ltemp[3], Utemp[3], Dtemp[3], EJtemp[3], Rtmp[1], Ltmp[1], Utmp[1], Dtmp[1], EJtmp[1],Rtmp[3], Ltmp[3], Utmp[3], Dtmp[3], EJtmp[3]);
    
//--------------------------------------------------------------------------------------------------------------------//
/*hand shaking signals*/  
out_validity ovs(Rtemp[3], Ltemp[3], Utemp[3], Dtemp[3], EJtemp[3], clk,RTT[3], LTT[3], UTT[3], DTT[3], EJTT[3], reset, Rtemp[2], Ltemp[2], Utemp[2], Dtemp[2], EJtemp[2]);
 
//--------------------------------------------------------------------------------------------------------------------//
/*status signal and control*/  
status_signal switch_travers(Rtemp[4], Ltemp[4], Utemp[4], Dtemp[4], EJtemp[4], Rtemp[5], Ltemp[5], Utemp[5], Dtemp[5], EJtemp[5], R5, L5, U5, D5, EJ5); 
status_controller st_controler(Rtemp[5], Ltemp[5], Utemp[5], Dtemp[5], EJtemp[5], Rtmp[7], Ltmp[7], Utmp[7], Dtmp[7], EJtmp[7], clk, reset, Rtmp[6], Ltmp[6], 
			   Utmp[6], Dtmp[6], EJtmp[6], Rtemp[4], Ltemp[4], Utemp[4], Dtemp[4], EJtemp[4],RTT[1], LTT[1], UTT[1], DTT[1], EJTT[1]);
endmodule
