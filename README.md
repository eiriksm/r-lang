r-lang
======

Testing R.

Data sources:

- [Lahman's Baseball Database](http://seanlahman.com/baseball-archive/statistics/)
- [The Bureau of Labor Statistics: Consumer Price Index](http://www.bls.gov/cpi/)

The plot shows the average salary of baseball players per year laid on top of how many 6-packs of imported beers the average salary could buy each year. Extremely useful.

### Usage
The script can be run as follows:

```
Rscript bsalaries.r
```

This will generate an svg file with the plot. If you get an error (for example if you have an old version of cairo or something) you can run the script with png as only argument. Like so:

```
Rscript bsalaries.r png
```

![Not so useful beer stats](https://rawgit.com/eiriksm/r-lang/master/Beer.svg)
