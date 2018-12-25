class coverage_lc3;
virtual intf_lc3 i;
covergroup cg @ (i.clk,i.rst);
ID: coverpoint i.instr_dout {bins ii={[16'h0000:16'hffff]};}
DDO: coverpoint i.data_dout {bins dd={[16'h0000:16'hffff]};} 
//CI: coverpoint i.complete_instr;
//CD: coverpoint i.complete_data;
PC: coverpoint i.pc {bins aa={[16'h3000:16'h3050]};}
DD: coverpoint i.data_din {bins ddd={[16'h0000:16'hffff]};}
DA: coverpoint i.data_addr{bins bois={[16'h0000:16'hffff]};} 
IR: coverpoint i.instrmem_rd{bins yolo={[16'h0000:16'hffff]};} 
IM: coverpoint i.i_macc;
//DM: coverpoint i.d_macc;
DR: coverpoint i.data_rd;
CIDI: cross i.complete_data,i.complete_instr;
endgroup

function new (virtual intf_lc3 i);
this.i=i;
cg=new();
endfunction
task sample;
cg.sample;
endtask
endclass