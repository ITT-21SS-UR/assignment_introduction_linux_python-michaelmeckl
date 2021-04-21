#!/bin/sh

# define some constants
URL="ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README"
FILENAME=gnome_readme.txt

GetMostCommonWords() {
  # convert the given text to lowercase
  text_lower=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  # echo "$text_lower" | wc

  # split text into one word per line (by replacing spaces with a newline) and remove digits, punctuation and empty lines
  # parts of the sed command were taken from https://stackoverflow.com/a/15501736 and updated to delete empty lines too
  text_splitted=$(echo "$text_lower" | tr " " "\n" | tr -d "[:digit:]" | sed -e 's/[[:punct:]]*//g ; /^[[:space:]]*$/d')
  # echo "$text_splitted" | wc

  # alphabetically sort the lines and remove duplicates (the -c option is used here for the next step)
  unique_sorted=$(echo "$text_splitted" | sort | uniq -c)
  # print out the 10 most common words in the text:
  echo "The 10 most common words in the text are (in descending order):"
  # sort based on the count in reverse order (to show the most common at the top) and use awk to remove the numbers by only printing the second field
  echo "$unique_sorted" | sort -nr | head | awk '{print $2}'
}

# the same as above as a one-liner:
GetMostCommonWordsOneLine() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | tr " " "\n" | tr -d "[:digit:]" | sed -e 's/[[:punct:]]*//g ; /^[[:space:]]*$/d' | sort | uniq -c | sort -nr | head | awk '{print $2}'
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
