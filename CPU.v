module CPU (X, Y,inR, inL, inU, inD, clk, reset, push,
                     state, outR, outL, outU, outD,REQ,en,
                      ans,push_t,inject,IJ1, IJ2, EJ1, EJ2, EJ3,eject);
	parameter LL = 16;
	parameter MM = 2 ; // MM = (log2_LL)/2
	input [MM-1:0] X, Y;
	input [LL-1:0] inR, inL, inU, inD;
	input clk, reset;
	input [3:0] push,state,ans;
	output [LL-1:0] outR,outL,outU,outD,eject,inject;
	output [3:0] REQ,en,push_t;
	input IJ1, IJ2;
	output EJ1, EJ2, EJ3;
	wire [LL-1:0] inject, eject;
	wire inj, EJ1, EJ2;
	wire IJ2, EJ3;
  
  Router R(X, Y, inR, inL, inU, inD, inject, clk, reset, push[0], push[1], push[2], push[3], inj, state[0], state[1], state[2], state[3], 1'b1, 
           outR, outL, outU, outD, eject, REQ[0], REQ[1], REQ[2], REQ[3], EJ1, en[0], en[1], en[2], en[3], EJ2,
           ans[0], ans[1], ans[2], ans[3], IJ2, push_t[0], push_t[1], push_t[2], push_t[3], EJ3);  
          
  reg turnoff = 'b0;
  initial 
	turnoff <= #2400 1'b1;
	
  Automatic_packet_generator producer(turnoff,clk, reset, EJ2, X, Y, inject, inj, EJ3);
  
  Packet_reciever consumer(clk, reset, 0, EJ1, eject, IJ2, X, Y);
  
  
endmodule

