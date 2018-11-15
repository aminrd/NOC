module WF_logic (verification, status,X, Y, x_final, y_final, vt_channel,reset);
  //MinimalWest-First Algorithm for 2-D Meshes
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
  always @(*) // combinational Routing logic
	if (reset)
		{verification, status,dir} = 'b0;
	else begin
		{verification, status} = 'b0;//reset
		if(X == x_final && Y == y_final)     verification[4] = 1;//Eject 
		else if(~dir)
				if(x_final < X)				 verification[1] = 1;
				else if(x_final > X)
				     if(y_final < Y)begin	 verification[0] = 1; //Channel := Select(X+, Y−);
											 dir[3] = 1;
					 end
					 else if(y_final > Y)begin	 verification[0] = 1; //Channel := Select(X+, Y+);	
												 dir[2] = 1;							 
					 end				
					 else 					 	 verification[0] = 1;
				else
					 if(y_final < Y)			 verification[3] = 1;	
					 else if(y_final > Y)		 verification[2] = 1;
			else begin
				verification = dir;
				dir = 'b0;
			end
			
	end
endmodule
