
%% Problem:
%% Write the prolog code for the water jugs problem:
%% There are two jugs, one holding 3 and the other 5 gallons of water.
%% A number of things can be done with the jugs:  they can be filled,
%% emptied, and dumped one into the other either until the poured-into
%% jug is full or until the poured-out-of jug is empty.  Devise a
%% sequence of actions that will produce 4 gallons of water in the larger
%% jug. Note that only integer values of water will be used.

jugs_problem(Xs) :- list(Xs), jugs(0,0,_,4,Xs).

jugs(N,M,N,M,[]).
jugs(N1,M1,N2,M2,[Move|Moves]) :-
  valid_move(N1,M1,N3,M3,Move),
  jugs(N3,M3,N2,M2,Moves).

%se podria guardar una lista de estados visitados para mejorar la eficiencia,
%pero no voy a hacerlo. list(Xs) asegura la terminacion por mucho que se repitan los
%estados, aunque por otro lado lo hace aun mas ineficiente


valid_move(N1,M,3,M,fill_little) :- N1\=3.
valid_move(N1,M,0,M,empty_little) :- N1\=0.
valid_move(N,M1,N,5,fill_big) :- M1\=5.
valid_move(N,M1,N,0,empty_big) :- M1\=0.
valid_move(N1,M1,N2,M2,little_to_big) :- M1\=5, N1\=0, K is 5-M1, N1>=K, N2 is N1-K, M2 is 5.
valid_move(N1,M1,N2,M2,little_to_big) :- M1\=5, N1\=0, K is 5-M1, N1<K, N2 is 0, M2 is M1+N1.
valid_move(N1,M1,N2,M2,big_to_little) :- N1\=3, M1\=0, K is 3-N1, M1>=K, M2 is M1-K, N2 is 3.
valid_move(N1,M1,N2,M2,big_to_little) :- N1\=3, M1\=0, K is 3-N1, M1<K, M2 is 0, N2 is N1+M1.
