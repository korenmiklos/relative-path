/*
This code runs on my computer, irrespective where I run it from.
But it does not run on my coauthor's computer. Neither does it run
on my other computer, if I use a different folder there.

There is, however, only one place to edit the path (on line 8).
*/
local DIR "/Users/koren/Documents/code/stata/relative-path"
import delimited "`DIR'/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)

keep iso31661alpha3 iso31661alpha2

save "`DIR'/data/country-codes.dta", replace
