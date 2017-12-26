
%tape(X,Left,Right)

turing(Xs) :- list(Xs), tm(Xs), not_blanks(Xs).

not_blanks([X|Xs]) :- X\=blank, not_blanks(Xs). %not_blanks and list are needed for generation
not_blanks([]).

tm(Xs) :- initial(Q), tm(Q,tape(blank,[],Xs)).
tm(State,_) :- final(State), !.
tm(State,Tape) :-
    symbol(Tape,X),
    delta(State,X,NewState,NewX,Move),
    move_tape(Tape,NewX,Move,NewTape),
    tm(NewState,NewTape).

symbol(tape(X,_,_),X).

move_tape(tape(_,Ls,[]),Y,right,tape(blank,[Y|Ls],[])).
move_tape(tape(_,Ls,[R|Rs]),Y,right,tape(R,[Y|Ls],Rs)).
move_tape(tape(_,[],Rs),Y,left,tape(blank,[],[Y|Rs])).
move_tape(tape(_,[L|Ls],Rs),Y,left,tape(L,Ls,[Y|Rs])).

%anbncn
%q2 skip chain of as to the right.

initial(q0).
delta(q0,blank,q1,start,right).%we mark the beginning

delta(q1,b,q2,b,right).
delta(q1,a,q1,a,right). %we check that the input has asbscs structure
delta(q2,c,q3,c,right).
delta(q2,b,q2,b,right).
delta(q3,blank,q4,end,left).
delta(q3,c,q3,c,right).

delta(q4,start,q5,start,right) :- !. %back to the beginning
delta(q4,X,q4,X,left).

delta(q5,end,qf,end,right). %we delete one a, one b, one c
delta(q5,blank,q5,blank,right).
delta(q5,a,q6,blank,right).
delta(q6,a,q6,a,right).
delta(q6,blank,q6,blank,right).
delta(q6,b,q7,blank,right).
delta(q7,b,q7,b,right).
delta(q7,blank,q7,blank,right).
delta(q7,c,q8,blank,right).
delta(q8,c,q8,c,right).
delta(q8,end,q4,end,left).

final(qf).