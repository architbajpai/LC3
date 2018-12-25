module execute_correct_2_lovepg (clock, reset, E_Control, IR, npc, W_Control_in, Mem_Control_in, 
		VSR1, VSR2, enable_execute,  W_Control_out, Mem_Control_out, 
		NZP, aluout, pcout, sr1, sr2, dr, M_Data); 	

   input clock, reset, enable_execute;
   input [1:0] W_Control_in;													
   input Mem_Control_in;													
   input [5:0] E_Control;
   input [15:0] IR;
   input [15:0] npc;
   input [15:0] VSR1, VSR2;

   output reg [15:0] aluout, pcout;
   output reg [1:0] W_Control_out;
   output reg Mem_Control_out;
   output reg [2:0] NZP;
   output reg [2:0] sr1, sr2, dr;
   output reg [15:0] M_Data;
   
   //reg [2:0] sr1, sr2, dr;
   //reg [1:0] 			W_Control_out;
   //reg					Mem_Control_out;
   //reg [15:0] 			M_Data;
  // reg [15:0]                   pcout;

   wire [15:0] 	offset11, offset9, offset6, imm5;// trapvect8;
   wire [1:0] 	pcselect1, alu_control;//,alu_control_temp;
   wire pcselect2, op2select;
   reg [15:0] addrin1, addrin2,aluin1_temp, aluin2_temp;
   wire alucarry; 		
   wire [15:0] VSR1_int, VSR2_int;
  // wire alu_or_pc; 
   wire [15:0] aluin1, aluin2;
   //reg [2:0] NZP;
   
   ALU 	alu (clock, reset, aluin1, aluin2, alu_control, enable_execute, aluout, alucarry);

   extension ext (IR, offset11, offset9, offset6, imm5); 

always @ (posedge clock)
     begin
	   if(reset) 
                   begin
	           NZP <= 3'b000;       
	           end
	   else if(enable_execute)
                   begin
	                if(IR[13:12]== 00)
	                        begin
		                    if(IR[15:14] == 2'b00)
                                          begin	
		                          //NZP <= IR[11:9]; 
						if (IR[8:6]==3'b000)
						NZP<=3'b010;
						else if (IR[8:6]!=3'b000)
						NZP<=3'b101;
						else if (IR[8:6]>3'b000)
						NZP<=3'b001;
						else if (IR[8:6]>=3'b000)
						NZP<=3'b011;
						else if (IR[8:6]<3'b000)
						NZP<=3'b100;
						else if (IR[8:6]<=3'b000)
						NZP<=3'b110;
						else
						NZP<=3'b111;
						
		                          end
		                    else if(IR[15:14] == 2'b11)
                                          begin 
		                          NZP <= 3'b000;
		                          end				
		                    else 
                                          begin
			                  NZP <= 3'b000;
		                          end
	                 	  end
	                 else
                         begin
	                 NZP <= 3'b000; 
	                 end			
	           end
	   else 
           begin
	   NZP <= 3'b000;
	   end
     end
   
   

always @(IR) 
     begin
       	case(IR[13:12])
	  2'b00: 
	       begin	      
	       sr1=IR[8:6];
	       sr2=3'd0; 
	       end	
	  2'b01: 
	       begin 
	       sr1=IR[8:6];
	       sr2=IR[2:0];
	       end
	  2'b10: 
	       begin 
	       sr1=IR[8:6];  
	       sr2=3'd0;     
	       //sr2=IR[11:9];
	       //sr2=3'd1;		 
	       end
	  2'b11: 
	       begin 
	       sr1=IR[8:6];    
	       //sr2=IR[2:0];
	       sr2=IR[11:9];      
	       end
	endcase 
     end



always @(posedge clock) 
       begin
 	  if(reset)
 	       begin
 	       dr <=0;
 	       end
 	  else if (enable_execute)
 	     begin
	       case(IR[13:12])
		 2'b00: 
		     begin  
		     dr	<=3'd0;      
		     //NZP<=IR[11:9];
		     end	
		 2'b01: 
		     begin 
		     //dr	<=IR[10:8];    
		     dr	<=IR[11:9];
		     end
		 2'b10: 
		     begin 
		     dr	<=IR[11:9];
	             //dr	<=IR[12:10];   
		     end
		 2'b11: 
		     begin 
		     dr	<=	3'd0;    
		    // sr	<=	IR[11:9];      
		     end
	       endcase  		
 	    end
       end 	

always @ (posedge clock)
   	begin
		if(reset)
	  	begin
	     	W_Control_out <= 0;
	     	Mem_Control_out <= 0;
	     	M_Data	<=0;
	  	end
		
		else if (enable_execute)
		
		//else if (1)
		
	  	begin
	     	W_Control_out 	<= 	W_Control_in;
	     	Mem_Control_out <= 	Mem_Control_in;
	       	M_Data	<=	VSR2_int;
	  	end	  		 
     end
   
assign {alu_control, pcselect1, pcselect2, op2select}=E_Control; 
//assign {alu_control_temp, pcselect2, pcselect1, op2select}=E_Control;  
assign alu_or_pc = 1'b1;       	
assign VSR1_int = VSR1;
assign VSR2_int = VSR2;
   
always @(VSR1_int)
     aluin1_temp=VSR1_int;

  

 always @(op2select or VSR2_int or imm5)
     begin
  	if(op2select)
       	  aluin2_temp=VSR2_int;
    	else
 	  aluin2_temp=imm5;
     end
   
  
//assign	aluin1 = alu_or_pc ? aluin1_temp: addrin1;    
//assign	aluin2 = alu_or_pc ? aluin2_temp: addrin2;
assign	aluin1 = aluin1_temp;
assign	aluin2 = aluin2_temp;
//assign 	alu_control = alu_or_pc ? alu_control_temp : 2'b0;    
//assign 	alu_control = alu_control_temp; 

always @(pcselect1 or offset11 or offset9 or offset6)
     case(pcselect1)
       0: addrin1	=	offset11;
       1: addrin1	=	offset9;
       2: addrin1	=	offset6;
       3: addrin1	=	0;
     endcase

always @(pcselect2 or npc or VSR1_int or IR)
 begin
  	if(pcselect2)
	 	
	 	if(IR[15:12] == 4'b0000) //|| (IR[15:12] == 4'b1100) ) 
                        begin
			addrin2 = npc[1];
		        end
		else if (IR[15:12] == 4'b1100)
                        begin 
       		        addrin2=VSR1_int[0];
		        end
   	 else
		addrin2=VSR1_int[0];    
   end
 
always @(posedge clock)
begin
      if (reset)
                begin
                pcout <= 0;
                end
        else if (enable_execute)
                begin
                pcout <= addrin1 + addrin2;
                end
end
endmodule

