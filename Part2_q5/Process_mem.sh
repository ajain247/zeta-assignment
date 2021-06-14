#!/bin/sh
ps -eo cmd,%cpu,%mem,pid --sort=-%mem,%cpu | head | sed -n 1p > output.txt
