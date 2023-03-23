add wave *



--testing the reset 
force reset 1
force sel 00
force sel 01
force sel 10
force sel 11
force reset 0
run 2
examine  min_out max_out reg_out


--input first value 

force clk 0
force din 1001
force clk 1
force sel 00
force sel 01
force sel 10
force sel 11
run 2


--input second value 
force clk 0
force din 0011
force clk 1
force sel 00
force sel 01
force sel 10
force sel 11
run 2
examine  min_out max_out reg_out

--input third value 
force clk 0
force din 0111
force clk 1
force sel 00
force sel 01
force sel 10
force sel 11
run 2
examine  min_out max_out reg_out



