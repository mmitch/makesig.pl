#!/bin/sh
#
# $Revision: 1.4.4.3 $
#
# NOTE:
# These examples want the tools to be present in the $PATH
# ./../ and ./../tools/ are added to the $PATH
# This should be alright if you untared the archive as usual and now
# are in the examples directory.
#

PATH="../tools/:..:$PATH"

echo "This is a demonstration of the makesig.pl random signature generator."
echo "Get your up-to-date copy at http://www.cgarbs.de/makesig_pl.en.html"
echo

echo "Let's try working with static files."
echo "Watch our demo text:"
echo 

cat demo.txt

echo 
echo "Now let's center it:"
echo 

hcenter.pl < demo.txt

echo 
echo "See the difference when it is centered as a block:"
echo 

hcenterblock.pl < demo.txt



echo
echo "Now we put the demo text on top of a background:" 

overlay.pl demo.txt background.txt

echo
echo "Now we put the background on top of the demo text :-)"

overlay.pl background.txt demo.txt

echo
echo "Bottom right on a background:"

bottom.pl 6 < demo.txt \
| right.pl \
| overlay.pl - background.txt



echo
echo "Static files are boring. Here's your uptime:"

uptime

echo
echo "Now let's put that uptime to the right:"

uptime | right.pl



echo
echo "Now take random quotes from makesig.pl and make them look cool."
echo "Note that there are two parts of the signature that are changing"
echo "randomly. Finally we put our uptime next to it."
echo

# temporary files go here
TEMP=/tmp/`basename $0`-$$

# this is the left part (ascii graphics)
makesig.pl left.conf \
| bottom.pl 4 > $TEMP.left

# this is the right side
# top (quote)
makesig.pl right.conf \
| left.pl \
| cut -c 1-66 \
| top.pl 2 \
| hcenter.pl 66 \
| indent.pl 13 > $TEMP.right

# bottom (uptime)
uptime \
| bottom.pl 2 \
| cut -c 1-66 \
| right.pl 66 \
| indent.pl 13 >> $TEMP.right

# sigdashes
echo "-- "

# put everything together
overlay.pl $TEMP.right $TEMP.left

# clean up
rm $TEMP.*

echo
echo "This is the same as above, but written without using temporary"
echo "files. Much cooler, but nobody can read the script :-)"
echo

echo "-- "
overlay.pl \
"makesig.pl left.conf | bottom.pl 4 |" \
"makesig.pl right.conf | left.pl | cut -c 1-66 | top.pl 2 | hcenter.pl 66 | indent.pl 13 |" \
"/usr/bin/uptime | bottom.pl 4 | cut -c 1-66 | right.pl 66 | indent.pl 13 |"



echo
echo
echo
echo ">>> If you can't read all of this at once, try \"./tools.sh | less\""
echo ">>> If you want to know how this is done, try \"less ./tools.sh\""
echo