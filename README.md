A game about revealing tiles and safely marking bombs based on revealed numbers that count the bombs nearby, and collecting AP checks when winning each board.

Controls:
- Left click - reveal currently closed tile, or reveal closed tiles around a revealed number, if the number has correct amount of marks around it
- Right click - mark a closed tile as a bomb
- Q - debug screen

Options:
- `*_color` settings accept a 6 or 3 digit hex value without a # at the start (or any other non-hex symbols), and change the color of specified part of the game
- `disable_periodic_updates` accepts "true", "t", "yes", "yeah", "ye", "y" or any non-0 number as truthy value, and "", "false", "f", "no", "nah", "nope", "nop", "n" or "0" as falsy; this disables every second data updates and turns that into a single update when you click on empty board
- `falling_pieces_count` accepts values 0 to 4 inclusive, controls how many pieces fall from each tile
- `falling_pieces_recursive` accepts truthy and falsy values, controls whether clicking a tile can cause nearby tiles to generate falling pieces
