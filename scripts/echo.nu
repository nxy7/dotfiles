#!/usr/bin/env nu

def main [
  input = "mordo": string
] {
  x $input
}

def x [
  input?: string
] {
  print $'elo co tam u ciebie ($input)'
} 
