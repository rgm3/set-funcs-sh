# -*-Shell-script-*-
#
# set-funcs
#
# Functions that operate on sets of strings.
# Sets are space-separated strings.
# Set operations that return a set return strings via echo.
# Boolean operations use exit code 0 for success, non-zero for failure.

# WISHLIST:
#  - [ ] support elements containing spaces
#  - [ ] test using shell arrays
#  - [ ] set comparison (is_superset, is_subset)
#  - [ ] membership tests (contains)


REQUIRED_TOOLS="diff paste comm sort uniq"

###############################################################################
# Difference (-)
# @return elements in set 1 that are not in set 2
###############################################################################
function difference_set {
  comm -23 \
    <(echo $1 | tr " " "\n" | sort) <(echo $2 | tr " " "\n" | sort) \
    | paste -s -d ' ' -
}

###############################################################################
# Complement.
# @return elements in set 2 that are not in set 1
###############################################################################
function complement_set {
  comm -13 \
    <(echo $1 | tr " " "\n" | sort) <(echo $2 | tr " " "\n" | sort) \
    | paste -s -d ' ' -
}

###############################################################################
# Symmetric difference (^)
# @return elements that are in set 1 or set 2 but not both
###############################################################################
function symmetric_diff_set {
  comm -3 \
    <(echo $1 | tr " " "\n" | sort) <(echo $2 | tr " " "\n" | sort) \
    | tr -d '\t' | paste -s -d ' ' -
}

###############################################################################
# Intersection (&).  An element is in the result if it is in one set _and_ the other.
# @return elements common to both sets, A ∩ B
###############################################################################
function intersect_set {
  comm -12 \
    <(echo $1 | tr " " "\n" | sort) <(echo $2 | tr " " "\n" | sort) \
    | paste -s -d ' ' -
}

###############################################################################
# Disjoint set test
# @return (via code) 0 if sets are disjoint (share no elements in common)
#                    1 if sets are not disjoint (have a shared element)
###############################################################################
function is_set_disjoint {
  local intersection=$(intersect_set "$1" "$2")
  [[ -z "$intersection" ]]
}

###############################################################################
# Union (|)
# @return elements from both sets (combination), A ∪ B
###############################################################################
function union_set {
  echo "$1 $2" | tr " " "\n" | sort | uniq | paste -s -d ' ' -
}

###############################################################################
# @return set cardinality (number of elements)
###############################################################################
function set_length {
  echo $1 | wc -w | tr -d '[:blank:]'
}

###############################################################################
# Empty set test
# @return (via code) 0 if set is empty (contains no elements)
#                    1 if set contains at least one element
###############################################################################
function is_set_empty {
  [[ $(set_length "$1") -eq 0 ]]
}
