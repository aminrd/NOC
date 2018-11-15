module NOC (clk, reset,injection,ejection,EJ_push,EJ_req,EJ_en,EJ_ans,EJ_2);

  parameter LL = 16;
  output [255:0] injection; // in this case : 16(#CPU) * 16 bit(Packet Size)
  output [255:0] ejection; // in this case : 16(#CPU) * 16 bit(Packet Size)
  wire [LL-1:0] INJ [LL-1:0];
  wire [LL-1:0] EJC [LL-1:0];
	  genvar i;
	  generate 
		for(i=0;i<LL;i=i+1) begin : L1
			assign injection [LL*(i+1)-1:LL*i]=INJ[i];
			assign ejection[LL*(i+1)-1:LL*i] = EJC[i];
		end	
	  endgenerate
  input clk, reset;
  input [LL-1:0] EJ_push,EJ_ans;
  output [LL-1:0] EJ_en,EJ_2,EJ_req;
  
  wire [LL-1:0] Right [0:LL-1];
  wire [LL-1:0] Left  [0:LL-1];
  wire [LL-1:0] Up 	  [0:LL-1];
  wire [LL-1:0] Down  [0:LL-1];
  
  wire enR [0:LL-1];
  wire enL [0:LL-1];
  wire enU [0:LL-1];
  wire enD [0:LL-1];
  
  wire reqR [0:LL-1];
  wire reqL [0:LL-1];
  wire reqU [0:LL-1];
  wire reqD [0:LL-1];
  
  wire ansR [0:LL-1];
  wire ansL [0:LL-1];
  wire ansU [0:LL-1];
  wire ansD [0:LL-1];
  
  /*------ CPU:#00 -------*/
  wire [3:0] tmp0 [0:5];
  CPU c0000(2'b00, 2'b00,Right[3],Left[1],Up[12],Down[4],clk,reset,tmp0[0],tmp0[1], Right[0],Left[0],Up[0] ,Down[0] , tmp0[2],tmp0[3], tmp0[4],tmp0[5], INJ[0], EJ_push[0], EJ_ans[0], EJ_req[0], EJ_en[0], EJ_2[0], EJC[0]);
	assign tmp0[0] = {reqR[3],reqL[1],reqU[12],reqD[4]};   		 //input
	assign tmp0[1] = {enR[3],enL[1],enU[12],enD[4]};			 //input
	assign tmp0[4] = {ansR[3],ansL[1],ansU[12],ansD[4]};		 //input
	assign tmp0[2] = {reqR[0],reqL[0],reqU[0],reqD[0]};			 //output
	assign tmp0[3] = {enR[0],enL[0],enU[0],enD[0]};				 //output
	assign tmp0[5] = {ansR[0],ansL[0],ansU[0],ansD[0]};			 //output

  /*------ CPU:#01 -------*/
  wire [3:0] tmp1 [0:5];
  CPU c0001(2'b01, 2'b00,Right[0],Left[2],Up[13],Down[5],clk,reset,tmp1[0],tmp1[1], Right[1],Left[1],Up[1] ,Down[1] , tmp1[2],tmp1[3], tmp1[4],tmp1[5], INJ[1], EJ_push[1], EJ_ans[1], EJ_req[1], EJ_en[1], EJ_2[1], EJC[1]);
	assign tmp1[0] = {reqR[0],reqL[2],reqU[13],reqD[5]};   		 //input
	assign tmp1[1] = {enR[0],enL[2],enU[13],enD[5]};			 //input
	assign tmp1[4] = {ansR[0],ansL[2],ansU[13],ansD[5]};		 //input	
	assign tmp1[2] = {reqR[1],reqL[1],reqU[1],reqD[1]};			 //output
	assign tmp1[3] = {enR[1],enL[1],enU[1],enD[1]};				 //output
	assign tmp1[5] = {ansR[1],ansL[1],ansU[1],ansD[1]};			 //output

  /*------ CPU:#02 -------*/
  wire [3:0] tmp2 [0:5];
  CPU c0010(2'b10, 2'b00,Right[1],Left[3],Up[14],Down[6],clk,reset,tmp2[0],tmp2[1], Right[2],Left[2],Up[2] ,Down[2] , tmp2[2],tmp2[3], tmp2[4],tmp2[5], INJ[2], EJ_push[2], EJ_ans[2], EJ_req[2], EJ_en[2], EJ_2[2], EJC[2]);
	assign tmp2[0] = {reqR[1],reqL[3],reqU[14],reqD[6]};   		 //input
	assign tmp2[1] = {enR[1],enL[3],enU[14],enD[6]};			 //input
	assign tmp2[4] = {ansR[1],ansL[3],ansU[14],ansD[6]};		 //input	
	assign tmp2[2] = {reqR[2],reqL[2],reqU[2],reqD[2]};			 //output
	assign tmp2[3] = {enR[2],enL[2],enU[2],enD[2]};				 //output
	assign tmp2[5] = {ansR[2],ansL[2],ansU[2],ansD[2]};			 //output

  /*------ CPU:#03 -------*/
  wire [3:0] tmp3 [0:5];
  CPU c0011(2'b11, 2'b00,Right[2],Left[0],Up[15],Down[7],clk,reset,tmp3[0],tmp3[1], Right[3],Left[3],Up[3] ,Down[3] , tmp3[2],tmp3[3], tmp3[4],tmp3[5], INJ[3], EJ_push[3], EJ_ans[3], EJ_req[3], EJ_en[3], EJ_2[3], EJC[3]);
	assign tmp3[0] = {reqR[2],reqL[0],reqU[15],reqD[7]};   		 //input
	assign tmp3[1] = {enR[2],enL[0],enU[15],enD[7]};			 //input
	assign tmp3[4] = {ansR[2],ansL[0],ansU[15],ansD[7]};		 //input	
	assign tmp3[2] = {reqR[3],reqL[3],reqU[3],reqD[3]};			 //output
	assign tmp3[3] = {enR[3],enL[3],enU[3],enD[3]};				 //output
	assign tmp3[5] = {ansR[3],ansL[3],ansU[3],ansD[3]};			 //output

  /*------ CPU:#04 -------*/
  wire [3:0] tmp4 [0:5];
  CPU c0100(2'b00, 2'b01,Right[7],Left[5],Up[0],Down[8],clk,reset,tmp4[0],tmp4[1], Right[4],Left[4],Up[4] ,Down[4] , tmp4[2],tmp4[3], tmp4[4],tmp4[5], INJ[4], EJ_push[4], EJ_ans[4], EJ_req[4], EJ_en[4], EJ_2[4], EJC[4]);
	assign tmp4[0] = {reqR[7],reqL[5],reqU[0],reqD[8]};   		 //input
	assign tmp4[1] = {enR[7],enL[5],enU[0],enD[8]};			 	 //input
	assign tmp4[4] = {ansR[7],ansL[5],ansU[0],ansD[8]};		 	 //input	
	assign tmp4[2] = {reqR[4],reqL[4],reqU[4],reqD[4]};			 //output
	assign tmp4[3] = {enR[4],enL[4],enU[4],enD[4]};				 //output
	assign tmp4[5] = {ansR[4],ansL[4],ansU[4],ansD[4]};			 //output
	
  /*------ CPU:#05 -------*/
  wire [3:0] tmp5 [0:5];
  CPU c0101(2'b01, 2'b01,Right[4],Left[6],Up[1],Down[9],clk,reset,tmp5[0],tmp5[1], Right[5],Left[5],Up[5] ,Down[5] , tmp5[2],tmp5[3], tmp5[4],tmp5[5], INJ[5], EJ_push[5], EJ_ans[5], EJ_req[5], EJ_en[5], EJ_2[5], EJC[5]);
	assign tmp5[0] = {reqR[4],reqL[6],reqU[1],reqD[9]};   		 //input
	assign tmp5[1] = {enR[4],enL[6],enU[1],enD[9]};			 	 //input
	assign tmp5[4] = {ansR[4],ansL[6],ansU[1],ansD[9]};		 	 //input	
	assign tmp5[2] = {reqR[5],reqL[5],reqU[5],reqD[5]};			 //output
	assign tmp5[3] = {enR[5],enL[5],enU[5],enD[5]};				 //output
	assign tmp5[5] = {ansR[5],ansL[5],ansU[5],ansD[5]};			 //output
	
  /*------ CPU:#06 -------*/
  wire [3:0] tmp6 [0:5];
  CPU c0110(2'b10, 2'b01,Right[5],Left[7],Up[2],Down[10],clk,reset,tmp6[0],tmp6[1], Right[6],Left[6],Up[6] ,Down[6] , tmp6[2],tmp6[3], tmp6[4],tmp6[5], INJ[6], EJ_push[6], EJ_ans[6], EJ_req[6], EJ_en[6], EJ_2[6], EJC[6]);
	assign tmp6[0] = {reqR[5],reqL[7],reqU[2],reqD[10]};   		 //input
	assign tmp6[1] = {enR[5],enL[7],enU[2],enD[10]};			 //input
	assign tmp6[4] = {ansR[5],ansL[7],ansU[2],ansD[10]};		 //input	
	assign tmp6[2] = {reqR[6],reqL[6],reqU[6],reqD[6]};			 //output
	assign tmp6[3] = {enR[6],enL[6],enU[6],enD[6]};				 //output
	assign tmp6[5] = {ansR[6],ansL[6],ansU[6],ansD[6]};			 //output

  /*------ CPU:#07 -------*/
  wire [3:0] tmp7 [0:5];
  CPU c0111(2'b11, 2'b01,Right[6],Left[4],Up[3],Down[11],clk,reset,tmp7[0],tmp7[1], Right[7],Left[7],Up[7] ,Down[7] , tmp7[2],tmp7[3], tmp7[4],tmp7[5], INJ[7], EJ_push[7], EJ_ans[7], EJ_req[7], EJ_en[7], EJ_2[7], EJC[7]);
	assign tmp7[0] = {reqR[6],reqL[4],reqU[3],reqD[11]};   		 //input
	assign tmp7[1] = {enR[6],enL[4],enU[3],enD[11]};			 //input
	assign tmp7[4] = {ansR[6],ansL[4],ansU[3],ansD[11]};		 //input	
	assign tmp7[2] = {reqR[7],reqL[7],reqU[7],reqD[7]};			 //output
	assign tmp7[3] = {enR[7],enL[7],enU[7],enD[7]};				 //output
	assign tmp7[5] = {ansR[7],ansL[7],ansU[7],ansD[7]};			 //output	
	
  /*------ CPU:#08 -------*/
  wire [3:0] tmp8 [0:5];
  CPU c1000(2'b00, 2'b10,Right[11],Left[9],Up[4],Down[12],clk,reset,tmp8[0],tmp8[1], Right[8],Left[8],Up[8] ,Down[8] , tmp8[2],tmp8[3], tmp8[4],tmp8[5], INJ[8], EJ_push[8], EJ_ans[8], EJ_req[8], EJ_en[8], EJ_2[8], EJC[8]);
	assign tmp8[0] = {reqR[11],reqL[9],reqU[4],reqD[12]};   	 //input
	assign tmp8[1] = {enR[11],enL[9],enU[4],enD[12]};			 //input
	assign tmp8[4] = {ansR[11],ansL[9],ansU[4],ansD[12]};		 //input	
	assign tmp8[2] = {reqR[8],reqL[8],reqU[8],reqD[8]};			 //output
	assign tmp8[3] = {enR[8],enL[8],enU[8],enD[8]};				 //output
	assign tmp8[5] = {ansR[8],ansL[8],ansU[8],ansD[8]};			 //output	

  /*------ CPU:#09 -------*/
  wire [3:0] tmp9 [0:5];
  CPU c1001(2'b01, 2'b10,Right[8],Left[10],Up[5],Down[13],clk,reset,tmp9[0],tmp9[1], Right[9],Left[9],Up[9] ,Down[9] , tmp9[2],tmp9[3], tmp9[4],tmp9[5], INJ[9], EJ_push[9], EJ_ans[9], EJ_req[9], EJ_en[9], EJ_2[9], EJC[9]);
	assign tmp9[0] = {reqR[8],reqL[10],reqU[5],reqD[13]};   	 //input
	assign tmp9[1] = {enR[8],enL[10],enU[5],enD[13]};			 //input
	assign tmp9[4] = {ansR[8],ansL[10],ansU[5],ansD[13]};		 //input	
	assign tmp9[2] = {reqR[9],reqL[9],reqU[9],reqD[9]};			 //output
	assign tmp9[3] = {enR[9],enL[9],enU[9],enD[9]};				 //output
	assign tmp9[5] = {ansR[9],ansL[9],ansU[9],ansD[9]};			 //output

  /*------ CPU:#10 -------*/
  wire [3:0] tmp10 [0:5];
  CPU c1010(2'b10, 2'b10,Right[9],Left[11],Up[6],Down[14],clk,reset,tmp10[0],tmp10[1], Right[10],Left[10],Up[10] ,Down[10] , tmp10[2],tmp10[3], tmp10[4],tmp10[5], INJ[10], EJ_push[10], EJ_ans[10], EJ_req[10], EJ_en[10], EJ_2[10], EJC[10]);
	assign tmp10[0] = {reqR[9],reqL[11],reqU[6],reqD[14]};   	 //input
	assign tmp10[1] = {enR[9],enL[11],enU[6],enD[14]};			 //input
	assign tmp10[4] = {ansR[9],ansL[11],ansU[6],ansD[14]};		 //input	
	assign tmp10[2] = {reqR[10],reqL[10],reqU[10],reqD[10]};	 //output
	assign tmp10[3] = {enR[10],enL[10],enU[10],enD[10]};		 //output
	assign tmp10[5] = {ansR[10],ansL[10],ansU[10],ansD[10]};	 //output

  /*------ CPU:#11 -------*/
  wire [3:0] tmp11 [0:5];
  CPU c1011(2'b11, 2'b10,Right[10],Left[8],Up[7],Down[15],clk,reset,tmp11[0],tmp11[1], Right[11],Left[11],Up[11] ,Down[11] , tmp11[2],tmp11[3], tmp11[4],tmp11[5], INJ[11], EJ_push[11], EJ_ans[11], EJ_req[11], EJ_en[11], EJ_2[11], EJC[11]);
	assign tmp11[0] = {reqR[10],reqL[8],reqU[7],reqD[15]};   	 //input
	assign tmp11[1] = {enR[10],enL[8],enU[7],enD[15]};			 //input
	assign tmp11[4] = {ansR[10],ansL[8],ansU[7],ansD[15]};		 //input	
	assign tmp11[2] = {reqR[11],reqL[11],reqU[11],reqD[11]};	 //output
	assign tmp11[3] = {enR[11],enL[11],enU[11],enD[11]};		 //output
	assign tmp11[5] = {ansR[11],ansL[11],ansU[11],ansD[11]};	 //output

  /*------ CPU:#12 -------*/
  wire [3:0] tmp12 [0:5];
  CPU c1100(2'b00, 2'b11,Right[15],Left[13],Up[8],Down[0],clk,reset,tmp12[0],tmp12[1], Right[12],Left[12],Up[12] ,Down[12] , tmp12[2],tmp12[3], tmp12[4],tmp12[5], INJ[12], EJ_push[12], EJ_ans[12], EJ_req[12], EJ_en[12], EJ_2[12], EJC[12]);
	assign tmp12[0] = {reqR[15],reqL[13],reqU[8],reqD[0]};   	 //input
	assign tmp12[1] = {enR[15],enL[13],enU[8],enD[0]};			 //input
	assign tmp12[4] = {ansR[15],ansL[13],ansU[8],ansD[0]};		 //input	
	assign tmp12[2] = {reqR[12],reqL[12],reqU[12],reqD[12]};	 //output
	assign tmp12[3] = {enR[12],enL[12],enU[12],enD[12]};		 //output
	assign tmp12[5] = {ansR[12],ansL[12],ansU[12],ansD[12]};	 //output

  /*------ CPU:#13 -------*/
  wire [3:0] tmp13 [0:5];
  CPU c1101(2'b01, 2'b11,Right[12],Left[14],Up[9],Down[1],clk,reset,tmp13[0],tmp13[1], Right[13],Left[13],Up[13] ,Down[13] , tmp13[2],tmp13[3], tmp13[4],tmp13[5], INJ[13], EJ_push[13], EJ_ans[13], EJ_req[13], EJ_en[13], EJ_2[13], EJC[13]);
	assign tmp13[0] = {reqR[12],reqL[14],reqU[9],reqD[1]};   	 //input
	assign tmp13[1] = {enR[12],enL[14],enU[9],enD[1]};			 //input
	assign tmp13[4] = {ansR[12],ansL[14],ansU[9],ansD[1]};		 //input	
	assign tmp13[2] = {reqR[13],reqL[13],reqU[13],reqD[13]};	 //output
	assign tmp13[3] = {enR[13],enL[13],enU[13],enD[13]};		 //output
	assign tmp13[5] = {ansR[13],ansL[13],ansU[13],ansD[13]};	 //output

  /*------ CPU:#14 -------*/
  wire [3:0] tmp14 [0:5];
  CPU c1110(2'b10, 2'b11,Right[13],Left[15],Up[10],Down[2],clk,reset,tmp14[0],tmp14[1], Right[14],Left[14],Up[14] ,Down[14] , tmp14[2],tmp14[3], tmp14[4],tmp14[5], INJ[14], EJ_push[14], EJ_ans[14], EJ_req[14], EJ_en[14], EJ_2[14], EJC[14]);
	assign tmp14[0] = {reqR[13],reqL[15],reqU[10],reqD[2]};   	 //input
	assign tmp14[1] = {enR[13],enL[15],enU[10],enD[2]};			 //input
	assign tmp14[4] = {ansR[13],ansL[15],ansU[10],ansD[2]};		 //input	
	assign tmp14[2] = {reqR[14],reqL[14],reqU[14],reqD[14]};	 //output
	assign tmp14[3] = {enR[14],enL[14],enU[14],enD[14]};		 //output
	assign tmp14[5] = {ansR[14],ansL[14],ansU[14],ansD[14]};	 //output

  /*------ CPU:#15 -------*/
  wire [3:0] tmp15 [0:5];
  CPU c1111(2'b11, 2'b11,Right[14],Left[12],Up[11],Down[3],clk,reset,tmp15[0],tmp15[1], Right[15],Left[15],Up[15] ,Down[15] , tmp15[2],tmp15[3], tmp15[4],tmp15[5], INJ[15], EJ_push[15], EJ_ans[15], EJ_req[15], EJ_en[15], EJ_2[15], EJC[15]);
	assign tmp15[0] = {reqR[14],reqL[12],reqU[11],reqD[3]};   	 //input
	assign tmp15[1] = {enR[14],enL[12],enU[11],enD[3]};			 //input
	assign tmp15[4] = {ansR[14],ansL[12],ansU[11],ansD[3]};		 //input	
	assign tmp15[2] = {reqR[15],reqL[15],reqU[15],reqD[15]};	 //output
	assign tmp15[3] = {enR[15],enL[15],enU[15],enD[15]};		 //output
	assign tmp15[5] = {ansR[15],ansL[15],ansU[15],ansD[15]};	 //output	
	

  
endmodule

