/* File untuk command */

/* When you attack */
attack :-
	player(X,Y,_,_,_,Weapon,_),
	weapon_atk(Weapon, WeaponAtk),
	enemy(_, X, Y, _, Atk),
	atk_enemy(X, Y, WeaponAtk, Atk), !.
attack :-
	write('There\'s no enemy in your sight !'), nl, fail.

atk_enemy(X, Y, WeaponAtk, EnemyAtk) :-
	enemy(EnemyID, X, Y, _, _),
	write('You see an enemy in your sight... You try attack him... '), nl,
	decrease_enemy_health(EnemyID, WeaponAtk),
	write('But you also got hit from your enemy... Urgh it\'s hurt!'), nl,
	decrease_health(EnemyAtk), fail.
atk_enemy(_, _, _, _) :- !.

/* When enemy attack you */
enemy_attack :-
	player(X,Y,_,_,_,_,_),
	enemy_atk(X,Y).
enemy_atk(X,Y) :-
	enemy(_, X, Y, _, Atk),
	decrease_health(Atk), nl, fail.

has_started:- g_read(started,0), write('Game hasn\'t started yet!'),nl,!, fail.
has_started:- g_read(started,1),!.
help :- has_started,print_help.

/*MOVE*/
n :- has_started,step_up, !.
n :- fail_move, fail.
s :- has_started,step_down, !.
s :- fail_move, fail.
e :- has_started,step_right, !.
e :- fail_move, fail.
w :- has_started,step_left, !.
w :- fail_move, fail.

/*QUIT*/
quit :-
	has_started,
	write('Thank you for playing this game!'), nl,
	halt.

/*LOOK*/
look :-
	get_position(X,Y),!,
	grid(X, Y, Loc),
	print_loc(Loc),
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
	SE_X is X+1, SE_Y is Y+1,
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
take(Object):-has_started,
	Object = radar,
	take_item(Object),
	write('Dude you\'re so lucky! You have picked the radar, the most useful thing in this game (maybe)!'),
	write(' I bet you\'s also very lucky in your tests!'), nl, !.
take(Object):-has_started,
	take_item(Object),
	format('You have picked ~w !',[Object]),nl,!.
take(_):-has_started,
	write('Really dude? Why did you pick item which is not exist in this map or in this game? Seriously...'),nl,fail.

take_item(Object):-
	has_started,
	weapon_id(_,Object),
	player(X,Y,_,_,_,_,_),
	location(X,Y,Object),
	set_weapon(Object),
	retract(location(X,Y,Object)),!.
take_item(Object):-
	has_started,
	player(X,Y,_,_,_,_,_),
	location(X,Y,Object),
	add_item(Object),
	retract(location(X,Y,Object)),!.

/*USE OBJECT*/
use(Object) :-
	player(_,_,_,_,_,_,ListItem),
	member(Object, ListItem),
	del_item(Object),
	format('You just used ~w', [Object]), nl, !.
use(_) :-
	write('Dude... You don\'t have that item in your inventory!'), nl.

effect(Object) :-
	type_item(Type, Object),
	give_effect(Type, Object).

give_effect(drink, Object) :-
	drink_rate(_, Object, Rate),
	increase_thirst(Rate).

give_effect(food, Object) :-
	food_rate(_, Object, Rate),
	increase_hunger(Rate).

give_effect(medicine, Object) :-
	medicine_rate(_, Object, Rate),
	increase_health(Rate).


/*PRINT STATUS*/
status :-
	has_started,
	print_status.


/*SAVE STATE*/
save(Filename):-

	open(Filename,write,Stream),
	write(Stream,),
	close(Stream).
