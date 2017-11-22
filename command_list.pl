/* File untuk command */

/* When you attack */
attack :-
	player(X,Y,_,_,_,Weapon,_),
	weapon_atk(Weapon, WeaponAtk),
	enemy(_, X, Y, _, Atk),
	atk_enemy(X, Y, WeaponAtk, Atk), !.
attack :-
	fail_attack, fail.

atk_enemy(X, Y, WeaponAtk, EnemyAtk) :-
	enemy(EnemyID, X, Y, _, _),
	write('You see an enemy in your sight... You try attack him... '), nl,
	decrease_health(EnemyAtk),
	print_decrease_health(EnemyAtk),
	decrease_enemy_health(EnemyID, WeaponAtk),fail.
atk_enemy(_, _, _, _) :- !.

/* When enemy attack you */
enemy_attack :-
	player(X,Y,_,_,_,_,_),
	enemy_atk(X,Y).
enemy_atk(X,Y) :-
	enemy(_, X, Y, _, Atk),
	decrease_health(Atk), fail.
enemy_atk(_,_):-!.

has_started:- g_read(started,0), write('Game hasn\'t started yet!'),nl,!, fail.
has_started:- g_read(started,1),!.
help :- has_started,print_help.

/*MOVE*/
n :- has_started, step_up, print_move_north, !.
n :- fail_move, fail.
s :- has_started,step_down, print_move_south, !.
s :- fail_move, fail.
e :- has_started,step_right, print_move_east, !.
e :- fail_move, fail.
w :- has_started,step_left, print_move_west, !.
w :- fail_move, fail.

/*QUIT*/
quit :-
	has_started,
	write('Thank you for playing this game!'), nl,
	halt.

/*LOOK*/
look :-
	get_position(X,Y),!,
	print_player_loc(X, Y),
	print_items_loc(X, Y),
	/* The calculation for the map */
	NW_X is X-1, NW_Y is Y-1,
	N_X is X, N_Y is Y-1,
	NE_X is X+1, NE_Y is Y-1,
	W_X is X-1, W_Y is Y,
	C_X is X, C_Y is Y,
	E_X is X+1, E_Y is Y,
	SW_X is X-1, SW_Y is Y+1,
	S_X is X, S_Y is Y+1,
	SE_X is X+1, SE_Y is Y+1,nl,
	print_north(N_X,N_Y), print_south(S_X,S_Y),
	print_east(E_X,E_Y), print_west(W_X,W_Y),
	print_format(NW_X,NW_Y),!,
	print_format(N_X,N_Y),!,
	print_format(NE_X,NE_Y),!,nl,
	print_format(W_X,W_Y),!,
	print_format(C_X,C_Y),!,
	print_format(E_X,E_Y),!, nl,
	print_format(SW_X,SW_Y),!,
	print_format(S_X,S_Y),!,
	print_format(SE_X,SE_Y),!,nl.

/*DROP*/
drop(Object) :-
	get_position(X,Y),
	get_item_list(ItemList),
	member(Object,ItemList),
	del_item(Object),
	asserta(location(X,Y,Object)),
	format('You dropped ~w!',[Object]),nl,!.

drop(Object) :-
	format('You don\'t have ~w!',[Object]),nl.

/*PRINT MAP (ONLY RADAR)*/
map:- get_item_list(ItemList), member(radar,ItemList),print_map(-1,-1),!.
map:- write('You have to use radar to see the entire map!'),nl.

/*TAKE OBJECT*/
take(Object):-
	has_started, Object = radar, take_item(Object),
	write('Dude you\'re so lucky! You have picked the radar, the most useful thing in this game (maybe)!'),
	write(' I bet you\'re also very lucky in your tests!'), nl, !.
take(Object):-
	has_started, take_item(Object),
	format('You have picked ~w !',[Object]),nl,!.
take(_):-
	has_started,
	write('Really dude? Why did you pick item which is not exist in this map or in this game? Seriously...'),nl, fail.

