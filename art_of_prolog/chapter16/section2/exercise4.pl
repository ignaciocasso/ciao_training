
mst(Solution) :-
    findall(X,vertice(X),Vertices),
    select(VerticeInicial,Vertices,VerticesLeft),
    mst([VerticeInicial],VerticesLeft,[],Solution).

%mst(vertices already in the tree, vertices not in the tree, partial solution, solution)
mst(_,[],Solution,Solution).
mst(Connected,NotConnected,Sp,Solution) :-
    findall(edge(X,Y,C),(member(X,Connected),member(Y,NotConnected),connected(X,Y,C)),Edges),
    minimum(Edges,edge(X,Y,C)),
    select(Y,NotConnected,NotConnected1),
    mst([Y|Connected],NotConnected1,[edge(X,Y,C)|Sp],Solution).
 
minimum([edge(X,Y,C)|Edges], Edge) :- minimum(Edges,edge(X,Y,C),Edge).
minimum([],Edge,Edge).
minimum([edge(X1,Y1,C1)|Edges],edge(X,Y,C),Edge) :- C =< C1, !, minimum(Edges,edge(X,Y,C),Edge).
minimum([edge(X1,Y1,C1)|Edges],edge(X,Y,C),Edge) :- C > C1, !, minimum(Edges,edge(X1,Y1,C1),Edge).

connected(X,Y,C) :- graph_edge(X,Y,C).
connected(X,Y,C) :- graph_edge(Y,X,C).

graph_edge(v1,v2,10).
graph_edge(v1,v5,6).
graph_edge(v2,v3,7).
graph_edge(v2,v4,6).
graph_edge(v2,v5,8).
graph_edge(v3,v4,9).
graph_edge(v3,v5,2).

vertice(v1).
vertice(v2).
vertice(v3).
vertice(v4).
vertice(v5).
