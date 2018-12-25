module RegFile(clock, wr, sr1, sr2, din, dr, d1, d2); 

  	input 	clock, wr;
  	input 	[2:0] 	sr1, sr2, dr;     	
  	input 	[15:0] 	din;  
           	
  	output reg [15:0] d1, d2;				

  	reg 	[15:0] 	ram [7:0] ;
  	wire 	[15:0] 	R0,R1,R2,R3,R4,R5,R6,R7;
   	wire	[2:0]	addr1, addr2;
   	wire	[15:0]	data1, data2;
   		
   	assign	addr1 = sr1;
   	
	//assign	addr1 = {1'b1, sr1[1:0]};   // wrong assignments

	assign	addr2 = sr2;
   	assign	data1 = ram[addr1];
   	assign	data2 = ram[addr2];
   	assign 	d1 = data1;
   	assign 	d2 = data2;
   
  	always @(posedge clock)
    begin
       	if (wr)
	ram[dr]<= din;
	//else //block	 
	//ram[dr]<= {din[0], din[14:1], din[15]};	
    end

  	assign 	R0	=	ram[0];
  	assign 	R1	=	ram[1];  
  	assign 	R2	=	ram[2];
  	assign 	R3	=	ram[3];  
  	assign 	R4	=	ram[4];
  	assign 	R5	=	ram[5];  
  	assign 	R6	=	ram[6];
  	assign 	R7	=	ram[7];
   
endmodule