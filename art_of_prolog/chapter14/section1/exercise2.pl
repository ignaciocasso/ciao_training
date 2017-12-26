
preferences(avraham, [chana, tamar, zvia, ruth, sarah]).
preferences(binyamin, [zvia, chana, ruth, sarah, tamar]).
preferences(chaim, [chana, ruth, tamar, sarah, zvia]).
preferences(david, [zvia, ruth, chana, sarah, tamar]).
preferences(elazar, [tamar, ruth, chana, zvia, sarah]).
preferences(zvia, [elazar, avraham, david, binyamin, chaim]).
preferences(chana, [david, elazar, binyamin, avraham, chaim]).
preferences(ruth, [avraham, david, binyamin, chaim, elazar]).
preferences(sarah, [chaim, binyamin, david, avraham, elazar]).
preferences(tamar, [david, binyamin, chaim, elazar, avraham]).

stable_marriages(Men, Women, Marriages) :- generate(Men,Women,Marriages), test(Marriages).

generate([],[],[]).
generate([Man|MenLeft],Women,[marriage(Man,Woman)|Marriages]) :-
    select(Woman,Women,WomenLeft),
    generate(MenLeft,WomenLeft,Marriages).

test(Marriages) :- unstable(Marriages), !, fail.
test(_).

unstable(Marriages) :-
    select_pair(Marriage1,Marriage2,Marriages),
    unstable(Marriage1,Marriage2).

select_pair(X,Y,[X|Zs]) :- member(Y,Zs).
select_pair(X,Y,[_|Zs]) :- select_pair(X,Y,Zs).

unstable(marriage(X1,Y1), marriage(X2,Y2)) :- prefers(X1,Y2,Y1), prefers(Y2,X1,X2).
unstable(marriage(X1,Y1), marriage(X2,Y2)) :- prefers(Y1,X2,X1), prefers(X2,Y1,Y2).


prefers(X,Y,Z) :- preferences(X,Ps), before(Ps,Y,Z).
before([Y|_],Y,_) :- !.
before([Z|_],_,Z) :- !, fail.
before([_|Xs],Y,Z) :- before(Xs,Y,Z).

