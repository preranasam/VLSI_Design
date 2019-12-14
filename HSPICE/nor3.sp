CMOS 3- INPUT NOR

*netlist of CMOS 3-INPUT NOR

*including the model files
.include 'ami06_models.txt'

*MOSFETs
m1 mid1 in1 vdd vdd ami06P l=600n w=3u
m2 mid2 in2 mid1 mid1 ami06P l=600n w=3u
m3 out in3 mid2 mid2 ami06P l=600n w=3u
m4 out in1 0 0 ami06N l=600n w=1.5u
m5 out in2 0 0 ami06N l=600n w=1.5u
m6 out in3 0 0 ami06N l=600n w=1.5u

*voltage sources
vdd vdd 0 5
vin1 in1 0 PULSE(0V 5V 30n 110p 110p 60n 120n)
vin2 in2 0 PULSE(0V 5V 60n 110p 110p 60n 120n)
vin3 in3 0 PULSE(0V 5V 90n 110p 110p 60n 120n)

*always include this line.It specifies the output files
.options list node post
*Transient Analysis
.tran 20n 600n
.end