\* Cutting Stock Problem *\
Minimize
Net_Production_Cost: 0.2 Patt_P0 + 0.56 Patt_P1 + 0.6 Patt_P10 + 0.96 Patt_P11
 + 0.88 Patt_P12 + 0.8 Patt_P13 + Patt_P14 + 0.92 Patt_P2 + 0.48 Patt_P3
 + 0.84 Patt_P4 + 0.76 Patt_P5 + 0.4 Patt_P6 + 0.76 Patt_P7 + 0.68 Patt_P8
 + 0.96 Patt_P9 - 0.25 Surp_5 - 0.33 Surp_7 - 0.4 Surp_9
Subject To
Bensuring_enough_5_cm_rolls: 2 Patt_P10 + 2 Patt_P11 + 2 Patt_P12 + 3 Patt_P13
 + 4 Patt_P14 + Patt_P6 + Patt_P7 + Patt_P8 + Patt_P9 - Surp_5 >= 150
Bensuring_enough_7_cm_rolls: Patt_P12 + Patt_P3 + Patt_P4 + 2 Patt_P5 + Patt_P8
 + 2 Patt_P9 - Surp_7 >= 200
Bensuring_enough_9_cm_rolls: Patt_P1 + Patt_P11 + 2 Patt_P2 + Patt_P4 + Patt_P7
 - Surp_9 >= 300
Bounds
0 <= Patt_P0
0 <= Patt_P1
0 <= Patt_P10
0 <= Patt_P11
0 <= Patt_P12
0 <= Patt_P13
0 <= Patt_P14
0 <= Patt_P2
0 <= Patt_P3
0 <= Patt_P4
0 <= Patt_P5
0 <= Patt_P6
0 <= Patt_P7
0 <= Patt_P8
0 <= Patt_P9
0 <= Surp_5
0 <= Surp_7
0 <= Surp_9
Generals
Patt_P0
Patt_P1
Patt_P10
Patt_P11
Patt_P12
Patt_P13
Patt_P14
Patt_P2
Patt_P3
Patt_P4
Patt_P5
Patt_P6
Patt_P7
Patt_P8
Patt_P9
Surp_5
Surp_7
Surp_9
End
