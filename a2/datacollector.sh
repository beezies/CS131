#!/bin/bash


echo -n "Please enter the URL to your desired CSV dataset -> "
read URL
echo "Retrieving dataset..."

FILE="$(wget -nv $URL 2>&1 |cut -d\" -f2)"

echo "File retrieved: $FILE"

if [[ $FILE == *.zip ]]; then
	DATA_DIR=$(basename $FILE .zip)
	echo "Unzipping..."
	unzip -o $FILE -d $DATA_DIR
	rm $FILE
	echo -e "\nDirectory generated: $DATA_DIR ; entering..."
	cd $DATA_DIR
fi

DATA_FILES=()
for i in *; do
	if [[ ($i == *.csv || $i == *.data || $i == *.train || $i == *.test) && $i != *processed* ]]; then
		DATA_FILES+=($i)
	fi
done

echo "Data files to parse: "
for file in "${DATA_FILES[@]}"; do
  printf "\t%s\n" "$file"
done
echo -e "\n"

crunch_numbers() {
	local file="$1"
	local delim="$2"
	local summary="$3"
	shift 3
	local headers=("$@")

	{
		echo
		echo "## Statistics (Numerical Features)"
		echo "| Index | Feature           | Min   | Max   | Mean  | StdDev |"
    		echo "|-------|-------------------|-------|-------|-------|--------|"
  	} >> $summary
	for i in "${!headers[@]}"; do
		index=$((i + 1))
		feature="${headers[$i]}"
		values=$(awk -F"$delim" -v col="$index" 'NF >= col {print $col}' "$file" | grep -E '^[0-9.+-]+$')
		if [[ -z "$values" ]]; then
			continue
		fi
		read min max mean stddev <<< $(echo "$values" | awk '
		{
			sum += $1
			sumsq += ($1)^2
			if (NR == 1 || $1 < min) min = $1
			if (NR == 1 || $1 > max) max = $1
			count++
		}
		END {
			mean = sum / count
			std = sqrt((sumsq / count) - (mean ^ 2))
			printf "%.2f %.2f %.3f %.3f", min, max, mean, std
		}')
		printf "| %-5s | %-17s | %-5s | %-5s | %-5s | %-6s |\n" \
     			 "$index" "$feature" "$min" "$max" "$mean" "$stddev" >> "$summary"
	done
	echo -e "|-------|-------------------|-------|-------|-------|--------|\n\n" >> $summary
	echo -e "\nFeature summary written to $summary_file -- "
	cat "$summary"
}

NAMES_FILES=(*.names)
for i in ${DATA_FILES[@]}; do
	echo "Parsing file $i -- "
	HEADERS=()
	first_line=$(head -n 1 $i | sed 's/["'\''"]//g')

	if [[ "$first_line" == *","* ]]; then
  		DELIM=","
	elif [[ "$first_line" == *$'\t'* ]]; then
		DELIM=$'\t'
	elif [[ "$first_line" == *";"* ]]; then
  		DELIM=";"
	elif [[ "$first_line" == *"|"* ]]; then
  		DELIM="|"
	else
  		DELIM=" "  # fallback: space
	fi

	num_cols=$(awk -F"$DELIM" 'NR==1 { print NF }' "$i")
	first_col_label=$(echo "$first_line" | cut -d ',' -f 1)
	second_col_label=$(echo "$first_line" | cut -d ',' -f 2)
    	if echo "$first_col_label" | grep -q '[A-Za-z]' && echo "$second_col_label" | grep -q '[A-Za-z]'; then	
		echo "Header detected: $first_line"
		IFS=$DELIM read -ra HEADERS <<< "$first_line"
	else
    		echo "No header in $i. Searching for .names file..."
		if [[ ${#NAMES_FILES[@]} -gt 0 ]]; then
			names_file=$(ls *.names | head -n 1)
			echo ".names file found: $names_file"
			mapfile -t HEADERS < <(
  			awk '
    			/^[0-9]\. Attribute Information/ {f=1; next}
    			/^[0-9]\. / && f {f=0}
    			f && /^[[:space:]]+[0-9]+[-.) :]/
  			' "$names_file" \
  			| sed -E 's/^[[:space:]]*[0-9]+[-.) :]+ *//'
			)
		fi
	fi
	if [[ ${#HEADERS[@]} -eq 0 ]]; then
		echo "Unable to extract column names (check dataset documentation for further insight) ; defaulting to numbered columns."
		for ((j = 1; j <= num_cols; j++)); do
			HEADERS+=("$j")
		done
	fi
	echo "COLUMN LABELS FOR $i : "
	printf '%s\n' "${HEADERS[@]}"
	summary_file="summary-${i%%.*}.md"

	{
	  	echo "# Feature Summary for $i"
  		echo
  		echo "## Feature Index and Names"
  		for h in "${!HEADERS[@]}"; do
    			index=$((h + 1))
    			echo "$index. ${HEADERS[$h]}"
  		done
	} > "$summary_file"
	
	crunch_numbers $i $DELIM $summary_file "${HEADERS[@]}"  
done
















