#!/bin/sh
echo "$# argument(s):"
for arg 
do #Some shell may not handle the for arg;do properly cus there is no "in" follows the "arg "
  echo "'$arg'"
done
