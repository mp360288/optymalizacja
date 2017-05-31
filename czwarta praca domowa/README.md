Treść programu można wstawić do solvera sage (np. cocalc.com).
Rozpatrywany przypadek dotyczy ilości żołnierzy S=6 oraz liczby pól N=3, włączając pola zerowe i permutacje. Łącznie istnieje 28 ustawień, które sprowadziłem z dokładnością do permutacji do 7 "ogólnych" - niemalejących, a następnie policzyłem macierz wypłaty z prawdopodobieństwami w ramach jednej "ogólnej" permutacji. Poszczególne ograniczenia to kolejne współrzędne wektora x*M dla x - wektora [v1,...,v7] odpowiadającego prawdopodobieństwu siedmiu różnych "ogólnych" permutacji oraz M - macierzy wypłat. Prawa strona ograniczeń to >= v0 dla v0 - funkcji wypłaty.

Wyniki (z dokładnością do permutacji, pozostałe z prawd. zero):
- (0,3,3) z prawdopodobieństwem 3/7;
- (1,1,4) z prawdopodobieństwem 3/7;
- (2,2,2) z prawdopodobieństwem 1/7.