# Ex
df_raw<-data.frame(var1=c(1,2,3), var2=c(2,3,2))
df_raw

# data 복사해서 작업하는 것이 제일 좋음 
df_new<-df_raw
df_new

# var2를 v2로 변경
df_name<-rename(df_new, v2=var2)
df_name

df_raw
df_new


df<-data.frame(var1=c(4,3,8), var2=c(2,6,1))
df

# 각 row별 total 구하기(var1+var2)
df$var_sum<- df$var1+df$var2
df

df$var_mean<- (df$var1+df$var2)/2
df


# 1. mpg data 불러오기
mpg<-as.data.frame(ggplot2::mpg)
install.packages('dplyr')
library(dplyr)

# 2. data 파악
head(mpg)
tail(mpg)
View(mpg)
dim(mpg) #차원 확인
str(mpg) #속성 확인
summary(mpg) #요약(기술) 통계

# 3. column명 수정 (cty를 city로)
mpg<- rename(mpg,city=cty)


# 4.new column 추가
mpg$total<-(mpg$cty+mpg$hwy)/2
mpg

# 4-1. total에 대한 summary 확인 
summary(mpg$total)
# ㄴ평균과 중앙값이 비슷함으로 좌우대칭의 구조를 가짐
hist(mpg$total)
# ㄴ 분포가 제일 많은 부분 파악 


# 5. 조건문 사용
# 20보다크면 pass, 아니면 fail
ifelse(mpg$total>=20,"pass","fail")
mpg$test<-ifelse(mpg$total>=20,"pass","fail")
tail(mpg,3)

# 5-1.빈도 구하기
table(mpg$test)

# 5-2. visualization
qplot(mpg$test)

# 6. A등급 : 30이상, B등급: 20~29, C등급: 20 미만
mpg$grade <-ifelse(mpg$total>=30, "A", ifelse(mpg$total>=20,"B","C"))
head(mpg,3)

# 6-1. 빈도 확인
table(mpg$grade)
qplot(mpg$grade)

