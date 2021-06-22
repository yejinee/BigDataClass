midwest<-as.data.frame(ggplot2::midwest)
install.packages('dplyr')
library(dplyr)

# 1. Data의 특성 파악
head(midwest)
tail(midwest)
dim(midwest) #차원 확인
# L 데이터가 437개 28개의 속성으로 이루어짐을 알수 있음 
str(midwest) #속성 확인
summary(midwest) #요약(기술) 통계


# 2. column명 수정 (poptotal를 total로)
midwest<- rename(midwest,total=poptotal)
# popasian을 asian으로
midwest<- rename(midwest,asian=popasian)

# 3. 파생변수 생성
midwest$percentasian<- (midwest$asian/midwest$total)*100
head(midwest$percentasian)
hist(midwest$percentasian)

# 4. 백분율 , 전체 평균 비교
mean(midwest$percentasian)
midwest$group<- ifelse(midwest$percentasian>mean(midwest$percentasian),"large","small")
head(midwest$group)


# 5. 빈도수 확인
table(midwest$group)
qplot(midwest$group)
