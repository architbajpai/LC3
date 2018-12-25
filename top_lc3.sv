`include "packet_lc3.sv"
`include "packet_fetch.sv"
`include "generator_lc3.sv"
`include "driver_lc3.sv"
`include "intf_lc3.sv"
`include "intf_fetch.sv"

`include "fetch_correct.sv"
`include "decode_correct.sv"
`include "execute_correct_2_lovepg.sv"
`include "ALU.sv"
`include "extension.sv"
`include "writeback_correct.sv"
`include "RegFile.sv"
`include "memaccess.sv"
`include "controller_pipeline.sv"
`include "lc3.sv"

`include "coverage_lc3.sv"
`include "coverage_fetch.sv"
`include "monitor_lc3.sv"
`include "scoreboard_lc3.sv"
`include "environment_lc3.sv"
`include "test_lc3.sv"

module top_lc3;
reg clk,rst;
initial 
clk=1'b0;
always #5 clk=~clk;

initial begin
rst=1'b1;
#10 rst=1'b0;
#100 rst=1'b1;
#100 rst=1'b0;
end

intf_lc3 i(clk,rst);

lc3 dut (.clock(clk),.reset(rst),.pc(i.pc),.instrmem_rd(i.instrmem_rd),.complete_instr(i.complete_instr),
.complete_data(i.complete_data),.I_macc(i.i_macc),.D_macc(i.d_macc),.Data_rd(i.data_rd),
.Instr_dout(i.instr_dout),.Data_dout(i.data_dout),.Data_din(i.data_din),.Data_addr(i.data_addr));

intf_fetch fi(.clk(clk),.rst(rst),.enable_updatepc(dut.Fetch.enable_updatePC),.enable_fetch(dut.Fetch.enable_fetch),
.br_taken(dut.Fetch.br_taken),.instrmem_rd(dut.Fetch.instrmem_rd),.pc(dut.Fetch.pc),
.taddr(dut.Fetch.taddr),.npc(dut.Fetch.npc_out));

test_lc3 t1 (fi,i);
endmodule