module data_out (output_data,write_req, alloc_status,em_pl,clk, reset, push, next_state, alloc,input_data,write_req_ack);
  
  parameter LL = 16;//packet size
  parameter MM = 2 ; // MM = (log2_LL)/2
  output [LL-1:0] output_data;
  output reg write_req, alloc_status;
  output [2:0] em_pl;
  input clk, reset, push, next_state, alloc;
  input [LL-1:0] input_data;
  input write_req_ack;
  
  reg pop;
  reg push_x;
  Buffer sample_buffer (output_data, em_pl, clk, reset, pop, push_x, input_data);

  always @(*)
  begin
    push_x = push;
    if(~push && em_pl > 3'd0 && input_data[LL-1:LL-2] == 2'b10 && (output_data[LL-1:LL-2] == 2'b01 || output_data[LL-1:LL-2] == 2'b00) )
      push_x = 1;
  end
  
  always @(*)
	if(reset)
		write_req = 0;
	else
		if((output_data[LL-1:LL-2] != 2'b11) && (em_pl != 3'd4))//next_state && 
  		  write_req = 1'b1;
		else
		  write_req = 1'b0;	
  
  always @(*)
    if(write_req_ack)
      pop = 1'b1;
	else
	  pop = 1'b0;	
  
  always @(*)
    if(reset) alloc_status = 0;
    else  	  alloc_status = alloc;

endmodule

