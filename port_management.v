module port_management (VR, VL, VU, VD, VEJ,clk, reset,R_req, L_req, U_req, D_req, EJ_req,
				 R1_sg, L1_sg, U1_sg, D1_sg, EJ1_sg,R2_sg, L2_sg, U2_sg, D2_sg, EJ2_sg,FVR, FVL, FVU, FVD, FVEJ);
  
  output reg VR, VL, VU, VD, VEJ;  
  input FVR, FVL, FVU, FVD, FVEJ;
  input clk, reset;
  input [2:0] R_req, L_req, U_req, D_req, EJ_req;
  // signals to check if ports assigned or not : #for outputs 
  input R1_sg, L1_sg, U1_sg, D1_sg, EJ1_sg;
  // signals to check if ports assigned or not : #for inputs
  input R2_sg, L2_sg, U2_sg, D2_sg, EJ2_sg;
  
  wire [2:0] CR, CL, CU, CD, CEJ;
  reg en1, en2, en3, en4, en5;
  
  always @(posedge clk)
  begin
    if(reset)
      {VR, VL, VU, VD, VEJ,en1, en2, en3, en4, en5} = 10'b0000011111;
    else
    begin
    if(FVR & VR) begin  
        case (R_req) /*if a port has been assigned , the enable signal for counter should be zero*/
          3'b000: en1 = 1;
          3'b001: en2 = 1;
          3'b010: en3 = 1;
          3'b011: en4 = 1;
          3'b100: en5 = 1;
        endcase
        VR = 0;
      end
    if(FVL & VL) begin  
        case (L_req) /*if a port has been assigned , the enable signal for counter should be zero*/
          3'b000: en1 = 1;
          3'b001: en2 = 1;
          3'b010: en3 = 1;
          3'b011: en4 = 1;
          3'b100: en5 = 1;  
        endcase
        VL = 0;
      end
    if(FVU & VU) begin  
        case (U_req) /*if a port has been assigned , the enable signal for counter should be zero*/
          3'b000: en1 = 1;
          3'b001: en2 = 1;
          3'b010: en3 = 1;
          3'b011: en4 = 1;
          3'b100: en5 = 1;  
        endcase
        VU = 0;
      end
    if(FVD & VD) begin  
        case (D_req) /*if a port has been assigned , the enable signal for counter should be zero*/
          3'b000: en1 = 1;
          3'b001: en2 = 1;
          3'b010: en3 = 1;
          3'b011: en4 = 1;
          3'b100: en5 = 1;  
        endcase
        VD = 0;
      end
    if(FVEJ & VEJ) begin  
        case (EJ_req) /*if a port has been assigned , the enable signal for counter should be zero*/
          3'b000: en1 = 1;
          3'b001: en2 = 1;
          3'b010: en3 = 1;
          3'b011: en4 = 1;
          3'b100: en5 = 1;  
        endcase
        VEJ = 0;
      end
    //---------------------------------------------------------------------------------------------//
	
    if(R1_sg)/*does it allocated or not*/
      case (CR)
        3'b000:
        begin
          if(~R_req && R2_sg)  		{VR,en1} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en1} = 2'b10;
          else if(~U_req && U2_sg) 	{VU,en1} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en1} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en1} = 2'b10;
        end
        3'b001:
        begin
          if(~L_req && L2_sg)		{VL,en1} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en1} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en1} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en1} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en1} = 2'b10;
        end
        3'b010:
        begin
          if(~U_req && U2_sg)		{VU,en1} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en1} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en1} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en1} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en1} = 2'b10;
        end
        3'b011:
        begin
          if(~D_req && D2_sg)		{VD,en1} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en1} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en1} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en1} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en1} = 2'b10;
        end
        3'b100:
        begin
          if(~EJ_req && EJ2_sg)		{VEJ,en1} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en1} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en1} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en1} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en1} = 2'b10;
        end
        default:
          {VR, VL, VU, VD, VEJ} = 'b0;
      endcase
    //---------------------------------------------------------------------------------------------//
    if(L1_sg)/*does it allocated or not*/
      case (CL)
        3'b000:
        begin
          if(~R_req && R2_sg)  		{VR,en2} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en2} = 2'b10;
          else if(~U_req && U2_sg) 	{VU,en2} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en2} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en2} = 2'b10;
        end
        3'b001:
        begin
          if(~L_req && L2_sg)		{VL,en2} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en2} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en2} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en2} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en2} = 2'b10;
        end
        3'b010:
        begin
          if(~U_req  && U2_sg)		{VU,en2} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en2} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en2} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en2} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en2} = 2'b10;
        end
        3'b011:
        begin
          if(~D_req && D2_sg)		{VD,en2} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en2} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en2} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en2} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en2} = 2'b10;
        end
        3'b100:
        begin
          if(~EJ_req && EJ2_sg)		{VEJ,en2} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en2} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en2} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en2} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en2} = 2'b10;
        end
        default:
          {VR, VL, VU, VD, VEJ} = 'b0;
      endcase
    
	//---------------------------------------------------------------------------------------------//
    if(U1_sg)/*does it allocated or not*/
      case (CU)
        3'b000:
        begin
          if(~R_req && R2_sg)  		{VR,en3} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en3} = 2'b10;
          else if(~U_req && U2_sg) 	{VU,en3} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en3} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en3} = 2'b10;
        end
        3'b001:
        begin
          if(~L_req && L2_sg)		{VL,en3} = 2'b10;
          else if(~U_req  && U2_sg)	{VU,en3} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en3} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en3} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en3} = 2'b10;
        end
        3'b010:
        begin
          if(~U_req && U2_sg)		{VU,en3} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en3} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en3} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en3} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en3} = 2'b10;
        end
        3'b011:
        begin
          if(~D_req && D2_sg)		{VD,en3} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en3} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en3} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en3} = 2'b10;
          else if(~U_req && U2_sg)  {VU,en3} = 2'b10;
        end
        3'b100:
        begin
          if(~EJ_req && EJ2_sg)		{VEJ,en3} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en3} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en3} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en3} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en3} = 2'b10;
        end
        default:
          {VR, VL, VU, VD, VEJ} = 'b0;
      endcase
    //---------------------------------------------------------------------------------------------//
    if(D1_sg) /*does it allocated or not*/
      case (CD)
        3'b000:
        begin
          if(~R_req && R2_sg)  		{VR,en4} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en4} = 2'b10;
          else if(~U_req && U2_sg) 	{VU,en4} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en4} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en4} = 2'b10;
        end
        3'b001:
        begin
          if(~L_req && L2_sg)		{VL,en4} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en4} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en4} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en4} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en4} = 2'b10;
        end
        3'b010:
        begin
          if(~U_req && U2_sg)		{VU,en4} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en4} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en4} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en4} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en4} = 2'b10;
        end
        3'b011:
        begin
          if(~D_req && D2_sg)		{VD,en4} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en4} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en4} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en4} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en4} = 2'b10;
        end
        3'b100:
        begin
          if(~EJ_req && EJ2_sg)		{VEJ,en4} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en4} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en4} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en4} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en4} = 2'b10;
        end
        default:
          {VR, VL, VU, VD, VEJ} = 'b0;
      endcase
    
	//---------------------------------------------------------------------------------------------//
    if(EJ1_sg) /*does it allocated or not*/
      case (CEJ)
        3'b000:
        begin
          if(~R_req && R2_sg)  		{VR,en5} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en5} = 2'b10;
          else if(~U_req && U2_sg) 	{VU,en5} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en5} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en5} = 2'b10;
        end
        3'b001:
        begin
          if(~L_req && L2_sg)		{VL,en5} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en5} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en5} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en5} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en5} = 2'b10;
        end
        3'b010:
        begin
          if(~U_req && U2_sg)		{VU,en5} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en5} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en5} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en5} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en5} = 2'b10;
        end
        3'b011:
        begin
          if(~D_req && D2_sg)		{VD,en5} = 2'b10;
          else if(~EJ_req && EJ2_sg){VEJ,en5} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en5} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en5} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en5} = 2'b10;
        end
        3'b100:
        begin
          if(~EJ_req && EJ2_sg)		{VEJ,en5} = 2'b10;
          else if(~R_req && R2_sg)	{VR,en5} = 2'b10;
          else if(~L_req && L2_sg)	{VL,en5} = 2'b10;
          else if(~U_req && U2_sg)	{VU,en5} = 2'b10;
          else if(~D_req && D2_sg)	{VD,en5} = 2'b10;
        end
        default:
          {VR, VL, VU, VD, VEJ} = 'b0;
      endcase
    end
    
  end  
    Counter cnt1(CR, reset, clk, en1);
    Counter cnt2(CL, reset, clk, en2);
    Counter cnt3(CU, reset, clk, en3);
    Counter cnt4(CD, reset, clk, en4);
    Counter cnt5(CEJ, reset, clk, en5);  
  endmodule