attack :-
	player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
	weapon_atk(Weapon, Atk).


has_started:- g_read(started,0), write('Game hasn\'t started yet!'),nl,!.

has_started:-
	g_read(started,1),!.

help :- has_started,print_help.

n :- has_started,step_up, !.
n :- write('You can\'t move!'), nl.
s :- has_started,step_down, !.
s :- write('You can\'t move!'), nl.
e :- has_started,step_right, !.
e :- write('You can\'t move!'), nl.
w :- has_started,step_left, !.
w :- write('You can\'t move!'), nl.


quit :- 
	write('Thank you for playing!'), nl, 
	halt.

/*look*/
look :-
	get_position(X,Y),!,
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

map:- get_item_list(ItemList), print_map(-1,-1).

take(Object):-has_started,
	take_item(Object),
	format('You have picked ~w !',[Object]),nl,!.

take(Object):-has_started,
	write('You can\'t take that item!'),nl,fail.

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

use(Object) :-
	player(_,_,_,_,_,_,ListItem),
	member(Object, ListItem),
	del_item(Object),
	format('You just used ~w', [Object]), nl,
	effect(Object),!.

use(Object) :-
	write('You don\'t have that item in your inventory !'), nl.

effect(Object) :-
	type_item(Type, Object),
	give_effect(Type, Object).

give_effect(drink, Object) :-
	drink_rate(_, Object, Rate),
	increase_thirst(Rate).

give_effect(food, Object) :-
	food_rate(_, Object, Rate),
	increase_hunger(Rate).

use(Object) :-
	player(_,_,_,_,_,_,ListItem),
	member(Object, ListItem),
	del_item(Object),
	format('You just used ~w', [Object]), nl,
	effect(Object).
use(Object) :-
	write('You don\'t have that item in your inventory !'), nl.

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

status :-
	has_started,
	print_status.
