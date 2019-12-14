CMOS Full Adder

*netlist of CMOS Full Adder

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
vin2 b 0 PULSE(0V 5V 30n r_f_time r_f_time 60n 120n)
vin3 c 0 PULSE(0V 5V 30n r_f_time r_f_time 60n 120n)

*Define subcircuit
.subckt and in1 in2 out vdd
m1 out1 in1 vdd vdd ami06P l=L w=Wp
m2 out1 in2 vdd vdd ami06P l=L w=Wp
m3 out1 in2 mid mid ami06N l=L w=Wn
m4 mid in1 0 0 ami06N l=L w=Wn
m6 out out1 vdd vdd ami06P l=L w=Wp
m7 out out1 0 0 ami06N l=L w=Wn
.ends


*Define subcircuit
.subckt xor in1 in2 out vdd
m1 in1_bar in1 vdd vdd ami06P l=600n w=3u
m2 in1_bar in1 0 0 ami06N l=600n w=1.5u
m3 in2_bar in2 vdd vdd ami06P l=600n w=3u
m4 in2_bar in2 0 0 ami06N l=600n w=1.5u
m5 mid1 in1_bar vdd vdd ami06P l=600n w=3u
m6 out in2 mid1 mid1 ami06P l=600n w=3u
m7 mid2 in1 vdd vdd ami06P l=600n w=3u
m8 out in2_bar mid2 mid2 ami06P l=600n w=3u
m9 out in1 mid3 mid3 ami06N l=600n w=1.5u
m10 mid3 in2 0 0 ami06N l=600n w=1.5u
m11 out in1_bar mid4 mid4 ami06N l=600n w=1.5u
m12 mid4 in2_bar 0 0 ami06N l=600n w=1.5u
.ends


*Define subcircuit
.subckt nor in1 in2 out vdd
m1 mid in1 vdd vdd ami06P l=L w=Wp
m2 out in2 mid mid ami06P l=L w=Wp
m3 out in1 0 0 ami06N l=L w=Wn
m4 out in2 0 0 ami06N l=L w=Wn
.ends


*Define subcircuit
.subckt inv in out vdd
m1 out in vdd vdd ami06P l=L w=Wp
m2 out in 0 0 ami06N l=L w=Wn
.ends


*Define subcircuit
.subckt or in1 in2 out vdd
Xnor1 in1 in2 out1 vdd nor
Xinv1 out1 out vdd inv
.ends


*Main Circuit
Xxor1 a b s1 vdd xor
Xand1 a b c1 vdd and
Xxor2 s1 c s vdd xor
Xand2 s1 c c2 vdd and
Xor1 c1 c2 co vdd or

*always include this line.It specifies the output files
.options list node post

*Transient Analysis
.tran 20n 600n
.end