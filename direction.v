module direction (right, left, up, down, EJ, Ri, Le, Up, Do, Ej,R_push, L_push, U_push, D_push, EJ_push,reset);
				  
  output reg right, left, up, down, EJ;	
  input [2:0] Ri, Le, Up, Do, Ej;
  input R_push, L_push, U_push, D_push, EJ_push;
  input reset;
  
  always @(*)
	if (reset)
		{right, left, up, down, EJ} = 'b0; //reset
	else
	begin 
		{right, left, up, down, EJ} = 'b0; //reset
		if(R_push == 1)
		begin
		  if(~Ri)  right = 1;
		  if(~Le)  left = 1;
		  if(~Up)  up = 1;
		  if(~Do)  down = 1;
		  if(~Ej)  EJ = 1;
		end
		if(L_push == 1)
		begin
		  if(Ri == 3'b001)  right = 1;
		  if(Le == 3'b001)  left = 1;
		  if(Up == 3'b001)  up = 1;
		  if(Do == 3'b001)  down = 1;
		  if(Ej == 3'b001)  EJ = 1;
		end
		if(U_push == 1)
		begin
		  if(Ri == 3'b010)  right = 1;
		  if(Le == 3'b010)  left = 1;
		  if(Up == 3'b010)  up = 1;
		  if(Do == 3'b010)  down = 1;
		  if(Ej == 3'b010)  EJ = 1;
		end
		if(D_push == 1)
		begin
		  if(Ri == 3'b011)  right = 1;
		  if(Le == 3'b011)  left = 1;
		  if(Up == 3'b011)  up = 1;
		  if(Do == 3'b011)  down = 1;
		  if(Ej == 3'b011)  EJ = 1;
		end
		if(EJ_push == 1)
		begin
		  if(Ri == 3'b100)  right = 1;
		  if(Le == 3'b100)  left = 1;
		  if(Up == 3'b100)  up = 1;
		  if(Do == 3'b100)  down = 1;
		  if(Ej == 3'b100)  EJ = 1;
		end
	end  
endmodule
