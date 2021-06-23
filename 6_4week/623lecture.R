# 결측치 정제 작업
# 결측치 만들기
df<-data.frame(sex=c("M","F","NA","M","F"),
               score=c(5,4,3,4,NA))
df

# 결측치 확인
is.na(df)
table(is.na(df)) # 결측치 갯수 확인

table(is.na(df$sex))
table(is.na(df$score))


# 결측치 행 제거 
library(dplyr)
df_nomiss <- df%>% filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss<-df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

# 모든 column에 결측치 없는 데이터 추출
df_nomiss2 <- na.omit(df)
df_nomiss2

# 결측치 빼고 계산 
mean(df$score, na.rm =TRUE)


exam <- read.csv("./data/csv_exam.csv")
# 3,8,15 행의 math column에 NA값 대입
exam[c(3,8,15),"math"] <-NA

exam %>% summarise(mean_math=mean(math))
# 결측치 빼고 계산 
exam %>% summarise(mean_math=mean(math,na.rm = T))
exam %>% summarise(mean_math=mean(math,na.rm = T),
                   sum_math= sum(math,na.rm=T),
                   median_math=median(math,na.rm=T))

# 결측치 대체법
# - 대표값 (평균, 최빈값 , 중앙값, 강중평균 ....)
# - 통계 분석 기법 적용 , 예측값 추정해서 대체

# 평균 결측치 제거
m_math<-mean(exam$math, na.rm=T)
exam$math <- ifelse(is.na(exam$math), m_math, exam$math)
table(is.na(exam$math))
mean(exam$math)
# 결측치를 채우기 전과 후의 평균값이 크게 달라지면 안됌
# 원래 데이터의 속성에 벗어나지 않게 결측치를 채워야함 


# 2. 이상치 처리
# 정상범주에서 크게 벗어난 값 
outlier<-data.frame(sex=c(1,2,1,3,2,1),
                    score=c(5,4,3,4,2,6))
# 이상치 확인
table(outlier$sex)
table(outlier$score)

# 이상치 제거
# 1. NA로 바꿔놓고 참조하면서 쓰는 경우(안정적)
# 2. 지우고 처리하는 경우 
outlier$sex <- ifelse(outlier$sex ==3, NA, outlier$sex)
outlier

# 이상치 제거 SCORE 1-5 범위가 아닌 값 
outlier$score <- ifelse(outlier$score >5, NA, outlier$score)
outlier

# 남여 별 score 평균 구하기
outlier %>% filter(!is.na(sex) & !is.na(score)) %>% group_by(sex) %>% summarise(mean_score=mean(score))





