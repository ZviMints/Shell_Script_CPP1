# This program is responsible to check for memory leaks, Thread debugger
# and run the input program
# this TEST made through CPP Course by Tzvi Mints, Or Abuhazira
# and Eilon Tsadok

#!/bin/bash
Answer=(FAIL FAIL FAIL)

# This function is responsible for print output to the screen
output_to_screen() {
echo "Compilation    Memory leaks   thread race"
echo -e "  ${Answer[0]} \t\t ${Answer[1]} \t\t ${Answer[2]}"
echo -e "\t\t Summary: $1"
exit $1
}

# This function is responsible for making step 3 in the assignment
step3() {
compile $1 $2
first=$?
memorychk $1 $2
second=$?
threaddebugger $1 $2
third=$?
answer=$((2#$first$second$third))
output_to_screen $answer
}

# This function is responsible for Thread debugger used by Helgrind
threaddebugger() {
 valgrind --tool=helgrind ./$1 $2 >/dev/null 2>&1
if [ $? -eq 0 ] 
	then
                Answer[2]=PASS
                return 0
        else
                return 1
fi
}
# This function is responsible to check for memory leaks used by Velgrind
memorychk() {
valgrind --leak-check=full --error-exitcode=1 ./$1 $2 >/dev/null 2>&1
if [ $? -eq 0 ]
	 then
                Answer[1]=PASS
                return 0
        else
                return 1 
fi
}

# This function is responsible to compile the input
# Program and then go to step 3, which is memory check
compile() {
./$1 $2 2>/dev/null
if [ $? -eq 0 ] 
	then
		Answer[0]=PASS
		return 0
	else
		return 1
fi
}

# Check if there currect amount of values
	if [ $# -lt 2 ] # Less then 2
	then
		echo "There Less Then 2 Arguments"
		output_to_screen 7 
		exit 7
	fi

dir_path=$1
program=$2
shift 2
arguments=$@

# Print First Line
echo "BasicCheck.sh $dir_path <$program> $arguments"
			
# Search for Makefile
cd $dir_path
find Makefile >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		make >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			step3 $program $arguments
		else
			output_to_screen 7
		fi
	else
		
		output_to_screen 7 
	fi
