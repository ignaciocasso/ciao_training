:- module(_,_).

:- use_module('lib/input_output').
:- use_module('lib/skew_heap').

main :- end_of_input.
main :- read_case(NumberScores,NumberInstruments,Musicians), compute_case(NumberScores,NumberInstruments,Musicians), main.

read_case(N,M,Ms) :-
    read_integer(N),
    read_integer(M),
    read_integers(M,Ms).
read_integers(0,[]).
read_integers(M,[N|Ns]) :-
    read_integer(N),
    M1 is M-1,
    read_integers(M1,Ns).

compute_case(N,M,Ms) :-
    scores(Ms,Scores),
    create_heap(Scores,comp,Heap),
    K is N-M,
    loop(K,Heap,Sol),
    write(Sol), nl.

scores([],[]).
scores([M|Ms],[score(M,1,M)|Scores]) :- scores(Ms,Scores).

comp(score(_,_,N1), score(_,_,N2)) :- N1 >= N2.

loop(0,Heap,Sol) :- peek_max(Heap,score(_,_,Sol)).
loop(K,Heap,Sol) :-
    K1 is K-1,
    get_max(Heap,score(M,S,_),Heap1),
    S1 is S+1, div(M,S1,MS),
    insert(Heap1,score(M,S1,MS),Heap2),
    loop(K1,Heap2,Sol).

div(X,Y,Z) :- Z is X//Y, X is Z*Y, !.
div(X,Y,Z) :- Z is (X//Y)+1.

get_max(Heap1,Max,Heap2) :- peek_max(Heap1,Max), delete_max(Heap1,Heap2).