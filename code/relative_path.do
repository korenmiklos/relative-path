/*
This code runs on any computer, but only if the current working
directory is set to the folder containing data/country-codes.csv.

Before running this code, I manually type in my command line on Stata
session

	cd ~/Documents/code/stata/relative-path

I have to do this every time I start working on this project.
But the paths in the code never have to be edited, so the code
is portable.
*/
import delimited "data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)

keep iso31661alpha3 iso31661alpha2

save "data/country-codes.dta", replace
