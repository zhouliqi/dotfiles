#!/bin/bash


CMD="make project1"
LOG_DIR="/home/zhouliqi/log"


# create log directory in home if it not exists.
if [[ ! -d $LOG_DIR ]]; then
    echo "create $LOG_DIR"
    mkdir $LOG_DIR
fi


trap finish SIGINT

finish() {
    echo "ctrl + c: exit bash script"
    exit
}


echo -e "\n\033[32m\n\t\t$0 start at $(date "+%Y-%m-%d %H:%M:%S")\033[0m"
echo -e "\n\033[32m\t\tRunning test $CMD for $1 iters\n\033[0m"


for i in $(seq 1 $1); do

    LOG_FILE="$LOG_DIR/tinykv_$i.log"

    # clear previous content of log
    date "+%Y-%m-%d %H:%M:%S" > $LOG_FILE

    printf "Test Round $i: "
    sep="---------------------------------------------------------------"
	printf "\n\n\n$sep Test Round: $i $sep\n\n\n" >> $LOG_FILE

    /usr/bin/time -f "\treal time [%es]" $CMD >> $LOG_FILE
    

    if [[ $? -ne 0 ]]; then
        echo "Test failed at Round $i"
    fi

done
