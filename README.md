## Historical Twitter Data

This is an attempt to merge data from the random sample of historical twitter archives to analyze discourse on trust.

This is a work in-progress. Currently, only the file `read_tweets.R` reads the historical twitter files. This file takes care of downloading the data, so there's no need to download anything externally. Just make sure you have the packages from the `read_tweets.R` files installed and the script should download everything, uncompress it, read it and show you the merged historical tweets.

Note that the downloaded files are really big and the files have been ignored in github through `.gitignore`. Do not change `.gitignore`, which would otherwise try to upload these massive files into github.
