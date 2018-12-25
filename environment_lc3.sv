class environment_lc3;
mailbox #(packet_lc3) gen_drv;
mailbox #(packet_fetch) mon_sb;
virtual intf_lc3 i;
virtual intf_fetch fi;
generator_lc3 g1;
driver_lc3 d1;
monitor_lc3 m1;
scoreboard_lc3 s1;
coverage_lc3 c1;
coverage_fetch c2;
function new (virtual intf_fetch fi, virtual intf_lc3 i);
this.i=i;
this.fi=fi;
endfunction

function build();
gen_drv=new();
mon_sb=new();

g1=new(gen_drv);
d1=new(gen_drv,i);
m1=new(mon_sb,fi,i);
s1=new(mon_sb);
c1=new(i);
c2=new(fi);
endfunction

task run;
g1.run; d1.run; m1.run; s1.run; c1.sample; c2.sample;
endtask
endclass