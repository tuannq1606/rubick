#!/usr/bin/env bash

rubickRoot=~/.rubick

mkdir -p "$rubickRoot"

cp -i src/stubs/Rubick.yaml "$rubickRoot/Rubick.yaml"
cp -i src/stubs/after.sh "$rubickRoot/after.sh"
cp -i src/stubs/aliases "$rubickRoot/aliases"

echo "Rubick initialized!"