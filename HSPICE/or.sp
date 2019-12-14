CMOS OR

*netlist of CMOS OR

*including the model files
.include 'ami06_models.txt'

.param vdd = 5
.param Wn = 1.5u
+ Wp = 3u
+ L = 600n
+ r_f_time = 110p

.global vdd

*voltage sources
vdd vdd 0 vdd
vin1 a 0 PULSE(0V 5V 30n r_f_time r_f_time 60n 120n)
vin2 b 0 PULSE(0V 5V 60n r_f_time r_f_time 60n 120n)

*Define subcircuit
.subckt inv in out vdd
m1 out in vdd vdd ami06P l=L w=Wp
m2 out in 0 0 ami06N l=L w=Wn
.ends


*Define subcircuit
.subckt nor in1 in2 out
m1 mid in1 vdd vdd ami06P l=L w=Wp
m2 out in2 mid mid ami06P l=L w=Wp
m3 out in1 0 0 ami06N l=L w=Wn
m4 out in2 0 0 ami06N l=L w=Wn
.ends

*Main Circuit
Xnor1 a b out1 nor
Xinv1 out1 out vdd inv

*always include this line.It specifies the output files
.options list node post

*Transient Analysis
.tran 20n 600n
.end