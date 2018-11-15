module Buffer (bf_out,em_pl,clk, reset, pop, push,bf_in);
  parameter LL = 16;	
  output [LL-1:0] bf_out;		   
  output reg [2:0] em_pl;
  input clk, reset, pop, push;
  input [LL-1:0] bf_in;  
  reg [LL-1:0] bf [0:3]; // totaly : 64-bit
  reg [1:0] add_wr;
  reg [1:0] add_rd;
  
  assign bf_out = bf[add_rd];
  
  always @(posedge clk)
    if(reset)
    begin
      bf[0] <= 'b0;
      bf[1] <= 'b0;
      bf[2] <= 'b0;
      bf[3] <= 'b0;
      em_pl = 3'd4;
      add_wr = 'b0;
      add_rd = 'b0;
    end
    else begin
      if(push&& ~pop && em_pl > 3'd0)
      begin
        bf[add_wr] <= bf_in;
        em_pl = em_pl - 1;
        add_wr = add_wr + 1;
      end
      else if(~push&& pop && em_pl < 3'd4)
      begin
        em_pl = em_pl + 1;
        add_rd = add_rd + 1;
      end
      else if(push&&pop)
      begin
        if(em_pl == 3'd4)
        begin
          bf[add_wr] <= bf_in;
          add_wr = add_wr + 1;
          em_pl = em_pl - 1;
        end
        else
        begin
          bf[add_wr] <= bf_in;
          add_wr = add_wr + 1;
          add_rd = add_rd + 1;
        end
      end
    end
endmodule
