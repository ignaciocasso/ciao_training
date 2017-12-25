:- module(_,_). %[main/0]).

:- use_module('lib/input_output').
:- use_module('lib/string').


main :- end_of_input.
main :- read_line(Line), caso(Line), main.

caso(Line) :-
    numbers(Line,Ns),
    (matrioshka(Ns) -> write(':-) Matrioshka!') ; write(':-( Try again.')),
    nl.

numbers(Line,Ns) :- split(Line,' ',Numbers), parse(Numbers,Ns).
parse([],[]).
parse([Number|Numbers],[N|Ns]) :- parse_integer(Number,N), parse(Numbers,Ns).

matrioshka(Ns) :- matrioshka(Ns,[],[10000000]).

matrioshka([N|Ns],[N|MatrioshkaStack],[_|RoomLeftStack]) :- matrioshka(Ns,MatrioshkaStack,RoomLeftStack).
matrioshka([N|Ns],MatrioshkaStack,[RoomLeft|RoomLeftStack]) :- 
    N<0, N1 is -N,
    RoomLeft1 is RoomLeft-N1, RoomLeft1>0,
    matrioshka(Ns,[N1|MatrioshkaStack],[N1,RoomLeft1|RoomLeftStack]).
matrioshka([],[],[_]).