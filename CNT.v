module Counter(cnt, R, clk, en);
  output reg [2:0] cnt;
  input R,clk,en;
  always @(posedge clk)
  begin
    if(R)
      cnt = 'b0;
    else begin
      if(en == 1)
        cnt = cnt + 1;
      if(cnt == 3'b101)
        cnt = 'b0;
    end
  end  
endmodule

