/*
This code runs on my computer, irrespective where I run it from.
But it does not run on my coauthor's computer. Neither does it run
on my other computer, if I use a different folder there.

Moreover, my coauthor will have to edit the path twice. 
*/
import delimited "/Users/koren/Documents/code/stata/relative-path/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)

keep iso31661alpha3 iso31661alpha2

save "/Users/koren/Documents/code/stata/relative-path/data/country-codes.dta", replace
