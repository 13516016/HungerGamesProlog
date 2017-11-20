:- dynamic(player/7).

default_health(100).
default_hunger(20).
default_thirst(50).
default_weapon(nothing).
default_item_list([]).

random_location(X, Y) :-
    repeat,
    random(1, 11, A), random(1, 21, B),
    grid(A, B, Loc),
    Loc \== blank,
    X is A, Y is B.

init_player:-
    default_health(Health),
    default_hunger(Hunger),
    default_thirst(Thirst),
    default_weapon(Weapon),
    default_item_list(ItemList),
    random_location(X,Y),
    % FYI, assert buat masukin ke database
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)), !.

% Health
increase_health(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultHealth is Health+Amount,
    ResultHealth > 100,
    write('You use it... But because your healt now pass the max amount of health, so we only set your health to max amount~'), nl,
    write('(Well this game is balance and btw the max amount of health is 100!)'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,100,Hunger,Thirst,Weapon,ItemList)).
increase_health(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultHealth is Health+Amount,
    write('As you use it... You feel the power of the medicine.. You\'re now feel very strong!!!'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,ResultHealth,Hunger,Thirst,Weapon,ItemList)).

decrease_health(Amount):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    ResultHealth is Health-Amount,
    asserta(player(X,Y,ResultHealth,Hunger,Thirst,Weapon,ItemList)).

get_health(Health):-
    player(_,_,Health,_,_,_,_).

% Hunger
increase_hunger(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultHunger is Hunger+Amount,
    ResultHunger > 50,
    write('You eat it... But because your hunger now pass the max amount of hunger, so we only set your hunger to max amount~'), nl,
    write('(Well this game is balance and btw the max amount of hunger is 50!)'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,50,Thirst,Weapon,ItemList)), !.
increase_hunger(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultHunger is Hunger+Amount,
    write('As you eat it... You feel the power of the food.. It\'s so delicious!!'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,ResultHunger,Thirst,Weapon,ItemList)).

decrease_hunger(Amount):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    ResultHunger is Hunger-Amount,
    asserta(player(X,Y,Health,ResultHunger,Thirst,Weapon,ItemList)).

get_hunger(Hunger):-
    player(_,_,_,Hunger,_,_,_).

% Thirst
increase_thirst(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultThirst is Thirst+Amount,
    ResultThirst > 50,
    write('You drink it... But because your thirst now pass the max amount of thirst, so we only set your thirst to max amount~'), nl,
    write('(Well this game is balance and btw the max amount of thirst is 50!)'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,50,Weapon,ItemList)), !.
increase_thirst(Amount):-
    player(X,Y,Health,Hunger,Thirst,Weapon,ItemList),
    ResultThirst is Thirst+Amount,
    write('As you drink it... You feel the power of the drink.. You do\'nt feel thristy anymore.. Good for you!'), nl,
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,ResultThirst,Weapon,ItemList)).

decrease_thirst(Amount):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    ResultThirst is Thirst-Amount,
    asserta(player(X,Y,Health,Hunger,ResultThirst,Weapon,ItemList)).

get_thirst(Thirst):-
    player(_,_,_,_,Thirst,_,_).

% Weapon
set_weapon(Weapon):-
    retract(player(X,Y,Health,Hunger,Thirst,CurrentWeapon,ItemList)),
    asserta(location(X, Y, CurrentWeapon)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)).

get_weapon(Weapon):-
    player(_,_,_,_,_,Weapon,_).

% Item List
add_item(Item):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    append([Item],ItemList,NewItemList),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewItemList)).

del_item(Item):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    delete_one(Item,ItemList,NewItemList),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewItemList)).

/* Command for delete one item */
delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail) :- !.
delete_one(Term, [Head|Tail], [Head|Result]) :-
    delete_one(Term, Tail, Result).

get_item_list(ItemList):-
    player(_,_,_,_,_,_,ItemList).

% Position
get_position(X,Y):-
    player(X,Y,_,_,_,_,_).

set_position(X,Y):-
    retract(player(CurrentX,CurrentY,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewItemList)).

step_up:-
    player(X,CurrentY,Health,Hunger,Thirst,Weapon,ItemList),
    CurrentY > 0,
    Y is CurrentY-1,
    grid(X, Y, Loc), Loc \== blank,
    retract(player(X,CurrentY,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)).
    
step_down:-
    player(X,CurrentY,Health,Hunger,Thirst,Weapon,ItemList),
    CurrentY < 19,
    Y is CurrentY+1,
    grid(X, Y, Loc), Loc \== blank,
    retract(player(X,CurrentY,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)).

step_left:-
    player(CurrentX,Y,Health,Hunger,Thirst,Weapon,ItemList),
    CurrentX > 0,
    X is CurrentX-1,
    grid(X, Y, Loc), Loc \== blank,
    retract(player(CurrentX,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)).

step_right:-
    player(CurrentX,Y,Health,Hunger,Thirst,Weapon,ItemList),
    CurrentX < 9,
    X is CurrentX+1,
    grid(X, Y, Loc), Loc \== blank,
    retract(player(CurrentX,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)).

