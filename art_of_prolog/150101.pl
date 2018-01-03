reverse_flatten(Xs,Ys) :- flatten_dl(Xs,Ys,[]).

flatten_dl([X|Xs],Ys,Zs) :- flatten_dl(Xs,Ys,Ys1), flatten_dl(X,Ys1,Zs).
flatten_dl(X,[X|Xs],Xs) :- num(X).
flatten_dl([],Xs,Xs).