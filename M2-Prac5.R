# Practical 5: Independent Two-Sample t-test using CSV data

# Import student mental health dataset
mental_health <- read.csv("Cleaned_Student_Mental_Health.csv")

# Verify column names
colnames(mental_health)

# Comparing Stress Level between Male and Female students
t.test(Stress_Level ~ Gender, data = mental_health)
