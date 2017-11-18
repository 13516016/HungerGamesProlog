/* Hentikan semua kegilaan ini */

start :-
	g_read(started, X), X = 0, !,
	welcome,
	g_assign(started, 1),
	main_loop.

start :- g_read(started, X), X = 1, write('Game has already started'), nl.

main_loop :-
	repeat,
	write('Say something > '),
	read(X),
	format('You said: ~w', [X]), nl,
	call(X),
	X = quit, !.

welcome :-
	write('Welcome to the ITB\'s Hunger Games!!'), nl,
	write('You have been chosen as our students here... '), nl,
	write('So.. Please gradute from here with your best shot and try not to dropout from here~\n'),
	print_start_help,
	nl.

quit :- g_assign(started, 0), write('Thanks for playing!'), nl.
