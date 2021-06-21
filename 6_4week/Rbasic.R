 # 여러 데이터로 구성된 변수 선언 (list와 같음)
var <- c(1,2,3,4,5)
var
var1 <- c(1:5)
var1
# range 대신
var2<- seq(1,4)
var2
var3<- seq(1,10,by=2)
var3

a<- c(7, 4, 2, 3, 2, 5, 1, 12, 7, 5, 6 )
sum(a)

# 각 var값에 대해서 더하기(행렬의 덧셈)
var+var1

# 각 var값에 대해서 원소값들에 전부 +2
var+2


str<-"a"
str

str4<- c("hello","world","is","good")
str4


# list에 있는 문자들 합쳐줌
paste(str4,collapse = ',')


# load package
# ggplot2 package
install.packages("ggplot2")
library(ggplot2)


x<-c('a','b','c','d','a','d')
x
qplot(x)




# 5명 학생이 시험점수 담을 변수 선언
score<-c(80,60,70,50,90)
saverage=mean(score)
saverage



# DataFrame
english <- c(90,80,60,70)
english
math<-c(50,60,100,20)
math

class<- c(1,1,2,2)
class

df_midterm<-data.frame(english,math,class)
df_midterm


# 각 column별 처리 ($사용)
mean(df_midterm$english)



df_midterm<-data.frame(english=c(90,80),
                       math=c(50,60),
                       class=c(1,2))
df_midterm


#Practice1 )
df_fruit<-data.frame('제품'=c('사과','딸기','수박'),
                     '가격'=c(1800,1500,3000),
                     '판매량'=c(24,38,13))
df_fruit

mean(df_fruit$가격)
mean(df_fruit$판매량)




# 외부 데이터 이용
install.packages('readxl')
library(readxl)

df_exam<-read_excel('C:\\Users\\admin\\rfile\\excel_exam.xlsx')
df_exam

# excel file 첫번쨰 행이 column명이 아닌경우
df_novar<-read_excel('C:\\Users\\admin\\rfile\\excel_exam_novar.xlsx', col_names=FALSE)
df_novar

# excel file에 sheet가 여러개 있는 경우
df_sheet<-read_excel('C:\\Users\\admin\\rfile\\excel_exam_sheet.xlsx', sheet=3)
df_sheet


# csv 읽기
df_csv<- read.csv('C:\\Users\\admin\\rfile\\csv_exam.csv')
df_csv


# 문자가 들어있는 파일을 불러 올 때 stringAsFactors=F
# 문자를 읽을 때 설정 안하면 list형식으로 1개씩 읽어옴
df_csv<- read.csv('C:\\Users\\admin\\rfile\\csv_exam.csv', stringsAsFactors = F)
df_csv

# dataframe을 csv파일로 저장
write.csv(df_midterm, file='./data/df_midterm.csv')

# RData file 이용
save(df_midterm, file='./data/df_midterm.rda')
# dataframe 삭제
rm(df_midterm)
df_midterm

# rda file불러오기
load('./data/df_midterm.rda')
df_midterm


