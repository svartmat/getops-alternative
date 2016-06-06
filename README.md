# getops-alternative
Argument parsing for command line scripts in linux

This function will:

Store the original data in a globally available variable called "$ORIGINAL_LINE"
Extract all operands by retrieving all data received before a "-" sign (which marks the start of option and option arguments).
Note: This is opposite to the guideline 9 of  Utility Syntax Guidelines IEEE Std 1003.1.
Save all operands in a variable called  $POSITIONAL
Count the number of operands and store the result in a variable called $POSITIONAL_NUM
Store all option and option-arguments received in the variable $ALL_PARAMETERS 
Loop trough all options and their respective arguments creating for each a variable PARAM_${VARIABLE_NAME} that contains the arguments (if any) and another called   PARAM_NUM_${VARIABLE_NAME} with the number of elements received.
A working example is:

If a script to deploy configuration called deployConf.ksh is invoked like this:

./ deployConf.ksh default -d on -q tx01 tx02 --group group1 group2 –p

And inside the script the options are passed on to the argParser function:

argParser "default -d on -q tx01 tx02 --group group1 group2 –p" 

The below variables are created for the developer to handle them as required

POSITIONAL=default
POSITIONAL_NUM=1
PARAM_d=on
PARAM_NUM_d=1
PARAM_group=group1 group2
PARAM_NUM_group=2
PARAM_q=tx01 tx02
PARAM_NUM_q=2
PARAM_p=
PARAM_NUM_p=0

The base standard followed for the development of the tool is the same as getopts: POSIX.1-2008 Utility Syntax Guidelines IEEE Std 1003.1, but there are differences on the guidelines followed to accommodate my purposes.
