describe.sh
-----------

Calculate and print various statistical measures for a file (or stdin). Each line should contain a single value. Measures include:
 - number and sum of values
 - min, max, average, median value
 - standard deviation
 - 90%, 99%, 99.9% percentile

Syntax:
```shell
$ describe.sh <file>
```
or:
```shell
$ cat <file> | describe.sh
```

Example:
```shell
$ cat f | describe.sh
rows     : 40
sum      : 43800
min      : 11
max      : 2684
avg      : 1095
std      : 827.225
avg-+std : 267.775 , 1922.22
median   : 883
90.0perc : 2583
99.0perc : 2684
99.9perc : 2684
```



fixbb.sh
--------

Fix bounding box of eps files, trimming any white space around image.

Syntax:
```shell
$ fixbb.sh <eps file>
```



flush-page-cache.sh
-------------------

Write all dirty buffers from page cache to disk and clean the page cache.

Syntax:
```shell
$ flush-page-cache.sh
```

Example:
```shell
$ flush-page-cache.sh
             total       used       free     shared    buffers     cached
Mem:          2950       2732        218         25        252       1147
sudo sync ...
echo 3 > /proc/sys/vm/drop_caches ...
Mem:          2950       1359       1591         25          1        153
```



git-gc.sh
---------

A more efficient way to garbage collect a git repository ([according to Linus](http://gcc.gnu.org/ml/gcc/2007-12/msg00165.html0)).

Syntax (inside a git repository):
```shell
$ git-gc.sh
```



git-kompare-[staged|unstaged].sh
---------

See the code changes that are staged for commit, or not staged yet, using [Kompare](http://www.caffeinated.me.uk/kompare/).

Syntax (inside a git repository):
```shell
$ git-kompare-staged.sh
$ git-kompare-unstaged.sh
```



pdf2gray.sh
-----------

Convert a pdf file to grayscale. Useful to see how a color pdf would look like if printed.

Syntax:
```shell
$ pdf2gray.sh <input pdf> <output pdf>
```


percentiles.sh
--------------

Compute a percentile for values in stdin. Each line should contain a single value.

Syntax:
```shell
$ cat <file> | percentiles.sh <percentile> [<number of demical digits>]
```

Example:
```shell
# print the 90% percentile of the 2nd column
$ cat file.log | awk '{print $2}' | percentiles.sh 0.9 3 
2583.057
```


randint.sh
----------

Print a random integer with a range.

Syntax:
```shell
$ randint.sh <min int> <max int>
```


remove-comments.sed
-------------------

Remove comments from C / C++ files.

Syntax:
```shell
$ remove-comments.sed < a.c > a-nocomments.c
```



sliding-window.sh
-----------------

Compute a moving average over the lines of stdin. Each line may contain more than one values, and average values are computed per column.


Syntax:
```shell
$ cat <file> | sliding-window.sh <window size> [<number of demical digits>]
```

Example:
```shell
$ cat f 
1
4
5
7
6
8
9
6
4

$ cat f | sliding-window.sh 4 3
4.250 
5.500 
6.500 
7.500 
7.250 
6.750 
```



subs-adjust.awk
---------------

Adjust the timing of subtitles, shifting them by a specific amount of time.

Example:
```shell
$ subs-adjust.awk -v s=+10 -v ms=-350 foo.srt > foo-synced.srt
```



tmpfs-[mount|umount].sh
-----------------------

Mount (or umount) part of the physical memory as a normal disk partition. Will create the mount directory if it does not exist.

Syntax:
```shell
$ tmpfs-mount.sh <size_in_mb> <directory>
$ tmpfs-umount.sh <directory>
```

Example: mount 100MB of memory as disk a partition in /tmp/ram_dir/.
```shell
$ tmpfs-mount.sh 100 /tmp/ram_dir

    < ... use /tmp/ram_dir ... >

$ tmpfs-umount.sh /tmp/ram_dir
```
