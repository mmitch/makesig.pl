#!/bin/sh
#
# NOTE:
# These examples want the tools to reached by ../tools/ and
# makesig.pl to be found in ./../
# Should be no problem if you untared the archive as usual
# and now are in the examples directory.
#

echo "Let's try working with static files."
echo "Watch our demo text:"
echo 

cat demo.txt



echo 
echo "Now let's center it:"
echo 

../tools/hcenter.pl < demo.txt

echo 
echo "See the difference when it is centered as a block:"
echo 

../tools/hcenterblock.pl < demo.txt



echo
echo "Static files are boring. Here's your uptime:"

/usr/bin/uptime

echo
echo "Now lets put that uptime to the right:"

/usr/bin/uptime \
| ../tools/right.pl



echo
echo "Now we put the demo text on top of a background:" 

../tools/overlay.pl demo.txt background.txt

echo
echo "Now we put the background on top of the demo text :-)"

../tools/overlay.pl background.txt demo.txt

echo
echo "Bottom right on a background:"

../tools/bottom.pl < demo.txt \
| ../tools/right.pl \
| ../tools/overlay.pl - background.txt




echo
echo "Now take random quotes from makesig.pl and make them look cool."
echo "Note that there are two parts of the signature that are changing"
echo "randomly. Finally we put our uptime next to it."
echo

# temporary files go here
TEMP=/tmp/`basename $0`-$$

# this is the left part (ascii graphics)
./../makesig.pl ./left.conf \
| ./../tools/bottom.pl 4 > $TEMP.left

# this is the right side
# top (quote)
./../makesig.pl ./right.conf \
| ./../tools/left.pl \
| /usr/bin/cut -c 1-66 \
| ./../tools/top.pl 2 \
| ./../tools/hcenter.pl 66 \
| ./../tools/indent.pl 13 > $TEMP.right

# bottom (uptime)
/usr/bin/uptime \
| ./../tools/bottom.pl 2 \
| /usr/bin/cut -c 1-66 \
| ./../tools/right.pl 66 \
| ./../tools/indent.pl 13 >> $TEMP.right

# sigdashes
echo "-- "

# put everything together
./../tools/overlay.pl $TEMP.right $TEMP.left

# clean up
rm $TEMP.*

echo
echo "This is the same as above, but written without using temporary"
echo "files. Much cooler, but nobody can read the script :-)"
echo

echo "-- "
./../tools/overlay.pl \
"./../makesig.pl ./left.conf | ./../tools/bottom.pl 4 | " \
"./../makesig.pl ./right.conf | ./../tools/left.pl | /usr/bin/cut -c 1-66 | ./../tools/top.pl 2 | ./../tools/hcenter.pl 66| ./../tools/indent.pl 13|" \
"/usr/bin/uptime | ./../tools/bottom.pl 4 | /usr/bin/cut -c 1-66 | ./../tools/right.pl 66| ./../tools/indent.pl 13|"



echo
echo
echo
echo "If you can't read all of this at once, try \"./tools.sh|less\""
echo "If you want to know how this is done, try \"less ./tools.sh\""
