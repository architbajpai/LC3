module test_lc3 ( intf_fetch fi,intf_lc3 i);
environment_lc3 en;
initial begin
en=new(fi,i);
en.build();
repeat(1000)
begin
#10 en.run();
end
end
endmodule