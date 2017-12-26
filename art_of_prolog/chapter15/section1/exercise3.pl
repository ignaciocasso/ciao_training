
:- dynamic hanoi_dl/6.

hanoi(N,A,B,C,Moves) :- hanoi_dl(N,A,B,C,Moves,[]).

hanoi_dl(1,A,B,C,[move(A,B)|Tail],Tail).
hanoi_dl(N,A,B,C,Moves,Tail) :-
    N>1,
    N1 is N-1,
    lemma(hanoi_dl(N1,A,C,B,Moves,Tail1)),
    hanoi_dl(N1,C,B,A,Ms2,Tail),
    Tail1=[move(A,B)|Ms2].

lemma(P) :- P, asserta((P:-!)).

test_hanoi(N,Pegs,Moves) :- hanoi(N,A,B,C,Moves), Pegs=[A,B,C].