:- dynamic(enemy/5).

generate_enemy :-
	asserta(enemy(1, 1, 1, 10, 10)),
	asserta(enemy(2, 1, 1, 10, 11)),
	asserta(enemy(3, 1, 1, 10, 11)).

enemy_atk(X,Y) :-
	enemy(EnemyID, X, Y, Health, Atk),
	write(EnemyID), nl, fail.

enemy_atk(X,Y) :-
	write('Enemy just atk you!'), nl.
