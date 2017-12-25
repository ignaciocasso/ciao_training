:- module(_,[split/3]).

%%%%%%%%%%%%%%%%%%%%%%%%% SPLIT %%%%%%%%%%%%%%%%%%%%%%%%%

split(String,Char,Pieces) :- split_dl(String,Char,Pieces,[]).

split_dl(String,Char,[FirstPiece|Pieces],Tail) :- split5(String,Char,FirstPiece,Pieces,Tail), !.

split5([],_,[],Pieces,Pieces).
split5([Char|Chars],Char,[],[NextPiece|Pieces],Tail) :- split5(Chars,Char,NextPiece,Pieces,Tail).
split5([Char|Chars],C,[Char|CurrentPiece],Pieces,Tail) :- split5(Chars,C,CurrentPiece,Pieces,Tail).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%