module SpellingBee

export bee_solver, pangram

WORD_LIST = "/usr/share/dict/words"

"""
    load_all_words(file_name::String = WORD_LIST)::Set{String}
Read in a dictionary of allowable words to be the answers to a SpellingBee puzzle
from the file named in `file_name`. The default `WORD_LIST` is 
`"/usr/share/dict/words"`.
"""
function load_all_words(file_name::String = WORD_LIST)
    F = open(file_name)
    wlist = readlines(F)
    clear_all_words()
    for w in wlist
        if length(w) < 4 || any(isuppercase(c) for c in w)
            continue
        end
        push!(WORDS, uppercase(w))
    end
    nothing
end

"""
    clear_all_words
Delete all words from the list of allowable words.
"""
function clear_all_words()
    for word ∈ WORDS
        delete!(WORDS, word)
    end
    nothing
end


WORDS = Set{String}()
load_all_words()

"""
    bee_filter(word::String, middle::Char, surround::String, min_len::Int = 4)::Bool
See if `word` is a valid solution to a SpellingBee puzzle where the middle letter 
is `middle` and the other letters are in `surround`.

`min_len` sets the minimum length of a valid word (default to be 4).
"""
function bee_filter(word::String, middle::Char, surround::String, min_len::Int = 4)::Bool
    if middle ∉ word || length(word) < min_len
        return false
    end
    valids = surround * middle
    return all(c ∈ valids for c ∈ word)
end

"""
    bee_solve("abcdefg")
    bee_solver('a', "bcdefg", min_len)
Find all words with 4 or more letters that must use `a`
and any of the letters in `bcdefg`.

`min_len` sets the minimum length of a valid word (default is 4).
"""
function bee_solver(middle::Char, surround::String, min_len::Int = 4)::Vector{String}
    middle = uppercase(middle)
    surround = uppercase(surround)

    S = Set(w for w ∈ WORDS if bee_filter(w, middle, surround, min_len))
    sort(collect(S))
end

function bee_solver(middle::String, surround::String, min_len::Int = 4)::Vector{String}
    if length(middle) != 1
        error("First argument should be a single character")
    end
    bee_solver(middle[1], surround, min_len)
end



function pangram_filter(word::String, letters::String)::Bool
    all(c ∈ letters for c in word)
end

"""
    pangram(letters)
Find all words that include all the characters in `letters`.
"""
function pangram(letters::String)::Vector{String}
    letters = uppercase(letters)
    S = Set(
        word for
        word in WORDS if pangram_filter(word, letters) && pangram_filter(letters, word)
    )
    return sort(collect(S))
end


function bee_solver(word::String)
    if length(word) != 7
        @warn "Expected seven letters"
    end
    plist = pangram(word)
    if length(plist) == 0
        println("No pangrams found")
    else
        println("Pangrams:")
        for p in plist 
            println("\t", p)
        end
    end
    first  = word[1]
    rest   = word[2:end]
    return bee_solver(first, rest)
end


end # module
