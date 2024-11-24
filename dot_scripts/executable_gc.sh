#!/bin/bash

# Function to generate a random number within a given range
generate_random_number() {
	min=$1
	max=$2
	echo $(($min + RANDOM % ($max - $min + 1)))
}

# Read the input file and get the current date and time
input_file="datetime.txt"
temp_file="temp.txt"
new_time=""

# Check if the input file exists
if [[ -f "$input_file" ]]; then
	# Read the current date and time from the file while preserving leading zeros
	IFS=" " read -r -a datetime_components <"$input_file"
	day_of_week=${datetime_components[0]}
	month=${datetime_components[1]}
	day=${datetime_components[2]}
	time=${datetime_components[3]}
	year=${datetime_components[4]}

	# Check if the date and time components are present
	if [[ -n "$day_of_week" && -n "$month" && -n "$day" && -n "$time" && -n "$year" ]]; then
		# Truncate the day of the week to the first three letters
		truncated_day_of_week=$(echo "$day_of_week" | cut -c 1-3)

		# Format the date and time into a compatible format
		formatted_datetime=$(printf "%s %s %s %s %s" "$truncated_day_of_week" "$month" "$day" "$time" "$year")

		# Convert formatted date and time to seconds since the epoch
		epoch_seconds=$(date -j -f "%a %B %e %T %Y" "$formatted_datetime" "+%s")

		# Increment the seconds by a random number
		random_increment=$(generate_random_number 1920 6969)

		incremented_seconds=$((epoch_seconds + random_increment))

		# Calculate the updated date and time components
		incremented_datetime=$(date -r "$incremented_seconds" "+%a %B %e %T %Y")

		# Extract the updated date and time
		IFS=" " read -r updated_day_of_week updated_month updated_day updated_time updated_year <<<"$incremented_datetime"

		# Print the original date and time and the incremented date and time
		echo "Original Datetime: $day_of_week $month $day $year $time"
		echo "Incremented Date: $updated_day_of_week $updated_month $updated_day $updated_time $updated_year"

		new_time="$updated_day_of_week $updated_month $updated_day $updated_time $updated_year"

		# Write the updated date and time to a temporary file
		printf "%s %s %s %s %s\n" "$updated_day_of_week" "$updated_month" "$updated_day" "$updated_time" "$updated_year" >"$temp_file"

		# Replace the original file with the temporary file
		mv "$temp_file" "$input_file"
		echo "Updated date and time written to file."
	else
		echo "One or more components are missing in the file."
	fi
else
	echo "File not found: $input_file"
fi

echo "The new time is: $new_time"
GIT_AUTHOR_DATE="$new_time -0700" GIT_COMMITTER_DATE="$new_time -0700" git commit

# GIT_AUTHOR_DATE="Tue January 9 14:02:21 2024 -0700" GIT_COMMITTER_DATE="Tue January 9 14:02:21 2024 -0700" config commit
