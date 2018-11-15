module Automatic_packet_generator (turnoff,clk, reset,en_EJ,X, Y, flit,write,hand2);
  parameter LL = 16; // Flit size	
  parameter Rate = 5; //Injection Rate
  parameter idol = 20; // idol = 100/Rate , in default case : idol = 20;
  input turnoff,clk,reset,hand2;
  input [1:0] X, Y;
  output reg [LL-1:0] flit;
  output reg write; // write request signal
  output en_EJ;
  
  reg [LL-1:0] temp;
  wire [1:0] y_final, x_final;
  reg [2:0] State;
  reg [2:0] Next_State;
  reg [3:0] salam;
  wire[7:0] tmp = {Y, X, y_final, x_final};
  assign x_final = 0~^X; //Bit-complement destination algorithm
  assign y_final = 0~^Y; //Bit-complement destination algorithm 
  
  integer f_i_l_e,cnt;
  initial begin
	State = 'b0;
	f_i_l_e=$fopen("in/packet.txt");
	salam = $random();
	cnt = salam;
  end
  
  always @(posedge clk)
	if(cnt == idol) cnt = 0;
	else			cnt = cnt+1;

  
  always @(posedge clk)
    if(reset & turnoff) 	State <= 3'b0;
    else if(~turnoff) 		State <= Next_State;
  
  always @(*)
    case (State)
      3'b000:
          Next_State = 3'b001;
      3'b001:
        if(cnt == 0) 			Next_State = 3'b010;
        else 					Next_State = 3'b001;
      3'b010:					Next_State = 3'b011;
      3'b011: 					Next_State = 3'b100;
      3'b100: 					Next_State = 3'b101;
      3'b101: 					Next_State = 3'b110;	
      3'b110: 					Next_State = 3'b111;
      3'b111: 					Next_State = 3'b001;
    endcase
  
  always @(*)
    case (State)
      3'b000: 	write = 0;
      3'b001: 	write = 0;
      3'b010: 	write = 0;
      3'b011: 
	  /*Generating 4 flits in a Packet*/
      begin
        write = 1;
        temp = $random();
        temp[LL-1:LL-2] = 2'b00; // Head-Flit
        temp[9:2] = {Y, X, y_final, x_final};
        flit = temp;
		$fdisplay(f_i_l_e,"%t :Packet %b generated by CPU -> %d", $time,flit,{Y,X} );
      end
      3'b100:
      begin
        write = 1;
        temp = $random();
		temp[9:2] = tmp;
        temp[LL-1:LL-2] = 2'b01; // Body-Flit(1)
        flit = temp;
      end
      3'b101:
      begin
        write = 1;
        temp = $random();
		temp[9:2] = tmp;
        temp[LL-1:LL-2] = 2'b01; // Body-Flit(2)
        flit = temp;
      end
      3'b110:
      begin
        write = 1;
        temp = $random();
		temp[9:2] = tmp;
        temp[LL-1:LL-2] = 2'b10; // Tail-Flit
        flit = temp;
      end
      3'b111: 	write = 0;
    endcase
  
 endmodule
  