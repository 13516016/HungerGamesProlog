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
	welcome_info,
	main_loop.

/* Main loop of the program */
main_loop :-
	repeat,
	set_seed(50), randomize,
	write('\nDo something > '),
	read(Input),
	is_input(Input),
	call(Input), 
	is_turn(Input),
	is_finished(Input), !.

/* Init everything when game started without load */
init_everything :-
	init_every_item,
	init_player,
	init_enemy(10).

/* Check if user want to load from save file */
check_load(0) :- init_everything, !.
check_load(1) :- !.

/* Check if input is valid */
% is_input(listing) :-
% 	nl, write('Yo dude don\'t cheat..\n'), nl, !, fail.
is_input(_).

/* Check for command which not make a turn */
is_turn(save) :- !.
is_turn(status) :- !.
is_turn(look) :- !.
is_turn(listing) :- !.
is_turn(_) :-
	check_enemy_same,
	enemy_attack, 
	decrease_hunger(2),
	decrease_thirst(2), !.
is_turn(_) :-
	generate_random_move(10), 
	decrease_hunger(2),
	decrease_thirst(2), !.
is_turn(_) :- !.

/* check if the game is finished */
is_finished(Input) :-
	Input = quit, !.
is_finished(_) :-
	get_health(Health),
	Health =< 0,
	write('You\'re dead!'), nl, !.
is_finished(_) :-
	get_hunger(Hunger),
	Hunger =< 0,
	write('You\'re dead!'), nl, !.
is_finished(_) :-
	get_thirst(Thirst),
	Thirst =< 0,
	write('You\'re dead!'), nl, !.