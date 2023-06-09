#!/bin/bash
#file : running all files
trap "exit" INT
echo "============================="
echo "|        RUNNING TEST       |"
echo "============================="

cd testcase/

echo "Total Test Case : $(ls -1 *.robot | wc -l)"
echo ""
echo ""

case $1 in
   --parallel)
       echo ""
       echo "    Run Parallel Test      "
       echo "==========================="
       echo ""
       pabot --outputdir ../report ./
   ;;
   *)
       testnumber=0
       for filename in ./*.robot; do
           let testnumber=testnumber+1
           echo ""
           echo "RUN TEST : $testnumber"
           #default robot
           robot --outputdir ../report $filename
           #robot $filename;
       done
   ;;
esac