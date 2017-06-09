︠da533de3-b430-497f-b1d2-7137969e2efas︠
p = MixedIntegerLinearProgram(maximization=False)
y = p.new_variable(real=true)
x = p.new_variable(real=true)

p.set_objective(52*y[1]+134*y[2]+47*y[3]+40*y[4]+68*y[5]+
                135*y[6]+49*y[7]+89*y[8]+86*y[9]+
                181*y[10]+166*y[11]+202*y[12]+
                85*y[13]+40*y[14]+74*y[15])

p.add_constraint(2 <= y[1] + y[2] + y[3] + y[4] + y[5] + x[1])
p.add_constraint(2 <= y[1] + y[6] + y[7] + y[8] + y[9] + x[2])
p.add_constraint(2 <= y[2] + y[6] + y[10] + y[11] + y[12] + x[3])
p.add_constraint(2 <= y[3] + y[7] + y[10] + y[13] + y[14] + x[4])
p.add_constraint(2 <= y[4] + y[8] + y[11] + y[13] + y[15] + x[5])
p.add_constraint(2 <= y[5] + y[9] + y[12] + y[14] + y[15] + x[6])

p.add_constraint( x[1] + x[2] + x[3] + x[4] + x[5] + x[6] <= 2)

p.add_constraint(0 <= y[1] <= 1)
p.add_constraint(0 <= y[2] <= 1)
p.add_constraint(0 <= y[3] <= 1)
p.add_constraint(0 <= y[4] <= 1)
p.add_constraint(0 <= y[5] <= 1)
p.add_constraint(0 <= y[6] <= 1)
p.add_constraint(0 <= y[7] <= 1)
p.add_constraint(0 <= y[8] <= 1)
p.add_constraint(0 <= y[9] <= 1)
p.add_constraint(0 <= y[10] <= 1)
p.add_constraint(0 <= y[11] <= 1)
p.add_constraint(0 <= y[12] <= 1)
p.add_constraint(0 <= y[13] <= 1)
p.add_constraint(0 <= y[14] <= 1)
p.add_constraint(0 <= y[15] <= 1)
p.add_constraint(0 <= x[1] <= 1)
p.add_constraint(0 <= x[2] <= 1)
p.add_constraint(0 <= x[3] <= 1)
p.add_constraint(0 <= x[4] <= 1)
p.add_constraint(0 <= x[5] <= 1)
p.add_constraint(0 <= x[6] <= 1)


p.set_binary(x)
p.set_binary(y)
p.show()
p.solve()
p.get_values(y)
p.get_values(x)