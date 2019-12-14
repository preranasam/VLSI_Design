CMOS NOR

*netlist of CMOS NOR

*including the model files
.include 'ami06_models.txt'

*MOSFETs
m1 mid in1 vdd vdd ami06P l=600n w=3u
m2 out in2 mid mid ami06P l=600n w=3u
m3 out in1 0 0 ami06N l=600n w=1.5u
m4 out in2 0 0 ami06N l=600n w=1.5u

*voltage sources
vdd vdd 0 5
vin1 in1 0 PULSE(0V 5V 30n 110p 110p 60n 120n)
vin2 in2 0 PULSE(0V 5V 60n 110p 110p 60n 120n)

*always include this line.It specifies the output files
.options list node post
*Transient Analysis
.tran 20n 600n
.end