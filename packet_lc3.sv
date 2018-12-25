class packet_lc3;
rand logic [15:0] instr_dout,data_dout;
rand logic complete_instr,complete_data;
bit rst;
logic [15:0] pc,data_din,data_addr;
logic instrmem_rd,i_macc,d_macc,data_rd;
//constraint c1 { data_dout dist {16'h0400:/50, [16'h0000:16'hefff]:/50};}
function void pre_randomize();
$display("INPACKLC3 instr_dout:%h	data_dout:%h   complete_instr:%0b  complete_data:%0b",instr_dout,
data_dout,complete_instr,complete_data);
endfunction

function void post_randomize();
$display("INPACKLC3 instr_dout:%h	data_dout:%h   complete_instr:%0b  complete_data:%0b",instr_dout,
data_dout,complete_instr,complete_data);
endfunction
endclass