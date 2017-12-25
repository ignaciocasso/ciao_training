
:- module(_,_).

:- use_module('lib/input_output').

main :- read_integer(NumberCases), test_cases(NumberCases).

test_cases(0).
test_cases(N) :- N > 0, test_case, N1 is N-1, test_cases(N1).

test_case :- 
    read_case(DyingTree,Trees,Doctors,RadioTree,RadioDoctor),  
    compute_case(DyingTree,Trees,Doctors,RadioTree,RadioDoctor,Result),
    print(Result).

read_case(DyingTree,Trees,Doctors,RadioTree,RadioDoctor) :-
    read_structure(s(int,int,int,int),s(NumberTrees,NumberDoctors,RadioTree,RadioDoctor)),
    read_structure(list(point(int,int),NumberDoctors),Doctors),
    tree_format(TreeFormat),
    read_structure(list(TreeFormat,NumberTrees),[DyingTree|Trees]).
tree_format(format(param(int,NumberBranches), list(point(int,int),NumberBranches))).

print(doctor_reached) :- write('Tree can be saved :)'), nl.
print(doctor_not_reached) :- write('Tree can\'t be saved :('), nl.


compute_case(DyingTree_,Trees_,Doctors_,RadioTree,RadioDoctor,Result) :-
    initialize_components([DyingTree_|Trees_],[DyingTree|Trees]),
    initialize_components(Doctors_,Doctors),
    connect_trees([DyingTree|Trees],RadioTree),
    connect_doctors(Doctors,[DyingTree|Trees],RadioDoctor),
    (member(Doctor,Doctors), same_connected_component(DyingTree,Doctor)
        -> Result=doctor_reached
        ; Result=doctor_not_reached
    ).

initialize_components([],[]).
initialize_components([X|Xs],[comp(X,NewComponent)|Components]) :-
    initialize_components(Xs,Components).

connect_trees([],_).
connect_trees([Tree|Trees],K) :-
    connect_tree(Tree,Trees,K),
    connect_trees(Trees,K).

connect_tree(_,[],_).
connect_tree(Tree,[OtherTree|Trees],K) :- connect(Tree,OtherTree,K), connect_tree(Tree,Trees,K).

connect_doctors([],_,_).
connect_doctors([Doctor|Doctors],Trees,D) :-
    connect_doctor(Doctor,Trees,D),
    connect_doctors(Doctors,Trees,D).

connect_doctor(_,[],_).
connect_doctor(Doctor,[Tree|Trees],D) :-
    connect(Doctor,Tree,D),
    connect_doctor(Doctor,Trees,D).

connect(comp(X,Component),comp(Y,Component),Radio) :- connected(X,Y,Radio).
connect(_,_,_).

connected(Tree1,Tree2,K) :-
    member(Branch1,Tree1), member(Branch2,Tree2),
    distance(Branch1,Branch2,R), R=<K.

connected(Doctor,Tree,D) :- member(Branch,Tree), distance(Doctor,Branch,R), R=<D.

distance(point(X1,Y1),point(X2,Y2),D) :-
    R is (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2),
    D is sqrt(R).


same_connected_component(comp(_,X),comp(_,Y)) :- X==Y.
