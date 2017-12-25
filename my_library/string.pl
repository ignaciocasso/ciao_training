:- module(_,[split/3,parse_integer/2]).

:- use_module('utilities').


split(String,Char,Pieces) :- utilities:split(String,Char,Pieces1), delete(Pieces1,[],Pieces).

%%%%%%%%%%%%%%%%%%%%%%%%  PARSE INT %%%%%%%%%%%%%%%%%%%%%%%%%

parse_integer('0',0).
parse_integer(['-'|String],N) :- !, parse_natural(String,0,N1), N1\=0, N is -N1.
parse_integer(String,N) :- parse_natural(String,0,N), N\=0.
parse_natural([Char|String],Np,N) :- digit(Char,Digit), Np1 is Np*10+Digit, parse_natural(String,Np1,N).
parse_natural([],N,N).


digit('0',0).
digit('1',1).
digit('2',2).
digit('3',3).
digit('4',4).
digit('5',5).
digit('6',6).
digit('7',7).
digit('8',8).
digit('9',9).
