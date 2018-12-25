class packet_fetch;
string name;
logic enable_updatepc,enable_fetch,br_taken;
logic rst;
logic [15:0] taddr;
logic [15:0] npc,pc;
logic instrmem_rd;
//constraint c {taddr inside {[16'h3000:16'h3050]};}
//constraint c1 {rst->pc==16'h3000; rst->npc==16'h3001;}
/*function void pre_randomize();
$display("enable_updatePC:%0b	enable_fetch:%0b   br_taken:%0b  rst:%0b  taddr:%h",enable_updatepc,
enable_fetch,br_taken,rst,taddr);
endfunction

function void post_randomize();
$display("enable_updatePC:%0b	enable_fetch:%0b   br_taken:%0b  rst:%0b  taddr:%h",enable_updatepc,
enable_fetch,br_taken,rst,taddr);
endfunction*/
endclass