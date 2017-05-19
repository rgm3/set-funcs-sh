#!/usr/bin/env bats

#source "${BATS_TEST_DIRNAME}/../set-funcs.bash"
load ../set-funcs

@test "requirements" {
  for cmd in $REQUIRED_TOOLS; do
    run command -V "${cmd}"
    [ "${status}" -eq 0 ] || {
      echo "Missing command: ${cmd}" >&2
      false
    }
  done
}

@test "difference" {
  result="$( difference_set 'aa bb cc' 'cc dd ee')"
  [ "${result}" == 'aa bb' ]
}

@test "complement" {
  [ "$(complement_set 'aa' 'bb')" == 'bb' ]
  [ "$(complement_set 'aa bb cc' 'ff cc dd ee')" == 'dd ee ff' ]
}

@test "symmetric difference" {
  # elements in set 1 or set 2 but not both
  result="$( symmetric_diff_set 'aa bb cc' 'bb cc dd' )"
  [ "${result}" == "aa dd" ]
}

@test "intersection" {
  result="$( intersect_set 'aa bb cc dd'  'bb dd' )"
  [ "${result}" == "bb dd" ]
}

# True when no element exists in common
@test "disjoint test" {
  is_set_disjoint 'aa'  'bb cc'
  ! is_set_disjoint 'aa'  'bb aa cc'
}

@test "union" {
  [ "$(union_set 'aa bb' 'cc dd')" == 'aa bb cc dd' ]
  [ "$(union_set 'aa bb' 'bb cc')" == 'aa bb cc' ]
  [ "$(union_set 'aa' 'aa aa aa bb cc')" == 'aa bb cc' ]
}

@test "set length" {
  [ $(set_length 'a b ccccc d e f g h i j k l m n o   ') -eq 15 ]
  [ $(set_length '') -eq 0 ]
  [ $(set_length ' ') -eq 0 ]
  [ $(set_length '   9') -eq 1 ]
}

@test "empty set test" {
  is_set_empty ''
  is_set_empty ' '
  ! is_set_empty 'aa bb cc'
}
