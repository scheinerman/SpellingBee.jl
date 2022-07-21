# SpellingBee

This module solves [NY Times Spelling Bee](https://www.nytimes.com/puzzles/spelling-bee) puzzles.

## Usage

Suppose the center letter in the puzzle is `W` and the surrounding letters are `ODNLET`. 

+ To get all solutions, use `bee_solver('w',"odnlet")`.
+ To get just the pangram solutions, use `pangram("wodnlet")`.
```
julia> pangram("wodnlet")
1-element Vector{String}:
 "LETDOWN"
 ```

`bee_solver` takes an optional third integer argument giving the minimum length of a word (default is 4).



## List of Words

By default we use the list of words found in the file `/usr/share/dict/words`.  To change this default, edit `src/SpellingBee.jl` and change the value assigned to `WORD_LIST`.

To switch to a different word list in the middle of a session, use
`SpellingBee.load_all_words(filename)`. Any word in the file `filename` that contains a 
capital letter is ignored. 

