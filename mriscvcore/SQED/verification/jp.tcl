clear -all
analyze -sva reverse.v
elaborate -top top -bbox_a 9000
reset rst
clock clk
prove -bg -all
