#!/bin/sh

# define some constants
URL="ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README"
FILENAME=gnome_readme.txt

GetMostCommonWords() {
  # convert the given text to lowercase
  text_lower=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  # remove punctuation and split into separate words per line
  # parts of the sed command were taken from https://stackoverflow.com/a/15501736 and updated to delete empty lines too
  # TODO remove the whitespace char and maybe the numbers too!
  text_splitted=$(echo "$text_lower" | sed -e 's/\s/\n/g ; s/[[:punct:]]*//g ; /^[[:space:]]*$/d')
  # alphabetically sort the lines and remove duplicates (the -c option is used here for the next step)
  unique_sorted=$(echo "$text_splitted" | sort | uniq -c)
  # print out the 10 most common words in the text:
  # sort based on the count in reverse order (to show the most common at the top) and use awk to remove the numbers by only printing the second field
  echo "$unique_sorted" | sort -nr | head | awk '{print $2}'
}

# the same as above as a one-liner:
GetMostCommonWordsOneLine() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/\s/\n/g ; s/[[:punct:]]*//g ; /^[[:space:]]*$/d' | sort | uniq -c | sort -nr | head | awk '{print $2}'
}

# check if the file exists in the current directory; if not download it
if [ ! -e $FILENAME ]; then
  # give some user feedback
  echo "Downloading file ..."
  # use tee instead of > so the output is written to the variable (because of the - after O) and to the file as well;
  content=$(wget -qO - $URL | tee $FILENAME)
  # call the function 'GetMostCommonWords' with the content of the download
  GetMostCommonWords "$content"
else
  echo "Skipping download as this file already exists!"
  # read in the existing file and call the function 'GetMostCommonWords' with its content
  GetMostCommonWords "$(cat $FILENAME)"
fi
