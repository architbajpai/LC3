class scoreboard_lc3;
packet_fetch fpkt;
mailbox #(packet_fetch) mon_sb;
reg [15:0] pc=16'h3000;
reg [15:0] npc=16'h3001;
reg [15:0] pcr1=16'h3001;
reg [15:0] pcr2=16'h3001;
reg [15:0] pcr3=16'h3001;
reg instrmem_rd;

function new (mailbox #(packet_fetch) mon_sb);
this.mon_sb=mon_sb;
endfunction

task run;
 mon_sb.get(fpkt);
begin
		if (fpkt.enable_updatepc)
		begin		
			if (fpkt.br_taken)
			begin
			pcr1=pc;
			pc=fpkt.taddr;
			end

			else
			begin
			pcr2=pcr3;
			pc=pcr3;
			pcr3=pcr3+1'b1;
			pcr1=pcr1+1'b1;
			end
		
		end
		
		else
		begin
		pc=pc; 
		end
npc=pcr3;
end

if(pc==fpkt.pc)//&&(instrmem_rd)==fpkt.instrmem_rd)(npc)==fpkt.npc&&
$display("INSC success!! matched %h %h %d",fpkt.npc, npc,fpkt.br_taken);
else
begin
$display("INSC mismatch!!");
$display($time,"INSC fpkt.npc=%h npc=%h %d",fpkt.npc,npc,fpkt.br_taken);
end
endtask
endclass