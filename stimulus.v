module stimulus;
  parameter LL = 16;
  reg clk, reset, finish,way=1'b0;
  wire [255:0] injection,ejection;
  wire [LL-1:0] INJ [LL-1:0];
  wire [LL-1:0] EJC [LL-1:0];  
  wire [LL-1:0] EJ_push,EJ_req,EJ_en,EJ_ans,EJ_2;
  
  NOC sample_network (clk, reset, injection,ejection,EJ_push, EJ_req, EJ_en, EJ_ans, EJ_2);

  /*genvar i;
  generate 
	for(i=0;i<LL;i=i+1) begin : L1
	    assign INJ[i] = injection[LL*(i+1)-1:LL*i];
		assign ejection[LL*(i+1)-1:LL*i] = EJC[i];
	end	
  endgenerate  */
					assign INJ[0] = injection[15:0];
					assign ejection[15:0] = EJC[0];
					assign INJ[1] = injection[31:16];
					assign ejection[31:16] = EJC[1];
					assign INJ[2] = injection[47:32];
					assign ejection[47:32] = EJC[2];
					assign INJ[3] = injection[63:48];
					assign ejection[63:48] = EJC[3];
					assign INJ[4] = injection[79:64];
					assign ejection[79:64] = EJC[4];
					assign INJ[5] = injection[95:80];
					assign ejection[95:80] = EJC[5];
					assign INJ[6] = injection[111:96];
					assign ejection[111:96] = EJC[6];
					assign INJ[7] = injection[127:112];
					assign ejection[127:112] = EJC[7];
					assign INJ[8] = injection[143:128];
					assign ejection[143:128] = EJC[8];
					assign INJ[9] = injection[159:144];
					assign ejection[159:144] = EJC[9];
					assign INJ[10] = injection[175:160];
					assign ejection[175:160] = EJC[10];
					assign INJ[11] = injection[191:176];
					assign ejection[191:176] = EJC[11];
					assign INJ[12] = injection[207:192];
					assign ejection[207:192] = EJC[12];
					assign INJ[13] = injection[223:208];
					assign ejection[223:208] = EJC[13];
					assign INJ[14] = injection[239:224];
					assign ejection[239:224] = EJC[14];	  
					assign INJ[15] = injection[255:240];
					assign ejection[255:240] = EJC[15];	  
  initial
  begin
    reset = 1;
	clk = 0;
    finish = 0;
    #20
    reset = 0;
    #500000
    $stop();
  end
  
  
  
  always
	#5 clk = ~clk;

	genvar i;
	generate 
		for(i=0;i<16;i=i+1) begin:L1
			transfer T(clk,way,INJ[i],1);
		end
	endgenerate
	
endmodule




































module transfer(clk,way,data,en);//0 = XY 1 = OE
	input clk,way,en;
	input [15:0] data;
	
	reg [2:0] rnd = 'b0;
	parameter xy = 0;
	parameter oe = 4;
	parameter period = 10;	
	integer distanse;
	reg [15:0] buffer=16'b1100_0000_0000_0000;
	
	always @(data) 
		if(~en) $display("Network on Chip Project - - Doctor Goudarzi");
		else if(data[15:14] == 2'b00) begin
		rnd[1:0] = $random();
		distanse = 0;
		if(data[7:6]<data[3:2])
			distanse = distanse + (data[3:2]-data[7:6]);
		else
			distanse = distanse + (data[7:6]-data[3:2]);
		if(data[9:8]<data[5:4])
			distanse = distanse + (data[5:4]-data[9:8]);	
		else
			distanse = distanse + (data[9:8]-data[5:4]);	
		if(way)
			distanse = distanse + oe;
		else
			distanse = distanse + xy;
		distanse = distanse +rnd;	
		distanse = distanse * period;
		buffer <= #(distanse) data;
	end
	integer myfile;
  initial 
	myfile=$fopen("out/recieve.txt"); 	
	always @(buffer)
		if(buffer[15:14] == 2'b00)
			$fdisplay(myfile,"%t :Packet %b recieved by CPU -> %d", $time,buffer,buffer[5:2] );
		
endmodule


















