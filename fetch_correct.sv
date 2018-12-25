module fetch_correct (clock, reset, enable_updatePC, enable_fetch, pc,npc_out,
instrmem_rd, taddr, br_taken);
input enable_updatePC,clock, reset, br_taken, enable_fetch;
input [15:0] taddr;
output [15:0] pc, npc_out;
output instrmem_rd;
reg [15:0]ipc,ipcr1;
wire [15:0]muxout;
wire [15:0] npc_int;
always @(posedge clock)
begin
if(reset==1)
begin
ipc<=16'h3000; ipcr1<=16'h3000;// pc<=16'h3000;
end
else
begin
if(enable_updatePC)
begin
ipc <= muxout;
	if (br_taken)
	ipcr1<=ipcr1;
	else
	ipcr1<=ipcr1+1'b1;
end

else
ipc <= ipc;
end
end
//assign ipcr1=(reset)?16'h3000:((br_taken)?ipcr1:(ipcr1+1'b1));
assign npc_int=(reset==1)?16'h3001:ipcr1;
assign muxout=(br_taken)?taddr: npc_int;
//assign npc_int=ipcr1+1;
assign npc_out = npc_int;
assign pc = ipc;
assign instrmem_rd = (enable_fetch)?1'b1: 1'bz;
endmodule
