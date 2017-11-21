/* map.pl */

/* This is the map for the game*/
grid(X, Y, Building) :- X > -1, X < 2, Y > 11, Y =< 19, Building = kantin_borju, !.
grid(X, Y, Building) :- X > -1, X < 4, Y > -1, Y =< 3, Building = kandom, !.
grid(X, Y, Building) :- X >= 4, X =< 7, Y >= 0, Y =< 3, Building = intel, !.
grid(X, Y, Building) :- X >= 8, X =< 9, Y >= 0, Y =< 12, Building = ruang_rektor, !.
grid(X, Y, Building) :- X >= 0, X =< 1, Y >= 4, Y =< 11, Building = labtek_v, !.
grid(X, Y, Building) :- X >= 2, X =< 6, Y >= 7, Y =< 15, Building = ruang_ujian, !.
grid(X, Y, Building) :- X >= 3, X =< 5, Y >= 18, Y =< 19, Building = sadikin, !.
grid(X, Y, Building) :- X >= 7, X =< 9, Y >= 17, Y =< 19, Building = perpustakaan, !.
grid(X, Y, Building) :- X is 3, Y is 19, Building = sacred_path, !.
grid(X, Y, Building) :- X is 7, Y is 7, Building = secret_path, !.
grid(X, Y, Building) :- Building = blank.
