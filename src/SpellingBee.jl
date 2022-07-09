module SpellingBee

export bee_solver, pangram

WORD_LIST = "/usr/share/dict/words"

"""
    load_all_words(file_name::String = "/usr/share/dict/words")::Set{String}
Read in a dictionary of allowable words to be the answers to a SpellingBee puzzle.
"""
function load_all_words(file_name::String = WORD_LIST)
    F = open(file_name)
    wlist = readlines(F)

    S = Set{String}()

    for w in wlist
        if length(w) < 4 || any(isuppercase(c) for c in w)
            continue
        end
        push!(WORDS, uppercase(w))
    end
    nothing
end

WORDS = Set{String}()
load_all_words()

"""
    bee_filter(word::String, middle::Char, surround::String)::Bool
See if `word` is a valid solution to a SpellingBee puzzle where the middle letter 
is `middle` and the other letters are in `surround`.
"""
function bee_filter(word::String, middle::Char, surround::String)::Bool
    if middle ∉ word
        return false
    end
    valids = surround * middle
    return all(c ∈ valids for c ∈ word)
end

"""
    bee_solver('a', "bcdefg")
Find all words with 4 or more letters that must use `a`
and any of the letters in `bcdefg`.
"""
function bee_solver(middle::Char, surround::String)::Vector{String}
    # wlist = load_all_words()
    middle = uppercase(middle)
    surround = uppercase(surround)

    S = Set(w for w ∈ WORDS if bee_filter(w, middle, surround))
    sort(collect(S))
end

function bee_solver(middle::String, surround::String)::Vector{String}
    if length(middle) != 1
        error("First argument should be a single character")
    end
    bee_solver(middle[1], surround)
end


function pangram_filter(word::String, letters::String)::Bool
    all(c ∈ letters for c in word)
end

"""
    pangram(letters)
Find all words that include all the characters in `letters`.
"""
function pangram(letters::String)::Vector{String}
    # wlist = load_all_words()
    letters = uppercase(letters)
    S = Set(
        word for
        word in WORDS if pangram_filter(word, letters) && pangram_filter(letters, word)
    )
    return sort(collect(S))
end




end # module
