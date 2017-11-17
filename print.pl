print_logo :- write('/////'),nl.

print_start :-
  write('Welcome to the BLABLABLABLA '),nl,
  write('You have been chosen balbalabla'),nl.

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

print_help :-
  write('--------------------------------COMMAND LIST--------------------------------'),nl,
  nl,
  print_command_list.

print_medicine:-
  write('  M  ').
print_food:-
  write('  F  ').
print_water:-
  write('  W  ').
print_weapon:-
  write('  #  ').
print_player:-
  write('  P  ').
print_enemy:-
  write('  E  ').
print_accessible:-
  write('  -  ').
print_inaccessible:-
  write('  X  ').

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

print_start_help :-
  write('---------------------------AVAILABLE COMMANDS---------------------------'),nl,
  nl,
  write('-- start.                  | '),write('Start the game. '),nl,
  print_command_list.

print_status :-
  get_health(Health),
  get_hunger(Hunger),
  get_thirst(Thirst),
  get_weapon(Weapon),
  get_position(X,Y),
  get_item_list(Items),
  write('Health     : '), write(Health), nl,
  write('Hunger     : '), write(Health), nl,
  write('Thirst     : '), write(Thirst), nl,
  write('Weapon     : '), write(Weapon), nl,
  write('Position   : '), format('(~d,~d) ',[X,Y]), nl,
  nl,
  write('Items').
  % print_items(Items).
