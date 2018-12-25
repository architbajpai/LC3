interface intf_lc3 (input clk,rst);
logic [15:0] instr_dout,data_dout,pc,data_din,data_addr;
logic complete_instr,complete_data,instrmem_rd,i_macc,d_macc,data_rd;

clocking cb @(posedge clk);
	default input #1 output #1;
	
	input  pc, data_addr;
	input instrmem_rd, data_rd;
	input  data_din;
	input d_macc,i_macc;

	output  data_dout;
	output instr_dout;
	output complete_instr,complete_data;
endclocking

endinterface

