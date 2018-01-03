
npda(Xs) :- initial(Q), npda(Q,[],Xs).
npda(State,[],[]) :- final(State).
npda(State,Stack,[X|Xs]) :- delta(State,Stack,X,NewState,NewStack), npda(NewState,NewStack,Xs).

initial(q0).
final(q0).
delta(q0,[],a,q2,[a]).
delta(q0,[],a,q1,[a]).
delta(q1,[a|Stack],b,q2,Stack).
delta(q1,Stack,a,q1,[a|Stack]).
delta(q2,[a|Stack],b,q2,Stack).
delta(q2,[a|Stack],b,q3,Stack).
final(q3).

eps_npda(Xs) :- initial(Q), eps_npda(Q,[],Xs).
eps_npda(State,[],[]) :- final(State).
eps_npda(State,Stack,Xs) :- eps(State,Stack,NewState,NewStack), eps_npda(NewState,NewStack,Xs).
eps_npda(State,Stack,[X|Xs]) :- delta(State,Stack,X,NewState,NewStack), eps_npda(NewState,NewStack,Xs).

/*
initial(q0).
eps(q0,[],q1,[]).
delta(q1,Stack,a,q1,[z|Stack]).
eps(q1,Stack,q2,Stack).
delta(q2,[z|Stack],b,q2,Stack).
eps(q2,[],q3,[]).
final(q3).
*/