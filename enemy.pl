:- dynamic(enemy/5).
/* Enemy(EnemyID, EnemyX, EnemyY, EnemyHealth, EnemyAtk) */


init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).

generate_enemy(EnemyID) :-
	repeat,
	random(1, 11, X), random(1, 21, Y),
	random(20, 45, Health), random(5, 12, Atk),
	grid(X, Y, Loc), 
	Loc \== blank,
	asserta(EnemyID, X, Y, Health, Atk).

% Health
decrease_health(Amount):-
	retract(enemy(EnemyID, X, Y, Health, Atk)),
	ResultHealth is Health-Amount,
	asserta(enemy(EnemyID, X, Y, ResultHealth, Atk)).

% Position
get_position(X,Y):-
	enemy(_,X,Y,_,_).

set_position(X,Y):-
	retract(enemy(EnemyID, CurrentX, CurrentY, Health, Atk)),	
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

random_move:-
	random(1, 4, X),
	X = 1, step_up, !,
	X = 2, step_down, !,
	X = 3, step_left, !,
	X = 4, step_right, !.

step_up:-
	enemy(EnemyID, X, CurrentY, Health, Atk),
	CurrentY > 0,
	retract(enemy(EnemyID, X, CurrentY, Health, Atk)),
	Y is CurrentY-1,
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_down:-
	enemy(EnemyID, X, CurrentY, Health, Atk),
	CurrentY < 20,
	retract(enemy(EnemyID, X, CurrentY, Health, Atk)),
	Y is CurrentY+1,
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_left:-
	enemy(EnemyID, X, CurrentY, Health, Atk),
	CurrentX > 0,
	retract(enemy(EnemyID, CurrentX, Y, Health, Atk)),
	X is CurrentX-1,
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_right:-
	enemy(EnemyID, CurrentX, Y, Health, Atk),
	CurrentX < 10,
	retract(enemy(EnemyID, CurrentX, Y, Health, Atk)),
	X is CurrentX+1,
	asserta(enemy(EnemyID, X, Y, Health, Atk)).
