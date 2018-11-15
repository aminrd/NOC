module data_in(output_data,enable,em_pl, out_num,PW, vc_g, vc_f, push_o,clk, reset, push_x, PW_fail1, vc_grant, ST_ack,bf_in,X, Y, vt_channel,push_ack);
  
  //Port Assignments:
  parameter LL = 16;	
  parameter MM = 2 ; // MM = (log2_LL)/2
  output [LL-1:0] output_data;
  output reg enable;
  output [2:0] em_pl;
  output reg [2:0] out_num;
  output reg PW, vc_g, vc_f, push_o,push_ack;
  input clk, reset, push_x, PW_fail1, vc_grant, ST_ack;
  input [LL-1:0] bf_in;
  input [MM-1:0] X,Y;
  input [2:0] vt_channel;
  reg PW_fail = 1'b0;
  
  wire [4:0] verification, status;
  reg [MM-1:0] x_final, y_final;

  reg Pri = 'b0;
  reg pop;
  reg push;
  
  reg [2:0] state;		//state	
  reg [2:0] n_state;    //next_state
  
  Buffer sample_buffer (output_data, em_pl, clk, reset, pop, push, bf_in);
  /**/
  XY_logic routing_xy(verification, status, X, Y, x_final, y_final, vt_channel, reset);//XY
  /**/
  /**
  OE_logic routing_oe(verification, status, X, Y, x_final, y_final, vt_channel, reset);//Odd-Even
  /**/
  /**
  WF_logic routing_xy(verification, status, X, Y, x_final, y_final, vt_channel, reset);//MinimalWest-First Algorithm for 2-D Meshes
  /**/  
  
  always @(posedge clk)
  begin
    if(reset)
      state <= 'b0;
    else
      state <= n_state;
  end
  
  always @(*)
    case (state)
      3'b000:
        if(~vc_grant) 		n_state = 'b0;
        else 				n_state = 3'b1;
      3'b001:
        if(ST_ack) 			n_state = 3'b010;
        else 				n_state = 3'b001;
      3'b010:  				n_state = 3'b011;
      3'b011: 				n_state = 3'b100;
      3'b100: 				n_state = 3'b101;
      3'b101: 				n_state = 3'b110;
      3'b110: 				n_state = 3'b000;
    endcase
  
  always @(*)
    case (state)
      3'b000: 
      begin
        {vc_f,push_o,pop} = 3'b100;
        if(vc_grant) 		vc_f = 0;
      end
      3'b001: 				{vc_f,push_o,pop} = 3'b000;
      3'b010: 				{vc_f,push_o,pop} = 3'b011;
      3'b011: 				{vc_f,push_o,pop} = 3'b011;
      3'b100: 				{vc_f,push_o,pop} = 3'b011;
      3'b101: 				{vc_f,push_o,pop} = 3'b011;
      3'b110: 				{vc_f,push_o,pop} = 3'b100;
    endcase
  
  
  always @(*)
	if (reset)				{push,push_ack} = 'b0;
	else begin
		push = 0;
		push_ack = 0;
		if(bf_in[LL-1:LL-2] == 2'b00 && em_pl == 3'd4)
		begin
			push = push_x;
			push_ack = push_x;
		end
		else if(bf_in[LL-1:LL-2] == 2'b01 || bf_in[LL-1:LL-2] == 2'b10)
		begin
			push = push_x;
			push_ack = push_x;
		end // else : DON'T CARE
	end
  always @(*) begin
		x_final = output_data[3:2];
		y_final = output_data[5:4];  
  end
  always @(*)
	if (reset)
		enable=0;  // reset
	else begin
		enable = 0; //reset
		if(output_data[LL-1:LL-2] == 2'b00 && em_pl < 3'd4)  
		begin
			enable = 1;
			Pri = Pri + 1;
		end
	end
  
  always @(posedge clk)
    if(reset) 	vc_g = 0;
    else if(output_data[LL-1:LL-2] == 2'b11)
				vc_g = vc_grant;

  always @(*)
  begin
	if(reset)   {PW,out_num} = 4'b0101;
	else
	case (verification)
      5'b10000: 	out_num = 4;
      5'b01000: 	out_num = 3;
      5'b00100: 	out_num = 2;
      5'b00010: 	out_num = 1;
      5'b00001: 	out_num = 0;
      5'b00101:
      begin
        if(status[0])
        begin
          if(~PW_fail)     {PW,out_num} = 4'b1000;
          else			   {PW,out_num} = 4'b0010;
        end
        else if(status[2])
        begin
          if(~PW_fail)     {PW,out_num} = 4'b1010;		
          else 			   {out_num,PW} = 'b0;
        end
        else
        begin
          PW = 0;
          if(~Pri) 			out_num = 0;         
          else 				out_num = 2;
        end
      end
      
      5'b00110:
      begin
        if(status[1])
        begin
          if(~PW_fail)     {PW,out_num} = 4'b1001;
          else			   {PW,out_num} = 4'b0010;
        end
        else if(status[2])
        begin
          if(~PW_fail)	   {PW,out_num} = 4'b1010;
          else			   {PW,out_num} = 4'b0001;
        end
        else
        begin
          PW = 0;
          if(~Pri) 			out_num = 1;         
          else 				out_num = 2;
        end
      end
      
      5'b01001:
      begin
        if(status[0])
        begin
          if(~PW_fail)	  {PW,out_num} = 4'b1000;
          else			  {PW,out_num} = 4'b0011;
        end
        else if(status[3])
        begin
          if(~PW_fail)	  {PW,out_num} = 4'b1011;
          else			  {PW,out_num} = 'b0;
        end
        else
        begin
          PW = 0;
          if(~Pri) 			out_num = 0;         
          else 				out_num = 3;
        end
      end
      
      5'b01010:
      begin
        if(status[1])
        begin
          if(~PW_fail)	  {PW,out_num} = 4'b1001;
          else			  {PW,out_num} = 4'b0011;
        end
        else if(status[3])
        begin
          if(~PW_fail)	  {PW,out_num} = 4'b1011;
          else			  {PW,out_num} = 4'b0001;

        end
        else
        begin
          PW = 0;
          if(~Pri) 			out_num = 1;         
          else 				out_num = 3;
        end
      end
      
      default:			 {PW,out_num} = 4'b0101;
            
    endcase
  end

endmodule

