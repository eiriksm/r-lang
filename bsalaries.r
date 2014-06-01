# Read data.
sals = read.csv(file="data/Salaries.csv", head=TRUE,sep=",")
beer = read.csv(file="data/Beer.csv", head=TRUE,sep=",")

# Convert beer list to a hash so we can look up by year.
beerHash <- new.env(hash = TRUE, parent = emptyenv(), size = nrow(beer))

# Pre allocate vectors for use in combined dataset.
length <- nrow(sals)

for(i in 1:nrow(beer)) {
  row <- beer[i,]
  # Need to have a string as key.
  key <- as.character(row$Year)
  beerHash[[ key ]] <- row$import6pack
}

year <- character()
numBeers <- numeric()

calcNumBeers <- function(row)
{
  # Get beer price.
  key <- as.character(row[1])
  val <- beerHash[[key]]
  if (typeof(val) == 'NULL')
  {
    # Do nothing.
  }
  else
  {
    salary = as.numeric(row[5])
    num <- (salary / val)

    ## Oops. messing with outer scope. Supposedly a bad thing :(
    year <<- c(year, key)
    numBeers <<- append(numBeers, num)
  }
}

# Wow. Such functional, much return.
o <- apply(sals, 1, calcNumBeers)

beerFrame <- data.frame(year, numBeers, stringsAsFactors=FALSE)

# Plot salaries and number of beers on salaries on top of each other.
dat <- aggregate(numBeers ~ year, beerFrame, mean)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0 && args[1] == "png")
{
  png(filename="./Beer.png")
} else
{
  # Use pretty vectorized output (this does not work on my mac).
  svg(filename="./Beer.svg")
}

plot(
  x = dat$year,
  y = dat$numBeers,
  type = "o",
  col = "blue",
  main = "Salaries and possibility to buy 6-packs of import beer",
  xlab = "Year",
  ylab = "Number of beers"
)
# Reuse file so next plot will go on top of this one.
par(new=TRUE)

sdat <- aggregate(salary ~ yearID, sals, mean)
plot(
  xaxt = "n",
  ann = FALSE,
  yaxt = "n",
  x = sdat$yearID,
  y = sdat$salary,
  type = "o",
  col = "red",
  main = "Salaries",
  xlab = "Year",
  ylab = "Dollars"
)
g_range <- range(0, dat)
legend(1986, 2000000, c("Number of beers","Salaries"), cex=0.8,
   col=c("blue","red"), pch=21:22, lty=1:2);
