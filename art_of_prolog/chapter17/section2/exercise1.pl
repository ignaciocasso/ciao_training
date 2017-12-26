:- module(_,_).

:- use_module(library(operators)).

:- op(800,xfx,[<-]).
:- op(800,xfy,[&&]).

rule(A,Bs) :- A <- Body, body(Body,Bs).

body((G&&Gs),[G|Bs]) :- !, body(Gs,Bs).
body(B,[B]).

rules(A,Bss) :- findall(Bs,rule(A,Bs),Bss).

solve([]).
solve([A|As]) :- solve(A), solve(As).
solve(A) :- rule(A,B), solve(B).


%17.2.i

number_successful_calls(Proc,Goal,N) :- number_successful_calls(Proc,Goal,0,N).

number_successful_calls(_,[],N,N).
number_successful_calls(_,true,N,N).
number_successful_calls(Proc, [A|As], Np, N) :- !, number_successful_calls(Proc,A,Np,N1), number_successful_calls(Proc, As, N1, N).
number_successful_calls(Proc,A,Np,N) :- A=..[Proc|_], !, N1 is Np+1, rule(A,B), number_successful_calls(Proc,B,N1,N).
number_successful_calls(Proc,A,Np,N) :- rule(A,B), number_successful_calls(Proc,B,Np,N).


number_calls(Proc,Goal,N) :- number_calls(Proc,Goal,N,success).

number_calls(_,true,0,success).
number_calls(Proc,A,N,R) :- A=..[Proc|_], !, rules(A,Bss), or(Proc,Bss,N1,failure,R), N is N1+1.
number_calls(Proc,A,N,R) :- rules(A,Bss), or(Proc,Bss,N,failure,R), write(hola), nl.

and(_,[],0,success,success).
and(_,_,0,failure,failure).
and(Proc,[A|As],N,success,R) :- number_calls(Proc,A,N1,Rp), and(Proc,As,N2,Rp,R), N is N1+N2.

or(_,_,0,success,success). %cleaner code with Rp
or(_,[],0,failure,failure).
or(Proc,[Bs|Bss],N,failure,R) :- and(Proc,Bs,N1,success,Rp), or(Proc,Bss,N2,Rp,R), N is N1+N2.



g([]) <- true.
g([_|Xs]) <- g(Xs).

p(_) <- g([_,_,_,_|null]).
p(X) <- g(X).


