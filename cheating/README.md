# Cheating at Spelling Bee

The `bash` shell script `bee_buster.sh` in this directory parses the 
HTML source file for the Spelling Bee game to extract the answers. 

## How to cheat
Save the file `bee_buster.sh` in a directory that is in your `PATH` (such as `~/bin`).

Steps:
* Go to the Spelling Bee puzzle page in (say) Chrome.
* Select the menu item `View > Developer > View Source`. A new tab will open with the puzzle's HTML code.
* Save the source in a file (say) `bee_source.html`.
* Run `bee_buster.sh bee_source.html`.

The answers will appear. 

## Example

The puzzle for January 3, 2024 had the letters H C G L A N E (and H was the center letter).
```
$ bee_buster.sh bee_source.html 
challenge
ache
cache
challah
chance
chancel
change
channel
clench
each
enhance
ganache
ghee
haggle
halal
hale
hall
hang
heal
heel
hell
hence
henge
henna
leach
lech
leech
```

Your fun has been ruined.