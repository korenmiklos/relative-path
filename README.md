# Examples of using absolute or relative paths in Stata
How do you refer to data input and output files in your script? Here I provide some often used examples and explain the benefits and costs of each. There is no free lunch, but some of these approaches better than others.

## Absolute paths
```stata
import delimited "/Users/koren/Documents/code/stata/relative-path/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)
keep iso31661alpha3 iso31661alpha2
save "/Users/koren/Documents/code/stata/relative-path/data/country-codes.dta", replace
```

This code runs on my computer, irrespective where I run it from. But it does not run on my coauthor's computer. Neither does it run on my other computer, if I use a different folder there.

Moreover, my coauthor will have to edit the path twice. 

> This is probably the worst solution, avoid it if you can.

## Local macro
```stata
local DIR "/Users/koren/Documents/code/stata/relative-path"
import delimited "`DIR'/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)
keep iso31661alpha3 iso31661alpha2
save "`DIR'/data/country-codes.dta", replace
```

This code runs on my computer, irrespective where I run it from. But it does not run on my coauthor's computer. Neither does it run on my other computer, if I use a different folder there.

There is, however, only one place to edit the path (on line 1). Your c

> This is somewhat better, but your coauthor will have to edit the .do file every time you send it to them.

## Global macro
This strategy uses two separate .do files, hence the need for global rather than local macros.

The first script sets the global.
```stata
global DIR "/Users/koren/Documents/code/stata/relative-path"
```
This script will only work on my own computer, not on my coauthors. But they only have to edit their version of this script once and can leave it untouched.


The second script does the actual work.
```stata
import delimited "$DIR/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)
keep iso31661alpha3 iso31661alpha2
save "$DIR/data/country-codes.dta", replace
```

This code runs only after the global macro DIR has been defined elsewhere. I have to run the first .do file in the same Stata session before running this .do file.

Note that there is no way to run the first script from the second, as I don't know which directory it is in. (DIR has not been defined yet.) I could define a main script calling both, but where do I call it from?

> This is the most often used solition. The main benefit is you can define more than one directory (say, one for code, one for data.) But it still requires some convention of how to run the code.

## Relative path
```stata
import delimited "data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)
keep iso31661alpha3 iso31661alpha2
save "data/country-codes.dta", replace
```
This code runs on any computer, but only if the current working directory is set to the folder containing `data/country-codes.csv`.

Before running this code, I manually type in my command line on Stata session
```bash
cd ~/Documents/code/stata/relative-path
```

I have to do this every time I start working on this project. But the paths in the code never have to be edited, so the code is portable.

> This solution makes code itself perfectly portable at the expense of having to cd into the project folder every time I start working.

## The here package
This approach uses [here](https://github.com/korenmiklos/here), which can be installed with `net install here, from("https://raw.githubusercontent.com/korenmiklos/here/master/")`.

I first mark the root folder of the project.
```stata
cd ~/Documents/stata/code/relative-path
here, set
```
I only have to do it once. If the folder is a git repository, I don't even have to do this step.

Then I can run my code from any subfolder *within* the project folder
```stata
here
import delimited "$here/data/country-codes.csv", clear encoding("utf-8") bindquotes(strict)
keep iso31661alpha3 iso31661alpha2
save "$here/data/country-codes.dta", replace
```

> This solution has the benefit that code can be run from anywhere within the project folder. If we reorganize our code into different subfolders, we don't have to edit relative paths.