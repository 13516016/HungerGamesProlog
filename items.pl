:- dynamic(location/3).
/* All weapon added */

/* Id of weapon */
weapon_id(6, nothing).
weapon_id(1, webtoon).
weapon_id(2, anime).
weapon_id(3, dota).
weapon_id(4, begadang).
weapon_id(5, osjur).

/* Attack of weapon */
weapon_atk(webtoon, 10).
weapon_atk(anime, 20).
weapon_atk(dota, 30).
weapon_atk(begadang, 50).
weapon_atk(osjur, 70).
weapon_atk(nothing, 0).

/* Id of food */
food_id(6, nothing).
food_id(1, nasi_korea).
food_id(2, nasi_jepang).
food_id(3, danusan).
food_id(4, geprek).
food_id(5, uncle_bro).

/* Food hunger rate */
food_rate(nasi_korea, 35).
food_rate(nasi_jepang, 40).
food_rate(danusan, 10).
food_rate(geprek, 50).
food_rate(uncle_bro, 20).
food_rate(nothing, 0).

/* Id of drink */
drink_id(6, nothing).
drink_id(1, aqua).
drink_id(2, go_milk).
drink_id(3, thai_tea).
drink_id(4, chocolate_changer).
drink_id(5, coffee).

/* drink thirst rate */
drink_rate(aqua, 20).
drink_rate(go_milk, 30).
drink_rate(thai_tea, 40).
drink_rate(chocolate_changer, 25).
drink_rate(coffee, 50).
drink_rate(nothing, 0).

/* Initialize map with everything */

init_everything :-
	init_all_weapon, init_all_drink, init_all_food, !.

/* Initialize map with weapons */

init_all_weapon :-
	init_weapon(30), init_weapon_forge(5).

init_weapon(0) :- !.
init_weapon(N) :-
	random_weapon,
	M is N -1,
	init_weapon(M).

init_weapon_forge(0) :- !.
init_weapon_forge(N) :-
	random_weapon_forge, M is N-1, init_weapon_forge(M).

random_weapon :-
	repeat,
	random(1, 6, S), weapon_id(S, A),
	random(1, 11, X), random(1, 21, Y),
	grid(X, Y, Loc),
	Loc \== blank,
	asserta(location(X, Y, A)).

random_weapon_forge :-
	random(1, 6, N), weapon_id(N, A),
	random(7, 10, X), random(17, 20, Y),
	asserta(location(X, Y, A)).

/* Initialize map with drink */

init_all_drink :-
	init_drink(10).

init_drink(0) :- !.
init_drink(N) :- random_drink, M is N -1, init_drink(M).

random_drink :-
	repeat,
	random(1, 6, N), drink_id(N, A),
	random(1, 11, X), random(1, 21, Y),
	grid(X, Y, Loc),
	Loc \== blank,
	asserta(location(X, Y, A)).

/* Initialize map with food */

init_all_food :-
	init_food(30).

init_food(0) :- !.
init_food(N) :- random_food, M is N -1, init_food(M).

random_food :-
	repeat,
	random(1, 6, N), food_id(N, A),
	random(1, 11, X), random(1, 21, Y),
	grid(X, Y, Loc),
	Loc \== blank,
	asserta(location(X, Y, A)).
