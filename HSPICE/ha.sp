CMOS Half Adder

*netlist of CMOS Half Adder

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
.subckt and in1 in2 out vdd
m1 out1 in1 vdd vdd ami06P l=600n w=3u
m2 out1 in2 vdd vdd ami06P l=600n w=3u
m3 out1 in2 mid mid ami06N l=600n w=1.5u
m4 mid in1 0 0 ami06N l=600n w=1.5u
m6 out out1 vdd vdd ami06P l=600n w=3u
m7 out out1 0 0 ami06N l=600n w=1.5u
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

*Main Circuit
Xxor1 a b s vdd xor
Xand1 a b c vdd and

*always include this line.It specifies the output files
.options list node post

*Transient Analysis
.tran 20n 600n
.end