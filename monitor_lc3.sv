class monitor_lc3;
mailbox #(packet_fetch) mon_sb;
packet_lc3 pkt;
packet_fetch fpkt;
virtual intf_lc3 i;
virtual intf_fetch fi;
function new (mailbox #(packet_fetch) mon_sb,virtual intf_fetch fi,virtual intf_lc3 i); //mailbox #(packet_fetch) mon_sb
this.mon_sb=mon_sb;
this.i=i;
this.fi=fi;
endfunction

task run;
pkt=new(); fpkt=new();
@(i.cb);
pkt.pc=i.cb.pc;
pkt.instrmem_rd=i.cb.instrmem_rd;
pkt.instr_dout=i.cb.instr_dout;
pkt.complete_instr=i.cb.complete_instr;
pkt.i_macc=i.cb.i_macc;
pkt.d_macc=i.cb.d_macc;
pkt.data_addr=i.cb.data_addr;
pkt.data_rd=i.cb.data_rd;
pkt.data_din=i.cb.data_din;
pkt.data_dout=i.cb.data_dout;
pkt.complete_data=i.cb.complete_data;

fpkt.enable_updatepc=fi.fcb.enable_updatepc;
fpkt.enable_fetch=fi.fcb.enable_fetch;
fpkt.br_taken=fi.fcb.br_taken;
fpkt.taddr=fi.fcb.taddr;
fpkt.pc=fi.fcb.pc;
fpkt.npc=fi.fcb.npc;
fpkt.instrmem_rd=fi.fcb.instrmem_rd;
@(fi.fcb);
mon_sb.put(fpkt);

endtask
endclass