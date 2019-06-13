library(R.utils)
library(ndjson)
library(parallel)

# Only downloading the twitter stream for day 2018-10-01 to test it.
# I'm guessing this should be generalizable to other days. In fact, we
# should try to do a random sample of all days and merge them.
bg_tweet_fl <- "https://archive.org/download/archiveteam-twitter-stream-2018-10/twitter-2018-10-01.tar"

# Downloading: this is really big and takes 5-10 mins.
download.file(bg_tweet_fl, destfile = "./big_tweets.tar")

# Now we have our file, let's uncompress it 
untar("./big_tweets.tar")

# Unzip one file to test that it works.
bunzip2("./2018/10/01/01/48.json.bz2")

# Let's read only one data file of that year/month/day (there are
# several files) to test that it works.
tst <- stream_in("./2018/10/01/01/48.json", cls = 'tbl')

# Here we have some tweets
tst["text"]

# 140 characters, so we're sure this is the text indeed
nchar(tst[["text"]][2364])

# Remove it for now
file.remove("./2018/10/01/01/48.json")

# How could we generalized this to all hours of the day
# 2018/10/01?
all_compressed_tweets <- list.files("./2018/10/01/",
                                    full.names = TRUE,
                                    recursive = TRUE)

# Uncompress all hours for that day. This can take up some time: 10 mins
for (i in all_compressed_tweets) bunzip2(i)

# List all paths to all uncompressed json files
all_tweets <- list.files("./2018/10/01/",
                         full.names = TRUE,
                         recursive = TRUE,
                         pattern = "\\.json$")

# Read all json files of the day in parallel
tweets <- mclapply(all_tweets,
                   function(x) stream_in(x, cls = 'tbl')['text'],
                   mc.cores = detectCores())

# Merge all tweets together
tweets_merged <- Reduce(rbind, tweets)

# 4M rows of tweets merged
tweets_merged
