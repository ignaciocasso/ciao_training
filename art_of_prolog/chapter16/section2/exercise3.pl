rotate(Xs,Ys) :- split(Xs,A,[],Ys,A).

split([X|Xs],As,As,[X|Bs],TailB) :- dl(Xs,Bs,TailB).
split([X|Xs],[X|As],TailA,Bs,TailB) :- split(Xs,As,TailA,Bs,TailB).

dl([],DL,DL).
dl([X|Xs],[X|DL],Tail) :- dl(Xs,DL,Tail).

