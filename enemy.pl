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
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

% Health
decrease_enemy_health(EnemyID, Amount):-
 	retract(enemy(EnemyID, X, Y, Health, Atk)),
 	ResultHealth is Health-Amount,
 	ResultHealth > 0, 
	asserta(enemy(EnemyID, X, Y, ResultHealth, Atk)).

% Position
get_enemy_position(EnemyID, X, Y):-
	enemy(EnemyID, X, Y, _, _).

/* Generate all random move for enemy */
 
generate_random_move(0) :- !.
generate_random_move(N) :- random_move(N), M is N-1, generate_random_move(M).

 /* Make random move for an enemy until enemy can move*/
random_move(EnemyID) :-
	random(1, 5, X),
	select_step(EnemyID, X).

/* This his how the enemy move */
select_step(EnemyID, 1) :-
	step_e_up(EnemyID), !.
select_step(EnemyID, 2) :-
	step_e_down(EnemyID), !.
select_step(EnemyID, 3) :-
	step_e_left(EnemyID), !.
select_step(EnemyID, 4) :-
	step_e_right(EnemyID), !.

step_e_up(EnemyID):-
	enemy(EnemyID, X, CurrentY, Health, Atk),
	CurrentY > 0,
	Y is CurrentY-1,
	grid(X, Y, Loc), Loc \== blank,
	retract(enemy(EnemyID, X, CurrentY, Health, Atk)),
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_e_down(EnemyID):-
	enemy(EnemyID, X, CurrentY, Health, Atk),
	CurrentY < 20,
	Y is CurrentY+1,
	grid(X, Y, Loc), Loc \== blank,
	retract(enemy(EnemyID, X, CurrentY, Health, Atk)),
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_e_left(EnemyID):-
	enemy(EnemyID, CurrentX, Y, Health, Atk),
	CurrentX > 0,
	X is CurrentX-1,
	grid(X, Y, Loc), Loc \== blank,
	retract(enemy(EnemyID, CurrentX, Y, Health, Atk)),
	asserta(enemy(EnemyID, X, Y, Health, Atk)).

step_e_right(EnemyID):-
	enemy(EnemyID, CurrentX, Y, Health, Atk),
	CurrentX < 10,
	X is CurrentX+1,
	grid(X, Y, Loc), Loc \== blank,
	retract(enemy(EnemyID, CurrentX, Y, Health, Atk)),
	asserta(enemy(EnemyID, X, Y, Health, Atk)).
