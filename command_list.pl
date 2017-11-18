% attack :-

has_started:- g_read(started,0), write('Game hasn\'t started yet!'),nl,!.

has_started:-
	g_read(started,1),!.

help :- has_started,print_help.

n :- has_started,step_up.
s :- has_started,step_down.
e :- has_started,step_right.
w :- has_started,step_left.

quit :- halt.

% look :-

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
	add_item(Object),!.

% use(Object) :-

status :-
	has_started,
	print_status.
