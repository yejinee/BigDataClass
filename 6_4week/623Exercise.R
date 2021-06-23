mpg<-as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"]<-NA

# Q1. drv별로 hwy평균이 어떻게 다른지 확인
# 결측치 있는지 확인
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# drv 별로 hwy평균 확인
mpg %>% filter(!is.na(hwy)) %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy,na.rm=T))

boxplot(mpg$hwy)$stats

# 통계적 기준의 이상치 처리
mpg$hwy <- ifelse(mpg$hwy <12 | mpg$hwy>37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg[c(10,14,58,93),"drv"] <-"k"
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42)



# x축 cty, y축 hwy 산점도 그리기
# 1. 배경 설정
ggplot(data=mpg, aes(x=cty,y=hwy))+geom_point()
