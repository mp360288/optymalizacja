import numpy as np
import itertools as it

# WAZNE!
# Algorytm MAKSYMALIZUJE funkcje celu
# Kazde ograniczenie jest postaci: zmienne <= liczba
# Algorytm zwraca tylko nieujemne wyniki,
# gdy takich nie ma jest stosowny komunikat
        
###################################

def nonNegative(sth):
    nn = True
    for i in sth:
        if i <= 0:
            nn = False
    return nn
    

def index(var, constr):
    for ind in it.permutations(range(var + constr), constr):
        if ind == tuple(sorted(ind)):
            yield ind
            

def appendCol(array, col):
    if array is None:
        return col
    else:
        return np.append(array, col, 1)

###################################
        
A = []
b = []
c = []

varNr = int(input('Podaj liczbe zmiennych problemu: '))
print(' ')
print('Definiujemy funkcje celu')
print(' ')
for i in range(varNr):
    c.append(float(input('Podaj wspolczynnik przy x' + str(i + 1) + ': ')))
print(' ')

restrNr = int(input('Podaj liczbe ograniczen: '))
print(' ')
print('Definiujemy kolejne ograniczenia ')
print(' ')

for i in range(restrNr):
    print ('Ograniczenie nr ', i + 1)
    a = []
    
    for j in range(varNr):
        a.append(float(input('Podaj wspolczynnik przy x' + str(j + 1) + ': ')))
    b.append(float(input('Podaj wartosc ograniczenia: ')))
    
    for j in range(restrNr):
        if i == j:
            a.append(1.0)
        else:
            a.append(0.0)
            
    A.append(a)
    c.append(0.0)
    print(' ')
    
A = np.array(A)
b = np.array(b)
c = np.array(c)

###################################

maxATb = float('-inf')
maximum = []

for col in index(varNr, restrNr):
    Ab = None
    
    for i in col:
        Ab = appendCol(Ab, A[:, [i]])
        
    if np.linalg.det(Ab) != 0.0:
        AT = np.linalg.inv(Ab)
        ATb = np.dot(AT,b)
        
        if nonNegative(ATb):
            currAb = [0] * (varNr + restrNr)
            j = 0
            
            for i in col:
                currAb[i] = ATb[j]
                j += 1
                
            curr = np.dot(c,currAb)
            
            if curr >= maxATb:
                maxATb = curr
                maximum = currAb[:varNr]

###################################

if maximum == []:
    print ('Nie istnieja takie rozwiazanie, aby wartosci byly nieujemne')
else:
    print ('Maksimum funkcji wynosi ' + str(maxATb))
    print ('Wynik maksymalizacji: ' + str(maximum))




        
