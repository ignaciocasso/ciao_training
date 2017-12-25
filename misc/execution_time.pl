main(N) :-
  generate_list(N,Ns),
  statistics(runtime, _),
  naive_reverse(Ns,Ms),
  statistics(runtime, [_,Time1]),
  write('Execution time naive reverse: '),
  write(Time1),
  write(' milliseconds'),
  nl,
  statistics(runtime, _),
  reverse(Ns,Ms),
  statistics(runtime, [_,Time2]),
  write('Execution time efficient reverse: '),
  write(Time2),
  write(' milliseconds'),
  nl.

generate_list(0,[]).
generate_list(N,[N|Ns]) :- N>0, N1 is N-1, generate_list(N1,Ns).

naive_reverse([],[]).
naive_reverse([X|Xs],Ys) :- naive_reverse(Xs,Zs), append(Zs,[X],Ys).