Znalezienie najkrótszej drogi w problemie obieżyświata. 

Wyniki w postaci: wartość 1 dla przebycia danej drogi i 0 w pozostałych przypadkach.
Drogi są zakodowane w wektorze y licząc od dróg z Bloomington do pozostałych 5 miast (y[1] - y[5]), Champaign do pozostałych 4 miast (y[6] - y[9] bez drogi do Bloomington, jako że zauważamy przemienność grafu), itd. aż do ostatniej drogi z Peorii do Springfield (komórka y[15]).
Wartość wektora x[i] odpowiada decyzji przejścia wyłącznie jednej drogi z/do i-tego miasta (zatem jest równoważne rozpoczęciu/zakończeniu podróży w tymże i-tym mieście). 

wektor y - {1: 0.0, 2: 0.0, 3: 0.0, 4: 1.0, 5: 1.0, 6: 1.0, 7: 1.0, 8: 0.0, 9: 0.0, 10: 0.0, 11: 0.0, 12: 0.0, 13: 0.0, 14: 1.0, 15: 0.0}
wektor x - {1: 0.0, 2: 0.0, 3: 1.0, 4: 0.0, 5: 1.0, 6: 0.0}
