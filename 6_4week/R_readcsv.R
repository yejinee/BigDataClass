exam<-read.csv("./data/csv_exam.csv")
head(exam)
head(exam,3)

tail(exam)
tail(exam,3)

# row, column 수
dim(exam)
# dataframe의 column들이 어떤 type으로 인식되는지 확인 가능
str(exam)

summary(exam)

# mpg data 이용한 기술 통계 함수 사용
# ggplot package안에 있음



mpg<-as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)
View(mpg)
# 234 row와 11column으로 이루어짐
dim(mpg)
str(mpg)
summary(mpg)
# data를 해석할 때 전문가의 의견을 요함 ( 내가 알 수 없음 )