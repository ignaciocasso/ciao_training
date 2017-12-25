:- module(_,_).%[read_line/1,read_line_dl/2,read_integer/1,read_integer/3,end_of_input/0]).


%This module assumes sometimes that there is a newline before the end of stream


%%%%%%%%%%%%%%%%%%%%%%%%% READ LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%read_line: succeds only once, leaves the stream mark right after the newline character

read_line(Line) :- read_line_dl(Line,[]). %line as a normal list

read_line_dl(Line,Tail) :- get_code(Code), read_line3(Code,Line,Tail).
read_line3(-1,Tail,Tail) :- !.  %Maybe it should fail here?
read_line3(10,Tail,Tail) :- !.
read_line3(Code,[Char|Line],Tail) :- char_code(Char,Code), get_code(Code2), read_line3(Code2,Line,Tail).

%%%%%%%%%%%%%%%%%%%%%%%%  READ INTEGER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%read_integer: succeds only once, fails if there is no number or an input error
%occurs, reads the next character after the integer (whether it succeeds or fails)

read_integer(N) :- remove_blanks(Char), read_integer2(Char,N).
read_integer2('0',0) :- !.
read_integer2('-',N) :- !, get_char(Char), read_natural(Char,0,N1), N is -N1.
read_integer2(Char,N) :- read_natural(Char,0,N).
read_natural(Char,Np,N) :- 
    digit(Char,Digit), !, Np1 is Np*10+Digit,
    get_char(NextChar), read_natural(NextChar,Np1,N).
read_natural(_,N,N) :- N\=0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

read_structure(int,X) :- !, read_integer(X).

read_structure(list(_,0),[]) :- !.
read_structure(list(Format,N),[X|Xs]) :- !,
    N > 0,
    read_structure(Format,X),
    N1 is N-1,
    read_structure(list(Format,N1),Xs).

read_structure(format(param(FormatParam,Param),Format),X) :- !,
    copy_term(s(Param,Format),s(CopyParam,CopyFormat)),
    read_structure(FormatParam,CopyParam),
    read_structure(CopyFormat,X). %Format usa la variable Param

read_structure(Format,Structure) :-
    Format=..[F|Formats],
    read_args(Formats,Args),
    Structure=..[F|Args].

read_args([],[]).
read_args([Format|Formats],[Arg|Args]) :- read_structure(Format,Arg), read_args(Formats,Args).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


end_of_input :- peek_code(-1).

remove_blanks(Char) :- get_code(Code), (code_class(Code,0) -> remove_blanks(Char) ; char_code(Char,Code)).