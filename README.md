A game about revealing tiles and safely marking bombs based on revealed numbers that count the bombs nearby, and collecting AP checks when winning each board.

DO NOT USE ArchipelagoChecksFinderClient !!! Connection to it was removed, all it now does is muck the save folder needlessly!

Controls (connection window):
- Tab, Down Arrow - move down
- Shift+Tab, Up Arrow - move up
- Left Click - Switch to the input you are hovering over, or click the button
- Enter - submit the connection info and connect
- Ctrl+V - paste your clipboard at the end of selected text input

Controls (main game):
- Left click - reveal currently closed tile, or reveal closed tiles around a revealed number, if the number has correct amount of marks around it
- Right click - mark a closed tile as a bomb
- Q - debug screen

Options:
- `*_color` settings accept a 6 or 3 digit hex value without a # at the start (or any other non-hex symbols), and change the color of specified part of the game
- `falling_pieces_count` accepts values 0 to 4 inclusive, controls how many pieces fall from each tile
- `falling_pieces_recursive` accepts "true", "t", "yes", "yeah", "ye", "y" or any non-0 number as truthy value, and "", "false", "f", "no", "nah", "nope", "nop", "n" or "0" as falsy; controls whether clicking a tile can cause nearby tiles to generate falling pieces
