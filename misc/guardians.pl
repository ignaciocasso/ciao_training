%%  Prison guards are playing a game. The Nth guard turns the key in every
 %%  Nth cell door, either unlocking or locking the door. A simulated run
 %%  with five guards and five cells would appear thus:
 %% 
 %%  1) Cells 1 2 3 4 5 unlocked
 %%  2) Cells 1 3 5 unlocked
 %%  3) Cells 1 5 unlocked
 %%  4) Cells 1 4 5 unlocked
 %%  5) Cells 1 4 unlocked
 %%  etc...
 %% 
 %%  At the end of the 'game', the program must return a list of unlocked
 %%  Cells, given N Guards and M Cells. 
 %% 
 %%  The jail should be represented as a list of pairs, ordered by cell
 %%  number, in the form [State, Cell], where State is either locked or
 %%  unlocked. To construct an ordered list, Jail, of cells, the relation 
 %%  make_cells(Cells,Start,State,Jail) should be used. 


guardians(N,M,Unlocked) :-
  make_jail(M,Jail),
  rounds(N,Jail,Jail2),
  unlocked(Jail2,Unlocked),
  !.

make_jail(M,Jail) :- make_jail(M,[],Jail).
make_jail(0,Jail,Jail).
make_jail(M,JailP,Jail) :- M1 is M-1, make_jail(M1,[cell(locked,M)|JailP],Jail).

rounds(0,Jail,Jail).
rounds(N,Jail,Jail2) :- N1 is N-1, rounds(N1,Jail,Jail1), round(N,Jail1,Jail2).

round(N,Jail1,Jail2) :- round(N,1,Jail1,Jail2).
round(_,_,[],[]).
round(N,N,[Cell|Cells],[Cell2|Cells2]) :- turn_key(Cell,Cell2), round(N,1,Cells,Cells2).
round(N,M,[Cell|Cells1],[Cell|Cells2]) :- M1 is M+1, round(N,M1,Cells1,Cells2).

turn_key(cell(locked,N),cell(unlocked,N)).
turn_key(cell(unlocked,N),cell(locked,N)).

unlocked([],[]).
unlocked([cell(unlocked,N)|Jail],[N|Unlocked]) :- unlocked(Jail,Unlocked).
unlocked([cell(locked,_)|Jail],Unlocked) :- unlocked(Jail,Unlocked).