module gn_select (ans_R, ans_L, ans_U, ans_D, ans_EJ,R1, L1, U1, D1, EJ1, clk, reset,req_R, req_L, req_U, req_D, req_EJ);
  
  input clk, reset;
  output reg [2:0] ans_R, ans_L, ans_U, ans_D, ans_EJ;
  input R1, L1, U1, D1, EJ1;
  input [2:0] req_R, req_L, req_U, req_D, req_EJ;
  
  always @(posedge clk)
    if(reset) 
	    {ans_R, ans_L, ans_U, ans_D, ans_EJ} = 16'h7777;
    else begin
		{ans_R, ans_L, ans_U, ans_D, ans_EJ} = 16'h7777;
		
      if(R1)
        case (req_R)
          3'b000: ans_R = 3'b000;
          3'b001: ans_L = 3'b000;
          3'b010: ans_U = 3'b000;
          3'b011: ans_D = 3'b000;
          3'b100: ans_EJ = 3'b000;
        endcase

      if(L1)
        case (req_L)
          3'b000: ans_R = 3'b001;
          3'b001: ans_L = 3'b001;
          3'b010: ans_U = 3'b001;
          3'b011: ans_D = 3'b001;
          3'b100: ans_EJ = 3'b001;
        endcase

      if(U1)
        case (req_U)
          3'b000: ans_R = 3'b010;
          3'b001: ans_L = 3'b010;
          3'b010: ans_U = 3'b010;
          3'b011: ans_D = 3'b010;
          3'b100: ans_EJ = 3'b010;
        endcase
		
      if(D1)
        case (req_D)
          3'b000: ans_R = 3'b011;
          3'b001: ans_L = 3'b011;
          3'b010: ans_U = 3'b011;
          3'b011: ans_D = 3'b011;
          3'b100: ans_EJ = 3'b011;
        endcase

      if(EJ1)
        case (req_EJ)
          3'b000: ans_R = 3'b100;
          3'b001: ans_L = 3'b100;
          3'b010: ans_U = 3'b100;
          3'b011: ans_D = 3'b100;
          3'b100: ans_EJ = 3'b100;
        endcase

    end

  
endmodule

