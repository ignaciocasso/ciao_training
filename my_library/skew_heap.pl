:- module(_,_,[hiord]).

:- meta_predicate create_heap(pred(2),?).
:- meta_predicate create_heap(?,pred(2),?).

%create_skew_heap(F,Heap): Heap is an empty skew heap that uses F as a comparison function(the top of the heap M is such that
%F(M,X) holds for all M in the heap. F is assumed to be a total order

create_heap(F, skew_heap(null,F)).
create_heap(Elems,F,Heap) :- create_heap(F,Heap1), fill(Heap1,Elems,Heap).

fill(Heap,[Elem|Elems],FilledHeap) :- insert(Heap,Elem,Heap1), fill(Heap1,Elems,FilledHeap).
fill(Heap,[],Heap).

insert(skew_heap(OldTree,F),Elem,skew_heap(NewTree,F)) :-
    merge(OldTree, binary_tree(Elem,null,null), F, NewTree).

delete_max(skew_heap(OldTree,F), skew_heap(NewTree,F)) :-
    left_child(OldTree,L), right_child(OldTree,R),
    merge(L,R,F,NewTree).

peek_max(skew_heap(Tree,_),Max) :- value(Tree,Max).

merge(null,Tree,_,Tree) :- !.
merge(Tree,null,_,Tree) :- !.
merge(Tree1,Tree2,F,Tree3) :-
    value(Tree1,V1), value(Tree2,V2),
    call(F,V1,V2), !,
    merge2(Tree1,Tree2,F,Tree3).
merge(Tree1,Tree2,F,Tree3) :-
    merge2(Tree2,Tree1,F,Tree3).
    
merge2(Tree1,Tree2,F,Tree3) :-
    value(Tree1,V1), value(Tree3,V1),
    left_child(Tree1,L1), right_child(Tree3,L1),
    right_child(Tree1,R1), merge(Tree2,R1,F,L3), left_child(Tree3,L3).


left_child(binary_tree(_,Node,_),Node).
right_child(binary_tree(_,_,Node),Node).
value(binary_tree(Value,_,_),Value).