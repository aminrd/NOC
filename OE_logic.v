module OE_logic (verification, status,X, Y, x_final, y_final, vt_channel,reset);
  parameter MM = 2; // MM = (log2_LL)/2
  output reg [4:0] verification, status;
  input [MM-1:0] X, Y,x_final, y_final; // x,y = adresses
  input [2:0] vt_channel;
  input reset;
  reg [3:0] dir;
  /*
	0: Right
	1: Left
	2: Up
	3: Down
	4: Eject
  */		
  always @(*) // combinational Router logic
	if (reset)
		{verification, status,dir} = 'b0;
	else begin
		{verification, status} = 'b0;//reset
		if(X == x_final && Y == y_final)     verification[4] = 1;//Eject
		else if(X == x_final)  // current node in same col as dest
				if(Y < y_final)
					if(dir[0] && X%2==0)			verification[0] = 1; 
					else 							verification[2] = 1; // allow to rout Up
				else	
					if(dir[0] && X%2==0)			verification[0] = 1; 
					else 							verification[3] = 1; // allow to rout Down
		else if(Y == y_final) // cur in same row as dest	
				if(X < x_final) 					verification[0] = 1; // allow to rout Right
				else	
					if((dir[2]||dir[3])&& X%2==1)	verification[0] = 1;
					else 							verification[1] = 1; // allow to rout Left
		else if(X < x_final)						verification[0] = 1; // allow to rout Right
		else //	if(X > x_final)				
				if(Y < y_final)					
					if(X%2) 						verification[2] = 1; // allow to rout Up
					else							verification[1] = 1; // allow to rout Left
				else	
					if(X%2) 						verification[3] = 1; // allow to rout Down
					else							verification[1] = 1; // allow to rout Left				
		dir = verification;	// saving previous move
	end
endmodule
