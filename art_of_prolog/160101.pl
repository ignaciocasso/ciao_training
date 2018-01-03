
intersect(Xs,Ys,Zs) :- findall(Z,(member(Z,Xs),member(Z,Ys)),Zs).