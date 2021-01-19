* Diode D1 stress analysis
set d1_max_i=maxabs(i(@d.xd1.d1[id]))
echo "Peak diode current in D1:"
print $d1_max_i

set d1_ss_i=(i(@d.xd1.d1[id]))[npt]
echo "Steady state diode current in D1"
print $d1_ss_i

set d1_pwr=i(@d.xd1.d1[id])*(v(vde)-v(vout))
echo "Peak power in diode D1:"
print maximum($d1_pwr)

set d1_ss_pwr=i(@d.xd1.d1[id])[npt]*(v(vde)[npt]-v(vout)[npt])
echo "Steady state power in diode D1:"
print $d1_ss_pwr
* Capacitor C1 stress analysis
*
set c1_max_v=maxabs(v(vout))
echo "Maximum voltage on capacitor C1:"
print $c1_max_v
*
set c1_pwr=i(@c.xc1.c1[i])*v(vout)
echo "Check for steady-state power in capacitor C1:"
print ($c1_pwr)[npt]

* Resistor R1 stress analysis
set r1_max_v=maxabs(v(vout))
echo "Maximum voltage on resistor R1:"
print $r1_max_v

set r1_pwr=i(@r.xr1.r1[i])*(v(vin)-v(vde))
echo "Maximum power on resistor R1:"
print maximum($r1_pwr)

echo "Steady state power on resistor R1:"
print ($r1_pwr)[npt]

* Resistor R2 stress analysis
set r2_max_v=maxabs(v(vout))
echo "Maximum voltage on resistor R2:"
print $r2_max_v

set r2_pwr=i(@r.xr2.r1[i])*v(vout)
echo "Maximum power on resistor R2:"
print maximum($r2_pwr)

echo "Steady state power on resistor R2:"
print ($r2_pwr)[npt]

set j1_pwr=i(v.xj1.v1)*v(vin)
set load_pwr=$d1_pwr+$c1_pwr+$r1_pwr+$r2_pwr
set imbalance=abs($j1_pwr+$load_pwr)
echo "Maximum energy imbalance:"
print maximum($imbalance)
