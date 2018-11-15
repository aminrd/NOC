module XY_logic (verification, status,X, Y, x_final, y_final, vt_channel,reset);
  parameter MM = 2; // MM = (log2_LL)/2
  output reg [4:0] verification, status;
  input [MM-1:0] X, Y,x_final, y_final; // x,y = adresses
  input [2:0] vt_channel;
  input reset;
  /*
	0: Right
	1: Left
	2: Up
	3: Down
	4: Eject
  */	
  always @(*) // combinational Router logic
	if (reset)
		{verification, status} = 'b0;
	else begin
		{verification, status} = 'b0;//reset
		if(X < x_final) 		   verification[0] = 1;//Right
		else if(X > x_final)       verification[1] = 1;//Left
		else if(X == x_final)
		begin
		  if(Y < y_final)  	   	   verification[2] = 1;//Up
		  else if(Y > y_final)     verification[3] = 1;//Down
		  else 					   verification[4] = 1;//Eject
		end
	end
endmodule