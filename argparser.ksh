#!/usr/bin/ksh
##############################################################################
# argparser
# This library is designed to receive a set of arguments and will return
# a variable with the positional parameters (which must be provided first)
# and a set of variables with the name PARAM_-name of the option-
# with its respective value that can be used in the main script.
# Another variable is returned PARAM_NUM_-name of the option- that has the 
# number of values received with every option and $POSITIONAL_NUM with the 
# number of positional parameters. 
#                                                    Luis Hernandez. 03/10/2015
###############################################################################

argParser() {
        ORIGINAL_LINE="$@"
# Look for character "-" to see if we received positional parameters
        FIRSTCHAR=`echo ${ORIGINAL_LINE} | cut -c1`
        if [[ ${FIRSTCHAR} != "-" ]]; then
# If we received positional parameters save them in the variable POSITIONAL
                POSITIONAL=`echo ${ORIGINAL_LINE} | awk -F' -' '{ print $1 }'`
        fi
# Count the positional parameters

        POSITIONAL_NUM=`echo ${POSITIONAL} | wc -w`

        if [[ ${POSITIONAL} == "" ]]; then
# If no positional parameters were received all parameters received are arguments
                ALL_PARAMETERS=${ORIGINAL_LINE}
        else
# If positional parameters were received remove them from the arguments line
                ALL_PARAMETERS=`echo ${ORIGINAL_LINE} | sed  "s/${POSITIONAL}//g"`
        fi
# Parse the arguments line
        echo "${ALL_PARAMETERS}" | sed -e 's/^-/\n/g' | sed -e 's/\ -/\n/g' |tail -n +2  | while read LINE
do
# Store the name of the variable
        VARIABLE_NAME=`echo ${LINE} | cut -d" " -f1`
        CUTVARIABLE=`echo ${VARIABLE_NAME} | cut -c1`
# Check if this is a "long" option and modify the variable if that's the case   
        if [[ ${CUTVARIABLE} == "-" ]]; then
                VARIABLE_NAME=`echo ${VARIABLE_NAME}|sed -r 's/^.{1}//'`
        fi
# Store the values of the arguments
        VALUES=`echo ${LINE} | cut -d" " --complement -s -f1`
        VALUES_NUMBER=`echo ${VALUES} | wc -w`
        eval PARAM_${VARIABLE_NAME}='${VALUES}'
        eval PARAM_NUM_${VARIABLE_NAME}='${VALUES_NUMBER}'
done
}
