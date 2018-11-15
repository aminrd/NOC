module Packet_reciever (clk, reset, turnoff, recieved, flit, hand_shake,X, Y);
  // just print the Head-Flit to modify a packet
  parameter LL = 16; // Flit-size
  
  input clk, reset, turnoff, recieved;
  input [LL-1:0] flit;
  output hand_shake;
  input [1:0] X, Y;
  

  integer f_i_l_e_2;  
  assign #2 hand_shake =  recieved;
  initial 
  f_i_l_e_2=$fopen("out/recieve.txt"); 
  
  always @(posedge clk)
  begin
    if(turnoff); 			//$fclose(f_i_l_e_2);
    else if(~reset)
      if(recieved == 1 && flit[LL-1:LL-2] == 2'b00) begin 
	    // just print the Head-Flit to modify a packet
		
		$fdisplay(f_i_l_e_2,"%t :Packet %b recieved by CPU -> %d\n", $time,flit,{Y,X} );
		//$fclose(f_i_l_e_2);
	  end

  end

endmodule
  
