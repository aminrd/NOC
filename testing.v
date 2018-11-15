module testing;
	wire en_EJ,write;
	reg [15:0] flit;
	reg turnoff,clk, reset,recieved;
	reg [1:0] X,Y;
	initial begin
		clk = 0;
		turnoff = 0;
		reset = 0;
		recieved = 0;
		X = 2'b10;
		Y = 2'b00;
		#10
		recieved = 1;
		flit = 16'b0011000101101011;
		#50
		flit = 16'b1011000101101011;
		#50
		flit = 16'b0011000100000000;
	end
	
	Packet_reciever ss(clk, reset, turnoff, recieved, flit, hand_shake,X, Y);
	
	always 
		#5 clk = ~clk;
	
endmodule
