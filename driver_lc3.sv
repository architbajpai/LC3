class driver_lc3;
packet_lc3 pkt;
mailbox #(packet_lc3) gen_drv;
virtual intf_lc3 i;

function new (mailbox #(packet_lc3) gen_drv, virtual intf_lc3 i);
this.gen_drv=gen_drv;
this.i=i;
endfunction

task run;
pkt=new();
gen_drv.get(pkt);
i.cb.instr_dout<=pkt.instr_dout;
i.cb.data_dout<=pkt.data_dout;
i.cb.complete_instr<=pkt.complete_instr;
i.cb.complete_data<=pkt.complete_data;
@(i.cb);
endtask
endclass