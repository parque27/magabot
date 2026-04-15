PS C:\Users\pauar\Documents\Universitat\IA\PDDL\magabot> java -jar enhsp-20.jar -o domain.pddl -f pb_simplea.pddl -planner sat-hadd
Domain parsed
Problem parsed
Grounding..
Grounding Time: 38
Aibr Preprocessing
|F|:98
|X|:0
|A|:944
|P|:0
|E|:0
H1 Setup Time (msec): 43
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
Planning Time (msec): 336
Heuristic Time (msec): 25
Search Time (msec): 47
Expanded Nodes:20
States Evaluated:71
Fixed constraint violations during search (zero-crossing):0
Number of Dead-Ends detected:0
Number of Duplicates detected:17
PS C:\Users\pauar\Documents\Universitat\IA\PDDL\magabot> java -jar enhsp-20.jar -o domain.pddl -f pb_simplea.pddl -planner opt-hadd
! ====== ! Warning: Unknown planner configuration. Going with default: gbfs with hadd ! ====== !
Domain parsed
Problem parsed
Grounding..
Grounding Time: 38
Aibr Preprocessing
|F|:98
|X|:0
|A|:944
|P|:0
|E|:0
H1 Setup Time (msec): 33
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
Planning Time (msec): 327
Heuristic Time (msec): 26
Search Time (msec): 51
Expanded Nodes:20
States Evaluated:71
Fixed constraint violations during search (zero-crossing):0
Number of Dead-Ends detected:0
Number of Duplicates detected:17
PS C:\Users\pauar\Documents\Universitat\IA\PDDL\magabot> java -jar enhsp-20.jar -o domain.pddl -f pb_simplea.pddl -planner opt-hmax
Domain parsed
Problem parsed
Grounding..
Grounding Time: 40
Aibr Preprocessing
|F|:98
|X|:0
|A|:944
|P|:0
|E|:0
H1 Setup Time (msec): 31
Setting horizon to:NaN
Running WA-STAR
h(n = s_0)=7.0
f(n) = 7.0 (Expanded Nodes: 0, Evaluated States: 0, Time: 0.006) Frontier Size: 0
f(n) = 8.0 (Expanded Nodes: 3, Evaluated States: 13, Time: 0.03) Frontier Size: 10
f(n) = 9.0 (Expanded Nodes: 12, Evaluated States: 28, Time: 0.041) Frontier Size: 16
f(n) = 10.0 (Expanded Nodes: 21, Evaluated States: 41, Time: 0.048) Frontier Size: 20
f(n) = 11.0 (Expanded Nodes: 34, Evaluated States: 57, Time: 0.054) Frontier Size: 23
f(n) = 12.0 (Expanded Nodes: 47, Evaluated States: 78, Time: 0.059) Frontier Size: 31
f(n) = 13.0 (Expanded Nodes: 73, Evaluated States: 145, Time: 0.076) Frontier Size: 72
f(n) = 14.0 (Expanded Nodes: 146, Evaluated States: 317, Time: 0.105) Frontier Size: 170
f(n) = 15.0 (Expanded Nodes: 318, Evaluated States: 667, Time: 0.155) Frontier Size: 344
f(n) = 16.0 (Expanded Nodes: 618, Evaluated States: 1284, Time: 0.208) Frontier Size: 650
f(n) = 17.0 (Expanded Nodes: 1132, Evaluated States: 2453, Time: 0.299) Frontier Size: 1283
f(n) = 18.0 (Expanded Nodes: 2146, Evaluated States: 4962, Time: 0.486) Frontier Size: 2715
Problem Solved

Found Plan:
0.0: (moure-robot r1 c61 c51)
1.0: (moure-robot r1 c51 c41)
2.0: (moure-robot r1 c41 c31)
3.0: (moure-robot r1 c31 c21)
4.0: (agafar-paquet-buit-estanteria-unitaria r1 c21 c22 pkg1)
5.0: (moure-robot r1 c21 c31)
6.0: (moure-robot r1 c31 c41)
7.0: (moure-robot r1 c41 c51)
8.0: (moure-robot r1 c51 c52)
9.0: (moure-robot r2 c55 c45)
10.0: (moure-robot r1 c52 c53)
11.0: (moure-robot r2 c45 c35)
12.0: (moure-robot r1 c53 c54)
13.0: (agafar-paquet-buit-estanteria-unitaria r2 c35 c25 pkg3)
14.0: (moure-robot r2 c35 c45)
15.0: (dispensar-paquet-pila pkg1 pkg2 r1 c54 c44)
16.0: (dispensar-paquet-unic pkg2 r1 c54 c44)
17.0: (dispensar-paquet-unic pkg3 r2 c45 c44)

Plan-Length:18
Metric (Search):18.0
Planning Time (msec): 776
Heuristic Time (msec): 419
Search Time (msec): 486
Expanded Nodes:2148
States Evaluated:4966
Fixed constraint violations during search (zero-crossing):0
Number of Dead-Ends detected:99
Number of Duplicates detected:6999
PS C:\Users\pauar\Documents\Universitat\IA\PDDL\magabot> java -jar enhsp-20.jar -o domain.pddl -f pb_simplea.pddl -planner sat-hmax
! ====== ! Warning: Unknown planner configuration. Going with default: gbfs with hadd ! ====== !
Domain parsed
Problem parsed
Grounding..
Grounding Time: 37
Aibr Preprocessing
|F|:98
|X|:0
|A|:944
|P|:0
|E|:0
H1 Setup Time (msec): 33
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
Planning Time (msec): 332
Heuristic Time (msec): 28
Search Time (msec): 54
Expanded Nodes:20
States Evaluated:71
Fixed constraint violations during search (zero-crossing):0
Number of Dead-Ends detected:0
Number of Duplicates detected:17