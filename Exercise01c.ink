/*
This is a comment block. It won't be read as an Ink story.
Comments are very useful for leaving ideas for story and functionalty

This exercise will demonstrate the following in the example video:
 - Variable types: integer, float, boolean
 - Variable assignment
 - Printing variables
 - Variable checking
 
 In the assignment:
 - Add four more knots
 - Assign at least TWO new variables through player choices
 - Print at least one of the variables to the player in a passage
 - Check the value of a variable and have it do something
*/

VAR energy = 10
VAR treasure_collected = 0

-> cave_mouth

== cave_mouth ==
You are at the entrance to a cave. {not torch_pickup:There is a torch on the floor.} The cave extends to the east and west. 

+ [Take the east tunnel] -> east_tunnel
+ [Take the west tunnel] -> west_tunnel
* [Pick up the torch] -> torch_pickup

== east_tunnel ==
You are in the east tunnel. It is very dark, and you can't see anything.
* {torch_pickup} [Light Torch] -> east_tunnel_lit
+ [Go Back] -> cave_mouth
-> END

== west_tunnel ==
You are in the west tunnel. It is very dark, and you can't see anything.
* {torch_pickup} [Light Torch] -> west_tunnel_lit
+ [Go Back] -> cave_mouth
-> END

== west_tunnel_lit ==
You are in the west tunnel. It is damp and smells faintly of mold. You have {treasure_collected} coins in your backpack.
* [Search for treasure] 
    ~ treasure_collected += 20
    ~ energy -= 2
 -> west_treasure_room
+ [Go Back] -> cave_mouth
-> END

== west_treasure_room ==
You are in a small room. In front of your is a chest with a lock. It seems you can spend 100 coins to open it. You have {treasure_collected} coins in your backpack. ({treasure_collected < 100: You don't have enough coins to open the chest, find them in other places.})
* {treasure_collected >= 100 && energy >= 2} [Open the chest]
    ~ treasure_collected -= 100
    ~ energy -= 2
    -> chest
* {energy < 5} [Rest to regain energy] 
    ~ energy = 10
+ [Go Back] -> cave_mouth

== chest ==
Oh, the chest is empty! 
+ [Go Back] -> cave_mouth
-> END

== east_tunnel_lit ==
The light of your torch glints off piles of gold coins scattered across the ground. You have {treasure_collected} coins in your backpack.
* [Collect some treasure] 
    ~ treasure_collected += 50
    ~ energy -= 2
 -> treasure_room
+ [Go Back] -> cave_mouth
-> END

== treasure_room ==
You are in a small treasure room. You now have {treasure_collected} coins and {energy} energy left.
* {energy >= 5} [Explore further into the tunnel] -> hidden_passage
* {energy < 5} [Rest to regain energy] 
    ~ energy += 3
 -> treasure_room
+ [Go Back] -> cave_mouth
-> END

== hidden_passage ==
You discover a narrow hidden passage leading to another chamber. The passage is difficult to navigate, costing you energy.
~ energy -= 3
You arrive in a strange room where the walls glimmer with light reflecting off more treasure.
* [Take some treasure] 
    ~ treasure_collected += 100
 -> final_chamber
+ [Go Back] -> treasure_room
-> END

== final_chamber ==
You find an ancient artifact in the final chamber. It grants you immense power and refills your energy to full.
~ energy = 10
You now possess {treasure_collected} coins and feel fully rejuvenated.
* [Leave the cave victorious] -> END
+ [Go Back to explore more tunnels] -> cave_mouth
-> END

=== torch_pickup ===
You now have a torch. May it light the way.
* [Go Back] -> cave_mouth
-> END

