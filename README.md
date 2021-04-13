% Interaction Technology and Techniques
  Assignment 1: Linux, Python
% Summer Semester 2021
% **Submission due: Wednesday, 21. April 2021, 23:55**

**We want everyone to have a working development environment and a (very) basic grasp of the Python language by next week. Therefore, this assignment needs to be done individually, not in groups.**

**Please check out the general rules for assignments documented in the introductory slides!**

1.1: Set up your development environment
==============================================

First you should set up a working Linux system. 

* Download the Debian *testing* (aka *bullseye*) netinst CD image (you'll probably want the `amd64` version): <http://cdimage.debian.org/cdimage/weekly-builds/>
* Install Debian either on a disk or inside a virtual machine:
  * **virtual machine:** install VirtualBox, create a new virtual machine, mount the image file as CD-ROM and boot the virtual machine.
  * **hard disk:** burn the image file to a CD or copy it to an USB stick using `dd`; boot from the CD/USB stick.
* Follow the installation instructions (*We recommend using "Install" instead of "Graphical Install"*) and choose the default settings if not sure.
  * Please select English (US) as default language as this makes following the tutorials easier
  * When asked about the *desktop environment* to be installed, keep the default "MATE" (a very simple one) for now or select one that you prefer.
  * If the installer shows an error message during download/installation of the software, retry several times, check that your network connection is ok, and finally allocate more RAM to the virtual machine.
* Once the system has booted, log into the desktop and open a *terminal* (Menu / System Utilities). Customize your system a little bit:
  * You have to change to the `root` user for installing additional packages: `$ su` (the dollar sign is the *prompt* and has not to be typed in). Enter the root password you assigned earlier in the installation process. The prompt will change to `#`.
  * Alternatively, you may add your user to the "sudo" group (`adduser franz sudo`) and prefix all "root" commands with `sudo` instead of using `su`.
  * Many useful packages are not available by default because they contain *non-free* software. You need to edit the list of package repositories to make them available:
    * `# nano /etc/apt/sources.list`
    * Change the line with your primary repository to also include "contrib" and "non-free": (`deb http://ftp.debian.com/debian/ bullseye main contrib non-free` or similar).
    * Save (Ctrl-o) and exit the editor (Ctrl-x).
    * Run `# apt update` in order to get the new package lists.
  * The root user does not have autocompletion of package names enabled. Execute `source /etc/bash_completion` to enable it. Now you can type `apt install virtualb<TAB>` and all available packages starting with "virtualb" are shown.
  * If inside VirtualBox, install the *guest additions*: `# apt install virtualbox-guest-utils virtualbox-guest-dkms virtualbox-guest-x11` and reboot.
  * Install the necessary Python packages for the next few sessions. The following ones are the most important ones: `# apt install python3 python3-doc ipython3 jupyter-notebook python3-matplotlib python3-numpy python3-scipy python3-virtualenv python3-pip python3-pyqt5 python3-pyqtgraph pep8 python3-sklearn python3-pandas`.
  * Install a few other nice tools: `xsel zenity apt-file`
  * Install an editor or IDE of your choice. Some suggestions:
    * lightweight: [vim + plugins](https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/)
    * simple IDE: [Komodo Edit](http://komodoide.com/komodo-edit/) 
    * full IDE: [PyCharm Edu](https://www.jetbrains.com/pycharm-edu/download/#section=linux) or [Komodo IDE](http://komodoide.com/)
    * more suggestions on the Python wiki: [Editors](https://wiki.python.org/moin/PythonEditors), [IDEs](https://wiki.python.org/moin/IntegratedDevelopmentEnvironments)
  * on mac host you have to capture the mouse for wiimote/hardware cursor override (this is probably needed later)
Make yourself familiar with the environment:

* read the tutorials linked on the course page
* learn how to use the command line: tab completion, history, shortcuts
* read the *man pages* for all commands listed on the Linux handout
* learn how to search for and install packages using `apt-cache search $keywords`, `apt-cache show $packagename`, `apt install $packagename` `apt-file search $filename`
* build a few simple shell one-liners using pipes


Hand in the following Bash script:

**count.sh** which does the following: 

* download a text file from <ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README> if it is not yet present in the current directory (use `wget` for this)
* make all text lowercase (use `tr`)
* split it into individual words per line (use `cat` and/or `sed` for this)
* alphabetically sort the list of words and remove duplicates (`sort` and `uniq`, possibly also `grep`).
* print out the 10 most common words in the text (without number of occurrences) on *stdout* (`uniq`, `sort`, and `head`)

<!-- wget -nc -q "ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README"; cat README | tr A-Z a-z | sed -e 's/[- ,\.:]/\n/g' -e '/^[ \t\r]*$/d' | sort | uniq -c | sort -rn | head -n 10 | sed -r 's/^ +[0-9]+ +//g' -->


Points
------------

* **2** The shell script has been submitted, is not empty, and does not print out error messages.
* **1** The script works as expected.
* **1** The script is well structured.
* **1** The script includes comments for every line.
* **1** The script removes punctuation, capitalization, etc. before counting the words.


1.2: Basic Python I/O 
=====================

* read the Python 3.9 documentation at <https://docs.python.org/3/>
* read the Python style guide (PEP 8) at <http://legacy.python.org/dev/peps/pep-0008/> and try out the `pep8` tool on your code.
* read the tutorials linked on the course page
* start `jupyter notebook` and get comfortable with it - you should use it to document your algorithms later in the course.
* write a few python scripts
* try out as many of the built-in functions (<https://docs.python.org/3/library/functions.html>)  as possible.
* experiment with the most important built-in types: `int`, `float`, `str`(ing), `tuple`, `list`, `dict`, `set`
* play with the `%` string formatting syntax 
* get familiar with a few basic modules, such as: `sys`, `math`, `random`.

Hand in the following Python program:

**stats.py**: Reads in a list of *floating point numbers*  either from a textfile passed as an argument to the script or via *stdin*. Numbers are separated by space characters and may contain either `,` or `.` as decimal separator. Prints out the mean, median, and standard deviation for these on *stdout*.

The script should only use built-in commands, the `math` module (for `math.sqrt()`), and the `sys` module (for `sys.argv` and `sys.stdin`).

Points
------------

* **1** The python script has been submitted, is not empty, and does not print out error messages.
* **3** The script correctly calculates mean, median, and standard deviation (numbers may be hardcoded) 
* **2** The script can read and convert numbers from both a file and ''stdin''.
* **2** The script is well-structured and follows the Python style guide (PEP 8)


1.3: Drawing with the ''turtle'' module 
=======================================

Get to know the `turtle` module (<https://docs.python.org/3/library/turtle.html>).

Hand in the following Python program:

**circle.py**: Takes a *radius* (int) as commandline parameter. Draws something resembling a circle with the given radius using the `turtle` module. The turtle should alternatively move forward or turn left/right so that it stays at about *radius* pixels from the center of the screen. Experiment with varying turning angles and movement distances. Do not use the `circle()` function - that would be too easy.


Points
------------

* **1** The python script has been submitted, is not empty, and does not print out error messages.
* **2** The script draws a circle-like structure on the screen. 
* **2** The script draws a beautiful circle-like structure on the screen.
* **1** The script is well-structured and follows the Python style guide (PEP 8)



1.4: The most `*`ing things you learned
==============================================

Prepare a list of the most interesting, surprising, or annoying features/bugs you discovered while doing the other assignments.
Bring this list to the next course session.


Submission 
=========================================
Submit via GRIPS until the deadline:

* count.sh
* stats.py
* circle.py

All files should use UTF-8 encoding and Unix line breaks.
Python files should use spaces instead of tabs.

                                                               Have Fun!
