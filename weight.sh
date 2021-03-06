#!/bin/bash

FILENAME="my_records"
today=$(date +'%a %d %m %Y')
if [ ! -d "$HOME/.local/share/health" ]
then
	mkdir "$HOME/.local/share/health"
fi

if [ ! -d "$HOME/.local/share/health/weight" ]
then
	mkdir "$HOME/.local/share/health/weight"
fi

DATA_PATH="$HOME/.local/share/health/weight/$FILENAME" 
weight=""
chest=""
hip=""
thigh=""
waist=""
while getopts "c:ht:w:W:H:sr" option;do
	case $option in
		c)
				chest=$OPTARG
			;;
		H)
			hip=$OPTARG
			;;
		t)
			thigh=$OPTARG
			;;
		w)
			weight=$OPTARG
			;;
		W)
			waist=$OPTARG
			;;
		s)
			if [ -f $DATA_PATH ]
			then 
				lines=$(wc -l < $DATA_PATH)
				if [ $lines -gt 15 ]
				then
					echo "DATE				WEIGHT		WAIST		HIP		CHEST"
					echo "-----------------------------------------------------------------------------------------"

				fi
				tail $DATA_PATH
			else
				echo "No records"
			fi
			exit 0
			;;
		r)
			rm $DATA_PATH
			exit 0
			;;
		h)
			echo "Syntax: scriptTemplate [-c|H|t|w|W|s|r|h]"
			echo "options:"
			echo "c     Record chest circumference measurement in cm."
			echo "H     Record hip circumference measurement in cm."
			echo "w     Record weight circumference measurement in kg."
			echo -e "W     Record Waist circumference measurement in cm"
			echo ""
			echo "s     Show last 15 records"
			echo "r     Remove all records"
			echo "h     Help."

			exit 0
			;;
		\?)
			echo "$OPTARG : option invalide"
			exit 1
			;;
	esac
done

if [ ! -f $DATA_PATH ]
then
	echo "DATE				WEIGHT		WAIST		HIP		CHEST" > $DATA_PATH
	echo "-----------------------------------------------------------------------------------------" >> $DATA_PATH
	
fi
echo "$today			$weight		$waist		$hip	$chest" >> $DATA_PATH
exit 0