take_item(Object):-
	has_started,
	player(X,Y,_,_,_,_,_),
	location(X,Y,Object),
	add_item(Object),
	retract(location(X,Y,Object)),!.

/*USE OBJECT*/
use(radar) :-
	write('Command map to use radar!'), nl, !.
use(foto_odi) :-
	player(_,_,_,_,_,_,ListItem),
	member(foto_odi, ListItem), !.
use(foto_fahmi) :-
	player(_,_,_,_,_,_,ListItem),
	member(foto_fahmi, ListItem), !.
use(Object) :-
	player(_,_,_,_,_,Weapon,ListItem),
	member(Object, ListItem),
	weapon_id(_,Object),
	del_item(Object),
	set_weapon(Object),
	add_item(Weapon),
	format('You switched your weapon to ~w !', [Object]), nl, !.
use(Object) :-
	player(_,_,_,_,_,_,ListItem),
	member(Object, ListItem),
	del_item(Object),
	effect(Object), nl, !.
use(_) :-
	write('Dude... You don\'t have that item in your inventory!'), nl.

effect(Object) :-
	type_item(Type, Object),
	give_effect(Type, Object).

give_effect(drink, Object) :-
	drink_rate(_, Object, Rate),
	increase_thirst(Rate),
	print_increase_thirst(Object,Rate).

give_effect(food, Object) :-
	food_rate(_, Object, Rate),
	increase_hunger(Rate),
	print_increase_hunger(Object,Rate).

give_effect(medicine, Object) :-
	medicine_rate(_, Object, Rate),
	increase_health(Rate),
	print_increase_health(Object,Rate).

/*PRINT STATUS*/
status :-
	has_started,
	print_status.

/*SAVE STATE*/
save:-
	write('Write the name of your file?'), nl,
	write('> '), read(File),
	atom_concat(File, '.txt', Filetxt),
	open(Filetxt, write, Stream),
	save_all_fact(Stream),
	close(Stream), 	write('Your file was saved !'), nl.

load :-
	write('Please input the file load!'), nl,
	write('>'), read(File),
	atom_concat(File, '.txt', Filetxt),
	load_all_fact(Filetxt).

load_all_fact(Filetxt):-
	retractall(enemy(_,_,_,_,_)), 
	retractall(player(_,_,_,_,_,_,_)), 
	retractall(location(_,_,_)),
	open(Filetxt, read, Stream),
	repeat,
		read(Stream, In),
		asserta(In),
	at_end_of_stream(Stream),
	close(Stream),
	write('Your File is loaded!'), nl, !.
load_all_fact(_):-
	write('Your input is wrong!'), nl, fail.

save_all_fact(Stream) :-
	save_location(Stream).
save_all_fact(Stream) :-
	save_player(Stream).
save_all_fact(Stream) :-
	save_enemies(Stream).
save_all_fact(_) :- !.

save_location(Stream) :-
	location(X,Y,Item),
	write(Stream, location(X,Y,Item)), write(Stream, '.'), nl(Stream),
	fail.

save_enemies(Stream) :-
 	enemy(EnemyID, X, Y, Health, Atk),
	write(Stream, enemy(EnemyID, X, Y, Health, Atk)), write(Stream, '.'), nl(Stream),
	fail.

save_player(Stream) :-
	player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
	write(Stream, player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)), write(Stream, '.'), nl(Stream),
	fail.

/*****BONUS*****/

/* Pray to God */
pray :-
	write('What is the code ?'), nl, write('>'),
	read(Ourcode), pray_answer(Ourcode).

pray_answer(aku_g4_b4s49) :-
	print_good_kid, print_give_radar, add_item(radar), !.
pray_answer(sem09A_M4pr3s) :-
	print_good_kid, print_give_ult_weapon, add_item(mapres), !.	
pray_answer(_) :-
	write('Your prayer is wrong!'), nl, fail.

	