
######################################################################
# [건강정보 데이터 분석] 03. 변수간 관계특성 분석
######################################################################


# --------------------------------------------------
# 데이터셋 준비
# --------------------------------------------------

# 데이터셋 파일 로딩
# --------------------------------------------------

# readr::read_delim() 함수이용 티블형식으로 로딩

my<-read_delim(file="./data/cancer.csv", col_names=T,
               delim=",", trim_ws = T,
               na=c(".","?","NA"))



# 간단 데이터셋 파악
head(my)
tail(my)
str(my)

# --------------------------------------------------
# 결측값 처리
# --------------------------------------------------

# 변수컬럼별 결측값 규모파악
my %>% sapply(is.na) %>%colSums


# 각 변수별 중앙값 파악
sapply(my,median,na.rm=T)


# 각 변수별 중앙값을 각 변수별 NA마다 대체입력
my <- sapply(my,function(x) 
  ifelse(is.na(x),yes=median(x,na.rm=T), no=x)) %>%
  as.data.frame



# 변수컬럼별 결측값 규모 재파악



# --------------------------------------------------
# 변수 리코딩
# --------------------------------------------------


# 종양유형(class) 변수 리코딩
# --------------------------------------------------

# 종양유형변수 탐색



# 종양유형 변수인 class 변수컬럼 레이블 반영

my$class_c <- recodeVar(my$class,
                        src = c(2,4),
                        tgt = c('양성', '악성'))


# - benign: 양성, malignant: 악성


# 리코딩한 변수 기술통계 분석
# --------------------------------------------------
# 빈도수 계산
class_freq <- table(my$class_c) %>% sort(decreasing = T) %>% head(5) %>% print


# 비율 계산
class_prop <- class_freq %>% prop.table %>% sort(decreasing = T) %>% print


# 빈도수와 비율을 데이터프레임으로 조회
class_df <- data.frame(freq=c(class_freq), 
                       pect=c(round(class_prop*100,3))) %>% print


# 기술통계 분석
# janitor::tabyl() 함수이용
tabyl(my$class_c, sort=T) %>% print



# epiDisplay::tab1() 함수이용
tab1(my$class_c, sort.group='decreasing', cum.percent = T, main="class(중앙유형형) 분포")





# --------------------------------------------------
# 종양유형(class)에 따른 임상조직 세포특성차이 분석
# --------------------------------------------------

# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean) 1개

aggregate(thick ~class_c , my, mean)
aggregate(thick ~class_c , my, mean, na.rm=T)

aggregate(unisize ~ class_c, my, mean )
aggregate(unishape ~ class_c, my, mean )
aggregate(adhesion ~ class_c, my, mean )
aggregate(cellsize ~ class_c, my, mean )
# ...... (다 구하기 힘듬 )



# for 반복구문을 이용한 1:1 요약집계 자동화
names(my)
for (i in 2:9){
  aggregate(x=list(my[i]),
            by=list(my$class_c),
            FUN=mean) %>% print
  cat("\n")
}







# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 2개 이상 설정
# 요약집계 통계함수: 평균(mean) 1개
aggregate(cbind(thick, unisize, unishape) ~ class_c, my, mean)


# psych::describeBy() 이용 요약집계 작업
# --------------------------------------------------
psych:: densityBy(x=my[2:10], group=my$class_c)




# dplyr:: group_by()와 summarize() 이용 요약집계 작업
# --------------------------------------------------
my%>% filter(!is.na(thick)) %>% group_by(class_c) %>% 
  dplyr::summarize(thick_avg=mean(thick),
                   thik_std=sd(thick))

# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean), 표준편차(sd) 2개


psych::describeBy(x = my[2:10], group = my$class_c)
my %>%  filter(!is.na(thick)) %>% group_by(class_c) %>% dplyr::summarize(thick_avg = mean(thick),
                                                                         thick_std = sd(thick)) 





































