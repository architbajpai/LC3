interface intf_fetch (input bit clk,rst,
input logic enable_updatepc,enable_fetch,br_taken, instrmem_rd,
input logic [15:0] taddr,pc,npc);

clocking fcb @(posedge clk);
	default input #1 output #0;
	
	input pc, npc;
	input instrmem_rd;

	output enable_updatepc,br_taken,enable_fetch;
	output taddr;
endclocking


property p1; 
@(posedge clk) $rose(enable_fetch) |-> $rose(instrmem_rd);
endproperty


property p2;
@(posedge clk) rst |-> ##1 (pc==16'h3000);
endproperty
 
property p3;
@(posedge clk) p1 and p2;
endproperty 

p4: assert property (p3);
endinterface
