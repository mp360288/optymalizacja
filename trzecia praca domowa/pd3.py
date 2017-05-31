#Program dla danego problemu optymalizacyjnego znajduje problem pomocniczy
#Szkielet programu jest oparty na rozwiazaniu poprzedniego zadania domowego

import numpy as np
import itertools as it
        
A = []
b = []
c = []
d = []

varNr = int(input('Podaj liczbe zmiennych problemu: '))
print(' ')
print('Definiujemy funkcje celu')
print(' ')
for i in range(varNr):
    c.append(float(input('Podaj wspolczynnik przy x' + str(i + 1) + ': ')))
print(' ')

restrNr = int(input('Podaj liczbe rownosci: '))
print(' ')
print('Definiujemy kolejne rownosci ')
print(' ')

for i in range(restrNr):
    print ('Rownosc nr ', i + 1)
    a = []
    
    for j in range(varNr):
        a.append(float(input('Podaj wspolczynnik przy x' + str(j + 1) + ': ')))
    b.append(float(input('Podaj wartosc rownosci: ')))
    
    for j in range(restrNr):
        if i == j:
            a.append(1.0)
        else:
            a.append(0.0)
            
    A.append(a)
    c.append(0.0)
    print(' ')
    
for i in range(varNr):
	d.append(0.0)
    
for i in range(restrNr):

	d.append(-1.0)

A = np.array(A)
b = np.array(b)
#c = np.array(c)
D = np.array(d)

#Potencjalne rozwiazanie problemu pomocniczego jakims solverem
#P = InteractiveLPProblem(A, b, D, , constraint_type="==")
#P = P.standard_form()
#P.run_simplex_method()