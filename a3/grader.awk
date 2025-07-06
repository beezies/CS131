# function to calculate the average based on a total score
function calc_avg( sum ) {
	avg = sum / 3
	return avg
}
# skip the header line
NR == 1 { next }
# for each line, add an array entry indexed by the student's name that contains the sum of their scores
BEGIN { FS=","; min = 500; max = -1 }
{ 
	grades[$2] = $3 + $4 + $5
	# keep track of the highest and lowest scoring students
	if (grades[$2] > max) { max = grades[$2]; max_name = $2 } 
	if (grades[$2] < min) { min = grades[$2]; min_name = $2 }
} END {
	# for each student in the array, calculate the average and print their grade information
	for (student in grades) {
		avg = calc_avg(grades[student])
		print "Student", student, "has a total score of",  grades[student], "and an average of", avg, "-- Status:"  
		print (avg >= 70) ? "PASS" : "FAIL"
	}
	# print min and max students
	print "\nMax score:", max_name, "with", max, "total points."
        print "\nMin score:", min_name, "with", min, "total points."
}	
