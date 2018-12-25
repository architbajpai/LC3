module extension(ir, offset11, offset9, offset6,imm5);
   input [15:0] ir;
   output reg [15:0] offset11, offset9, offset6, imm5; //trapvect8,
   assign offset11={{5{ir[10]}}, ir[10:0]};
   assign offset9 ={{7{ir[8]}}, ir[8:0]};
   //assign offset9 ={{8{ir[7]}}, ir[7:0]};  
   assign offset6={{10{ir[5]}}, ir[5:0]};
   assign imm5={{11{ir[4]}}, ir[4:0]};
  //assign imm5={{12{ir[3]}}, ir[3:0]};  
  //assign trapvect8={ {8{ir[7]}}, ir[7:0]};   

endmodule 
