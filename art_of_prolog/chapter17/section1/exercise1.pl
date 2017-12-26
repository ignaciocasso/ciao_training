

ndfa(Xs) :- initial(State), ndfa(State,Xs).
ndfa(State,[]) :- final(State).
ndfa(State,[X|Xs]) :- delta(State,X,NewState), ndfa(NewState,Xs).

eps_ndfa(Xs) :- initial(State), eps_ndfa(State,Xs).
eps_ndfa(State,[]) :- final(State).
eps_ndfa(State,Xs) :- eps(State,NewState), eps_ndfa(NewState,Xs).
eps_ndfa(State,[X|Xs]) :- delta(State,X,NewState), eps_ndfa(NewState,Xs).

initial(q0).
delta(q0,a,q1).

%eps(q1,q3).  delta(q3,c,q2).
delta(q1,c,q2).

delta(q1,b,q1).
final(q2).