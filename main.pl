/* Hentikan semua kegilaan ini */

/* This is command to start the game */
start :- g_read(started, X), X = 1, write('Game has already started'), nl, fail, !.
start :-
	g_read(started, X), X = 0, !,
	g_assign(started, 1),
	set_seed(50), randomize,
	repeat,
	write('Do you want to load save file or want to start from scratch?? (Press 1 for yes or 0 for no)'), 
	nl, write('> '),
	read(X), check_load(X),
	welcome,
	main_loop.

/* Main loop of the program */
main_loop :-
	repeat,
	write('Do something > '),
	read(Input),
	format('You said: ~w', [Input]), nl,
	call(Input), is_turn(Input),
	Input = quit, !.

/* Init everything when game started without load */
init_everything :-
	init_every_item,
	init_player.

/* Check if user want to load from save file */
check_load(0) :- init_everything, !.
check_load(1) :- !.

/* Check for command which not make a turn */
is_turn(info) :- !.
is_turn(save) :- !.
is_turn(status) :- !.
is_turn(look) :- !.
is_turn(X) :- 
	decrease_hunger(2),
	decrease_thirst(2).