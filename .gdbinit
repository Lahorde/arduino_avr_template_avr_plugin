# http://sourceware.org/gdb/wiki/FAQ: to disable the
# "---Type <return> to continue, or q <return> to quit---"
# in batch mode:
set pagination off
echo running project .gdbinit\n
echo avarice --debugwire --dragon --ignore-intr :4242\n
     shell avarice --debugwire --dragon --ignore-intr :4242 > /dev/null 2>&1 &
shell sleep 1
target remote localhost:4242


