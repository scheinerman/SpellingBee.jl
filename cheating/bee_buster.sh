#!/bin/bash
sed s/">"/">\n"/g < $1 | grep answers | head -1 | \
sed s/"},"/"\n"/g | head -1 | sed s/"],"/"]\n"/g | \
grep "answers" | \
cut -f2 -d: | sed s/"]"// |  sed s/"\["// | sed s/'"'//g | \
sed s/","/"\n"/g