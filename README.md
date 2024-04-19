A game about revealing tiles and safely marking bombs based on revealed numbers that count the bombs nearby, and collecting AP checks when winning each board.

Controls:
- Left click - reveal currently closed tile, or reveal closed tiles around a revealed number, if the number has correct amount of marks around it
- Right click - mark a closed tile as a bomb
- Q - debug screen

Options:
- "*_color" settings accept a 6 or 3 digit hex value without a # at the start (or any other non-hex symbols), and change the color of specified part of the game
- "disable_periodic_updates" accepts "true", "t", "1", "yes", "yeah", "ye" or "y" as truthy value, and everything else as falsy; this disables every second data updates and turns that into a single update when you click on empty board
