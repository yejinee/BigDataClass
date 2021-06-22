mpg<-as.data.frame(ggplot2::mpg)
library(dplyr)

# practice 1
mpg_displ_4<- mpg %>% filter(displ<=4)
mpg_displ_5<- mpg %>% filter(displ>=5)
mean(mpg_displ_4$hwy)
mean(mpg_displ_5$hwy)

# 02
mpg_audi <-mpg %>% filter(manufacturer=="audi")
mpg_toyota <- mpg %>% filter(manufacturer=="toyota")
mean(mpg_audi$cty)
mean(mpg_toyota$cty)



# 03
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford","honda"))


# practice 2
# 1) column 선택 (cty, class)
mpg <- as.data.frame(ggplot2::mpg)
df <- mpg %>% select(class,cty)
head(df,3)

# 02) 
df_suv <- df %>% filter(class=="suv")
df_compact <- df %>% filter(class =="compact")
mean(df_suv$cty)
mean(df_compact$cty)

# 03)
mpg %>% filter(manufacturer=="audi") %>% arrange(desc(hwy))%>% head(5) ->a
a


# Practice 3
# q. hwy +cty 해서 1개의 변수 사용
# 1. mpg data 복사본 만들기 & cty +hwy 합한 변수 추가
cmpg<-mpg
head(cmpg)

cmpg<- cmpg %>% mutate(total=cty+hwy)

# 2. 변수를 2로 나워 평균 연비 변수 추가
cmpg <- cmpg %>% mutate(mean=total/2)

# 3. 평균연비 변수가 가장 높은 자동차 3개 출력
cmpg %>% arrange(desc(mean)) %>% head(3)

# 4. 하나로 연결된 dplyr 구문 출력
mpg %>% mutate(total=cty+hwy, mean=total/2)%>% arrange(desc(mean))%>% head(3)


# practice 5
# 회사별로 'suv'자동차의 도시 및 고속도로 통합 연비 평균 구해 
# 내림차순으로 정렬, 1-5위까지 출력

mpg %>% group_by(class) %>% summarise(mean_cty = mean(cty)) %>% arrange(desc(mean_cty))



# practice 6
# mpg data에 연료 가격 합치기
fuel <- data.frame(fl=c("c","d","e","p","r"),
                   price_fl=c(2.35,2.38,2.11,2.76,2.22),
                   stringsAsFactors = F)
fuel

mpg_new <- left_join(mpg,fuel,by="fl")
head(mpg_new,3)

mpg_new %>% select(model,fl,price_fl) %>% head(3)
