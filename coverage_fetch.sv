class coverage_fetch;
virtual intf_fetch i;
covergroup cg @ (i.clk,i.rst);
//EU: coverpoint i.enable_updatepc;
EF: coverpoint i.enable_fetch;
//BT: coverpoint i.br_taken;
TA: coverpoint i.taddr{bins tt={[16'h0000:16'hffff]};}
PC: coverpoint i.pc {bins pp={[16'h3000:16'h3050]};} 
NPC: coverpoint i.npc{bins nn={[16'h3000:16'h3050]};} 
IR: coverpoint i.instrmem_rd{bins irr={[16'h0000:16'hffff]};} 
euxbt:cross i.enable_updatepc,i.br_taken;
endgroup

function new (virtual intf_fetch i);
this.i=i;
cg=new();
endfunction
task sample;
cg.sample;
endtask
endclass
