CMOS inverter
*netlist of CMOS inverter

*including the model files
.include `ami06_models.txt'

*MOSFETs
m1 out in vdd vdd ami06P l=600n w=3u
m2 out in 0 0 ami06N l=600n w=1.5u

*voltage sources
vdd vdd 0 5
vin in 0 PULSE(0V 5V 20n 100p 100p 20n 40n)

*always include this line.It specifies the output files
.options list node post

*Transient Analysis
.tran 20n 200n

.end
