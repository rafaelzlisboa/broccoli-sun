#! /usr/bin/octave -qf
source("chop-extract-save.m");

# first step: find all your broccoli
current_dir_files = ls("*.png");

# ask for size of mini-matrix
mm_rows = input("mini-matrices height (lines number): ");
mm_cols = input("mini-matrices width (columns number): ");

for i = 1:rows(current_dir_files)
	filename = current_dir_files(i, :);
	chop(filename, mm_rows, mm_cols);
endfor


