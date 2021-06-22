# 조건에 맞는 data만 추출
library(dplyr)
exam <- read.csv("./data/csv_exam.csv")
head(exam)
dim(exam)

exam %>% filter(class==2)
exam %>% filter(class==2 & english>=80)
exam %>% filter(math>=90 | english>=90)


# 필요한 col추출 (select)
exam %>% select(math)
exam %>% select(english)
# math만 빼고 다 선택 
exam %>% select(-math)


#filter & select 조합해서 사용
exam %>% filter(class==1) %>% select(english)

# select 한 걸 head로 몇개만 보기
exam%>% select(id,math) %>% head



# 정렬
exam %>% arrange(math) # 오름차순 
exam %>% arrange(desc(math), english) # 내림차순


# 새로운 column 생성해주기 
exam %>% mutate(total=math+english+science, mean=(math+english+science)/3,
                test=ifelse(science >=60, "pass","fail")) %>% head(3)


exam %>% mutate(total=math+english+science, mean=(math+english+science)/3,
                test=ifelse(science >=60, "pass","fail")) %>% arrange(desc(total)) %>% head(3)

# 집단 별 요약
exam %>% summarise(mean_math=mean(math))


# Group by 
exam %>% group_by(class) %>% summarise(mean_math=mean(math))
exam %>% group_by(class) %>% summarise(mean_math=mean(math),
                                       sum_math=sum(math),
                                       median_math=median(math),
                                       n=n()) #갯수

# 데이터프레임 합치기
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm=c(60,80,70,90,85))

# 기말고사 점수
test2 <- data.frame(id=c(1,2,3,4,5),
                    final=c(70,83,65,95,80))
test1
test2

# id기준으로 합치기
total <- left_join(test1,test2,by="id")
total

# teacher
name<- data.frame(class=c(1,2,3,4,5),
                  teacher=c("kim","lee","park","choi", "jung"))

exam
name

exam_new<- left_join(exam,name, by="class")
exam_new


# column으로 합치기
group_a<- data.frame(id=c(1,2,3,4,5),
                     test=c(60,80,70,90,85))
group_b<- data.frame(id=c(6,7,8,9,10),
                     test=c(70,83,65,95,80)
)
group_all<-bind_rows(group_a,group_b)
group_all





