/*
This code runs only after the global macro DIR has been defined elsewhere. 
I have to run global_macro1.do in the same Stata session before running 
this .do file.

Note that there is no way to run global_macro1.do from here as I don't
know which directory it is in. (DIR has not been defined yet.)
*/
import delimited "$DIR/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)

keep iso31661alpha3 iso31661alpha2

save "$DIR/data/country-codes.dta", replace
