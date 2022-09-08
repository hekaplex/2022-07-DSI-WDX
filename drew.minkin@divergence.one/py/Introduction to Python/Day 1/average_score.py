counter = 0
score_total = 0
test_score = 0
# != is "Not Equal To"
#while nobody enters 999(quit msg)
while test_score != 999:
#convert text input to integer
    test_score = int(input("Enter test score: "))
#check for valid range 
    if test_score >= 0 and test_score <= 100:
#       score_total = score_total + test_score
        score_total += test_score # add new score to sum of old scores
        counter += 1 # add another counter increment
#give graceful warning
    else:
        print("use numbers between 0 and 100")
#calculate average
average_score = round(score_total / counter)
#give feedback                
print("Total Score: " + str(score_total))
print("Average Score: " + str(average_score))
print("Number of Scores: " + str(counter))
