CMOS AND

*netlist of CMOS AND

*including the model files
.include 'ami06_models.txt'

.param vdd = 5
.param W = 1.5u
+ L = 600n
+ r_f_time = 110p

.global vdd

*voltage sources
vdd vdd 0 vdd
vin1 a 0 PULSE(0V 5V 30n r_f_time r_f_time 60n 120n)
vin2 b 0 PULSE(0V 5V 60n r_f_time r_f_time 60n 120n)

*Define subcircuit
.subckt inv in out vdd
m1 out in vdd vdd ami06P l=600n w=3u
m2 out in 0 0 ami06N l=600n w=1.5u
.ends


*Define subcircuit
.subckt nand in1 in2 out
m1 out in1 vdd vdd ami06P l=600n w=3u
m2 out in2 vdd vdd ami06P l=600n w=3u
m3 out in2 mid mid ami06N l=600n w=1.5u
m4 mid in1 0 0 ami06N l=600n w=1.5u
.ends

*Main Circuit
Xnand1 a b out1 nand
Xinv1 out1 out vdd inv

*always include this line.It specifies the output files
.options list node post

*Transient Analysis
.tran 20n 600n
.end