p = MixedIntegerLinearProgram(maximization=True, solver = "GLPK")
f=open('wynik3.txt',"w")
for i in range(9):
    f.write('zagranie przeciwnika - ' + str(i))
    f.write('\n')
    for k in range(4):
        y = p.new_variable(real=True)
        p.set_objective(y[9])
        #dla kostki = 1
        if (k==0):
            p.add_constraint(0 <= y[0] + y[1] + y[2] + y[3] - 1/2*y[4] - y[9])
        #dla kostki = 2
        if (k==1):
            p.add_constraint(0 <= y[1] - 1/2*y[0] - y[4] - y[6] - y[7] - y[9])
        #dla kostki = 3
        if (k==2):
            p.add_constraint(0 <= y[2] - 1/2*y[0] - y[4] - y[5] - y[7] - y[9])
        #dla kostki = 4
        if (k==3):
            p.add_constraint(0 <= y[3] - 1/2*y[0] - y[4] - y[5] - y[6] - y[9])
        if (i==7):
            p.add_constraint(y[7] + y[6] + y[5] + y[4] + y[3] + y[2] + y[1] + y[0] <= 0)
        if (i==6):
            p.add_constraint(y[6] + y[5] + y[4] + y[3] + y[2] + y[1] + y[0] <= 0)
        if (i==5):
            p.add_constraint(y[5] + y[4] + y[3] + y[2] + y[1] + y[0] <= 0)
        if (i==4):
            p.add_constraint(y[4] + y[3] + y[2] + y[1] + y[0] <= 0)
        if (i==3):
            p.add_constraint(y[3] + y[2] + y[1] + y[0] <= 0)
        if (i==2):
            p.add_constraint(y[2] + y[1] + y[0] <= 0)
        if (i==1):
            p.add_constraint(y[1] + y[0] <= 0)
        if (i==0):
            p.add_constraint(y[0] <= 0)
        #p.add_constraint(1 <= q[0] + y[8] + y[7] + y[6] + y[5] + y[4] + y[3] + y[2] + y[1] + y[0] <= 1)
        p.add_constraint(1 <= y[0]+y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]+y[8] <= 1)
        p.add_constraint(0 <= y[0])
        p.add_constraint(0 <= y[1])
        p.add_constraint(0 <= y[2])
        p.add_constraint(0 <= y[3])
        p.add_constraint(0 <= y[4])
        p.add_constraint(0 <= y[5])
        p.add_constraint(0 <= y[6])
        p.add_constraint(0 <= y[7])
        p.add_constraint(0 <= y[8])
        p.add_constraint(0 <= y[9])
        #p.show()
        p.solve()
        #p.get_values(y)
        y = p.get_values(y)
        #print(i)
        #print(k+1,' ',y)
        #print('\n')
        f.write('wynik kostki = ' + str(k+1) + ' => ')
        for a in range(10):
            if (y[a] == 1):
                f.write('optymalne zagranie to ' + str(a))
        f.write('\n')
f.close() 
