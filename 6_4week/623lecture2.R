library(ggplot2)
library(dplyr)
mpg

# 1. 배경 설정
ggplot(data=mpg, aes(x=displ,y=hwy))
# 2. 그래프 설정
# xlim => x에 대한 제한
# ylim => y에 대한 제한
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point()
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point()+xlim(3,6)+ylim(10,30)

# ggplot = matplotlib : 전처리 시 신속히 시각화
# ggplot = seaborn # 최종 보고용 , 분석 결과


# 집단 간 평균 막대그래프
df_mpg <- mpg %>% group_by(drv) %>%summarise(mean_hwy=mean(hwy))
df_mpg

ggplot(data=df_mpg, aes(x=reorder(drv,-mean_hwy), y=mean_hwy))+geom_col()

# 히스토그램 그래프
ggplot(data = mpg, aes(x=drv))+geom_bar()
ggplot(data=mpg, aes(x=hwy))+geom_bar()


# 평균막대그래프
# 데이터를 요약한 평균표를 먼저 만들고 그래프 생성 (geom_col())

# 빈도막대그래프
# 별도로 표 만들지 않고 그래프 생성 (geom_bar())


# Q1) suv차종에서 어떤 회사가 도시 연비가 높은지? (상위 5개 정리)
df <-mpg %>% filter(class=='suv') %>% group_by(manufacturer) %>%
            summarise(mean_cty=mean(cty)) %>% arrange(desc(mean_cty)) %>% head(5)

df

ggplot(data=df, aes(x=reorder(manufacturer, -mean_cty), y=mean_cty))+geom_col()

# Q2) 자동차 종류 (class) 빈도 그래프
ggplot(data = mpg,aes(x=class))+geom_bar()


# 선그래프
# 시계열 데이터를 표현할 때 
economics
ggplot(data=economics,aes(x=date, y=unemploy))+geom_line()

# 개인 저축률(psavert) 데이터를 선그래프로 표현
ggplot(data=economics, aes(x=date, y=psavert))+geom_line()

# 상자 그림 , boxplot
ggplot(data=mpg,aes(x=drv,y=hwy))+geom_boxplot()

# 차 종류가 compact, subcompact, suv인 도시연비 비교
class_mpg <-mpg %>% filter(class %in% c("compact", "subcompact","suv"))
class_mpg

ggplot(data=class_mpg, aes(x=class,y=cty))+geom_boxplot()

# geom_point() : 산점도
# geom_col() : 막대그래프 - 요약표
# geom_bar() : 막대그래프 - 원자료
# geom_line() : 선그래프 (시계열 data)
# geom_boxplot() : 상자그림 (데이터 분포, 이상치, 편향)


