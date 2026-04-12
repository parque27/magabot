# Resultats

## Simplea
MSI:
Mètrica Valor
Longitud del pla 18 accions
Nodes expandits 20
Estats avaluats 71
Temps de planificació 562 ms

Domain parsed
Problem parsed
Grounding..
Grounding Time: 74
Aibr Preprocessing
|F|:98
|X|:0
|A|:944
|P|:0
|E|:0
H1 Setup Time (msec): 54
Setting horizon to:NaN
Running Greedy Best First Search
h(n = s_0)=27.0
 g(n)= 1.0 h(n)=22.0
 g(n)= 4.0 h(n)=21.0
 g(n)= 5.0 h(n)=20.0
 g(n)= 6.0 h(n)=18.0
 g(n)= 7.0 h(n)=17.0
 g(n)= 8.0 h(n)=16.0
 g(n)= 9.0 h(n)=15.0
 g(n)= 10.0 h(n)=12.0
 g(n)= 11.0 h(n)=9.0
 g(n)= 12.0 h(n)=6.0
 g(n)= 13.0 h(n)=4.0
 g(n)= 14.0 h(n)=3.0
 g(n)= 16.0 h(n)=2.0
 g(n)= 17.0 h(n)=1.0
 g(n)= 18.0 h(n)=0.0
Problem Solved

Found Plan:
0.0: (moure-robot r2 c55 c45)
1.0: (moure-robot r1 c61 c51)
2.0: (moure-robot r1 c51 c41)
3.0: (moure-robot r1 c41 c31)
4.0: (moure-robot r1 c31 c21)
5.0: (agafar-paquet-buit-estanteria-pila r1 c21 c22 pkg1 pkg2)
6.0: (moure-robot r1 c21 c31)
7.0: (moure-robot r1 c31 c41)
8.0: (moure-robot r1 c41 c51)
9.0: (moure-robot r1 c51 c52)
10.0: (moure-robot r1 c52 c53)
11.0: (moure-robot r1 c53 c54)
12.0: (dispensar-paquet-pila pkg1 pkg2 r1 c54 c44)
13.0: (dispensar-paquet-unic pkg2 r1 c54 c44)
14.0: (moure-robot r2 c45 c35)
15.0: (agafar-paquet-buit-estanteria-unitaria r2 c35 c25 pkg3)
16.0: (moure-robot r2 c35 c45)
17.0: (dispensar-paquet-unic pkg3 r2 c45 c44)

Plan-Length:18
Metric (Search):18.0
Planning Time (msec): 562
Heuristic Time (msec): 45
Search Time (msec): 94
Expanded Nodes:20
States Evaluated:71
Fixed constraint violations during search (zero-crossing):0
Number of Dead-Ends detected:0
Number of Duplicates detected:17

