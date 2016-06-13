#!/usr/bin/env bats

source ./light

cur=100
max=200

@test "simple absolute" {
  run calc_brightness 1 ${cur} ${max}
  [ "${status}" -eq 0 ]
  [ "${output}" = "1" ]
}

@test "not less than 1" {
  run calc_brightness 0 ${cur} ${max}
  [ "${status}" -eq 0 ]
  [ "${output}" = "1" ]
}

@test "not greater than max" {
  run calc_brightness $(expr ${max} + 1) ${cur} ${max}
  [ "${status}" -eq 0 ]
  [ "${output}" = "${max}" ]
}

@test "relative add" {
  run calc_brightness +10 100 ${max}
  [ "${status}" -eq 0 ]
  [ "${output}" = "110" ]
}

@test "relative subtract" {
  run calc_brightness -10 100 ${max}
  [ "${status}" -eq 0 ]
  [ "${output}" = "90" ]
}

@test "percent absolute" {
  run calc_brightness 10% 100 200
  [ "${status}" -eq 0 ]
  [ "${output}" = "20" ]
}

@test "percent relative (positive)" {
  run calc_brightness +10% 50 200
  [ "${status}" -eq 0 ]
  [ "${output}" = "70" ]
}

@test "percent relative (negative)" {
  run calc_brightness -10% 50 200
  [ "${status}" -eq 0 ]
  [ "${output}" = "30" ]
}

@test "truncate float" {
  run calc_brightness 10.5 100 200
  [ "${status}" -eq 0 ]
  [ "${output}" = "10" ]
}
