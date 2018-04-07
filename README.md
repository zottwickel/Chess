# Chess
A fully-functional game of chess, complete with save games and unicode chess pieces.

# Setup
This chess app runs best in the terminal with the following font: Monospace Regular (Size:21 (or between 18 and 24)). Otherwise pieces may overlap, or the size will be too small. Monospace Regular is more important than font size.

To change this in ubuntu terminals open a new terminal and follow the path:
Edit > Profile Preferences > General(tab) > Custom Font(checkbox and selector) > Monospace Regular (with size box 21) > close
...or make a new profile with the font at that size.

# Gameplay
To launch go to the chess directory in a terminal and if you have ruby installed type "ruby lib/chess.rb"

In order to make a move in game you have to input the coordinates of your starting piece, and the coordinates of the destination in letter-number format. An example would be to move a pawn forward you would type the starting coordinates "e2", then the destination coordinates "e3". The whole string should  look like "e2e3" with no spaces.
In order to castle put "O-O" for right side castle and "O-O-O" for left side castle
In order to save and quit type "SAVE"
In order to quit without saving type "QUIT"
