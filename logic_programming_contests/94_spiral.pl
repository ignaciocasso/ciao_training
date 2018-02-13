% 2º problem of the first logic programming contest (1994-Ithaca).

:- module(_,[spiral/2]). 

% Probably not the most straightforward way to do it, neither the most declarative, but I wanted to experiment with cyclic terms


% To solve the problem we build a fully linked matrix, fill it with the numbers and print it.

spiral(A,B) :- set_prolog_flag(check_cycles,on), % Needed to allow cyclic terms. Still doesn't allow to print them using 'write'
   matrix(M,A,B), K is A*B, fill_matrix(M,1,K,right), write_matrix(M).

% our matrix is made up of nodes (each cell of the matrix) with references to the nodes right, left, above and below
% A matrix is represented by its upper left node. The limits of the matrix are free_variables.
% m(value,left,right,up,down)

left(m(_,Sq,_,_,_),Sq).
right(m(_,_,Sq,_,_),Sq).
up(m(_,_,_,Sq,_),Sq).
down(m(_,_,_,_,Sq),Sq).
value(m(V,_,_,_,_),V).
cell(m(_,_,_,_,_)).

% creates a fully linked matrix of size (N,M) and returns its upper-left cell.
matrix(Mat,N,M) :- N1 is N-1, M1 is M-1, matrix5(Mat,0,0,N1,M1), !.

% creates the cell (i,j) of the matrix, (0<=i<=N, 0<=j<=M)
matrix5(Mat,I,J,N,M) :-
    right(Mat,R), left(Mat,L), up(Mat,U), down(Mat,D),
    % If its adyacent nodes are all instantiated, this node is already visited and matrix5 success (in the next clause, this one fails).
    (var(R),J<M ; var(L),J>0 ; var(U),I>0 ; var(D),I<N),
    % links the nodes of the matrix
    (J=0 ; right(L,Mat), down(L,DL), up(L,UL)),
    (J=M ; left(R,Mat), down(R,DR), up(R,UR)),
    (I=0 ; down(U,Mat), left(U,UL), right(U,UR)),
    (I=N ; up(D,Mat), left(D,DL), right(D,DR)),
    Jl is J-1, Jr is J+1, Iu is I-1, Id is I+1,
    % creates the adyacent nodes (some of them will already be initialized and linked, but in that case matrix5 success without recursion.
    (J=0 ; matrix5(L,I,Jl,N,M)),
    (J=M ; matrix5(R,I,Jr,N,M)),
    (I=0 ; matrix5(U,Iu,J,N,M)),
    (I=N ; matrix5(D,Id,J,N,M)).
    
matrix5(Mat,_,_,_,_) :- cell(Mat).



% fills the matrix in a direction until it fails because that cell is already ground and filled with a different number
% or because it's out of the matrix (the cell a free variable), and then turns on backtracking.

fill_matrix(_,_,0,_) :- !.
fill_matrix(free_var,_,_,_) :- !, fail.
fill_matrix(M,K,N,Dir) :-
  value(M,K), K1 is K+1, N1 is N-1,
  next(M,Dir,M1,Dir1),
  fill_matrix(M1,K1,N1,Dir1).

next(M,left,M1,left) :- left(M,M1).
next(M,right,M1,right) :- right(M,M1).
next(M,up,M1,up) :- up(M,M1).
next(M,down,M1,down) :- down(M,M1).
next(M,Dir,M1,Dir1) :- next_dir(Dir,Dir2), next(M,Dir2,M1,Dir1).

next_dir(right,down).
next_dir(down,left).
next_dir(left,up).
next_dir(up,right).


% Writes the matrix (not in the required format, but who cares).

write_matrix(free_var) :- !.
write_matrix(M) :-
   write_row(M),
   down(M,M1),
   write_matrix(M1).

write_row(free_var) :- nl,!.

write_row(M) :-
    value(M,V), write(V), write('   '),
    right(M,M1), write_row(M1).