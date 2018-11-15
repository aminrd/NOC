module status_signal (R_SG, L_SG, U_SG, D_SG, EJ_SG,req_R, req_L, req_U, req_D, req_EJ, SR, SL, SU, SD, SEJ);

  output R_SG, L_SG, U_SG, D_SG, EJ_SG;
  input req_R, req_L, req_U, req_D, req_EJ;
  input SR, SL, SU, SD, SEJ;  
  assign {R_SG,L_SG,U_SG,D_SG,EJ_SG} = 
				{req_R & SR,
				 req_L & SL,
				 req_U & SU,
				 req_D & SD,
				 req_EJ & SEJ};
endmodule
