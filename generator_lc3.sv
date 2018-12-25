class generator_lc3;
packet_lc3 pkt;
mailbox #(packet_lc3) gen_drv;
function new (mailbox #(packet_lc3) gen_drv);
this.gen_drv=gen_drv;
endfunction
task run;
pkt=new();
assert (pkt.randomize())
begin
$display("success");
gen_drv.put(pkt);
end
else
$error("randomization failed");
endtask
endclass