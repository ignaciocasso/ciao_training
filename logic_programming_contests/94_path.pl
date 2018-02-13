% 6º problem of the first prolog programming contest (1994-Ithaca)

:- module(_,_).


path([Path]) :- find_path([s(1,1)],[],Path).

find_path([s(I,J)|PathP],_,Path) :- final(I,J), !, reverse([s(I,J)|PathP],Path).

find_path([s(I,J)|PathP],Visited,Path) :-
  next(I,J,I2,J2), valid(I2,J2,Visited), !,
  find_path([s(I2,J2),s(I,J)|PathP], [s(I2,J2)|Visited],Path).

% We want to keep the information of visited squares, so we can't use failure to guide the bactracking.
find_path([_|PathP],Visited,Path) :- find_path(PathP,Visited,Path).

valid(I,J,Visited) :- inside_board(I,J), \+ member(s(I,J),Visited).
inside_board(I,J) :- size(N), I>0, I=<N, J>0, J=<N.

final(I,J) :- goto(I,J,f).

next(I1,J1,I2,J2) :- goto(I1,J1,Dir), !, next5(I1,J1,Dir,I2,J2).
next(I1,J1,I2,J2) :- next5(I1,J1,_,I2,J2).
next5(I1,J1,u,I2,J1) :- I2 is I1+1.
next5(I1,J1,d,I2,J1) :- I2 is I1-1.
next5(I1,J1,r,I1,J2) :- J2 is J1+1.
next5(I1,J1,l,I1,J2) :- J2 is J1-1.

%%% input

size(3).

goto(1,1,u).
goto(2,1,r).
goto(2,3,u).
goto(3,3,f).

goto(1,2,r).
goto(1,3,r).
goto(3,2,l).
goto(3,1,r).