module CrossBar (OR,OL,OU,OD,Eject,R_req, L_req, U_req, D_req, EJ_req,IR, IL, IU, ID, IEJ);
  
  parameter LL = 16;
  output reg [LL-1:0] OR,OL,OU,OD,Eject;
  input [2:0] R_req, L_req, U_req, D_req, EJ_req;
  input [LL-1:0] IR, IL, IU, ID, IEJ;
  always @(*)
  begin
    case (R_req)
      3'd0: OR = IR;
      3'd1: OR = IL;
      3'd2: OR = IU;
      3'd3: OR = ID;
      3'd4: OR = IEJ;
      default:
        OR = 'b0;
    endcase
    case (L_req)
      3'd0: OL = IR;
      3'd1: OL = IL;
      3'd2: OL = IU;
      3'd3: OL = ID;
      3'd4: OL = IEJ;
      default:
        OL = 'b0;
    endcase
    case (U_req)
      3'd0: OU = IR;
      3'd1: OU = IL;
      3'd2: OU = IU;
      3'd3: OU = ID;
      3'd4: OU = IEJ;
      default:
        OU = 'b0;
    endcase
    case (D_req)
      3'd0: OD = IR;
      3'd1: OD = IL;
      3'd2: OD = IU;
      3'd3: OD = ID;
      3'd4: OD = IEJ;
      default:
        OD = 'b0;
    endcase
    case (EJ_req)
      3'd0: Eject = IR;
      3'd1: Eject = IL;
      3'd2: Eject = IU;
      3'd3: Eject = ID;
      3'd4: Eject = IEJ;
      default:
        Eject = 'b0;
    endcase
  end
  
endmodule

