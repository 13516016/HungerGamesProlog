
/*print map*/
print_map(11,20):- !.
print_map(11,Y):-
  Y2 is Y+1,nl,
  print_map(-1,Y2),!.
print_map(X,Y):-
  Y= -1, X2 is X+1 ,print_border,!,
  print_map(X2,Y).
print_map(X,Y):-
  Y=20,X2 is X+1, print_border,!,
  print_map(X2,Y).
print_map(X,Y):-
  X= -1,X2 is X+1, print_border,!,
  print_map(X2,Y).
print_map(X,Y):-
  X=10,X2 is X+1, print_border,!,
  print_map(X2,Y).
print_map(X,Y):-
  X2 is X+1, print_format(X,Y),!,
  print_map(X2,Y).

/*print format*/
print_format(X,Y):-
  player(X,Y,_,_,_,_,_),
  print_player.
print_format(X,Y):-
  enemy(_,X,Y,_,_),
  print_enemy.
print_format(X,Y):-
  location(X,Y,Item),
  weapon_id(_,Item),
  print_weapon.
print_format(X,Y):-
  location(X,Y,Item),
  type_item(medicine,Item),
  print_medicine.
print_format(X,Y):-
  location(X,Y,Item),
  type_item(food,Item),
  print_food.
print_format(X,Y):-
  location(X,Y,Item),
  type_item(drink,Item),
  print_water.
print_format(X,Y):-print_accessible.


print_logo :- write('/////'),nl.

welcome :-
  write('Welcome to the ITB\'s Hunger Games!!'), nl,
  write('You have been chosen as our students here... '), nl,
  write('So.. Please gradute from here with your best shot and try not to dropout from here~\n'), nl,
  print_start_help,
  nl.

/* This is for the command list for the start */
print_start_help :-
  write('---------------------------AVAILABLE COMMANDS---------------------------'),nl,
  nl,
  write('-- start.                  | '),write('Start the game. '),nl,
  print_command_list.

/* This is for the command list when user input help */
print_help :-
  write('--------------------------------COMMAND LIST--------------------------------'),nl,
  nl,
  print_command_list.

/* All the commands avaliable right now */
print_command_list :-
  write('-- help.                   | '), write('Show available commands.'),nl,
  write('-- quit.                   | '), write('Quit the game.'),nl,
  write('-- look.                   | '), write('Look around you.'),nl,
  write('-- n.                      | '), write('Move north.'),nl,
  write('-- s.                      | '), write('Move south.'),nl,
  write('-- e.                      | '), write('Move east.'),nl,
  write('-- w.                      | '), write('Move west.'),nl,
  write('-- map.                    | '), write('Look at the map (needs RADAR).'),nl,
  write('-- take(Object).           | '), write('Pick up an object.'),nl,
  write('-- drop(Object).           | '), write('Drop an object from the inventory.'),nl,
  write('-- use(Object).            | '), write('Use an object from the inventory.'),nl,
  write('-- attack.                 | '), write('Attack enemy.'),nl,
  write('-- status.                 | '), write('Show your status.'),nl,
  write('-- save(Filename).         | '), write('Save the game with the given file name.'),nl,
  write('-- load(Filename).         | '), write('Load the game from the given file name.'),nl.

/* this is to print legend in game */
print_legend :-
  write('---------LEGENDS---------'),nl,
  nl,
  print_medicine, write(' : Medicine'),nl,
  print_food, write(' : Food'),nl,
  print_water, write(' : Water'),nl,
  print_weapon, write(' : Weapon'),nl,
  print_player, write(' : Player'),nl,
  print_enemy, write(' : Enemy'),nl,
  print_accessible, write(' : Accessible'),nl,
  print_inaccessible, write(' : Inaccessible'),nl.

/*print map elements*/
print_border:- write('~~~~~').
print_medicine:- write('  M  ').
print_food:- write('  F  ').
print_water:- write('  W  ').
print_weapon:- write('  #  ').
print_player:- write('  P  ').
print_enemy:- write('  E  ').
print_accessible:- write('  -  ').
print_inaccessible:- write('  X  ').

/* to clear screen of terminal */
clear_screen:-nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

/* print status of the user */
print_status :-
  get_health(Health),
  get_hunger(Hunger),
  get_thirst(Thirst),
  get_weapon(Weapon),
  get_position(X,Y),
  get_item_list(Items),
  write('Health     : '), write(Health), nl,
  write('Hunger     : '), write(Hunger), nl,
  write('Thirst     : '), write(Thirst), nl,
  write('Weapon     : '), write(Weapon), nl,
  write('Position   : '), format('(~d,~d) ',[X,Y]), nl,
  nl,
  write('Items'),nl,
  write(Items).
