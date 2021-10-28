#data_name=read.csv("C:/Users/DongJinS/Desktop/R을 이용한 빅데이터 분석/프로젝트!!!/크롤링 데이터 원본/transfermarket_name.csv")
####웹크롤링 데이터 하나로 만들어서 저장하기####
data_name=read.csv("transfermarket_name(11월28일 크롤링).csv")
data_age=read.csv("transfermarket_age(11월28일 크롤링).csv")
data_m=read.csv("transfermarket_marketvalue(11월28일 크롤링).csv")
total_data<-data.frame()
total_data<-cbind(data_name,data_age)
total_data<-cbind(total_data,data_m)
total_data<-total_data[,-c(1,3,5)]
colnames(total_data)<-c("name","age","marketvalue")
write.csv(total_data,file="종합 선수 데이터.csv")

####크롤링 및 수기 입력 데이터 읽어오기 및 전처리#####
full_data_withTimeRating=read.csv("종합 선수 데이터+평점&출전시간 수기 완료(11월28일 크롤링)+Euro&m제거.csv")
full_data_withTimeRating<-full_data_withTimeRating[,-c(1)]
colnames(full_data_withTimeRating)<-c('name',"age","marketvalue(€)(M)",'19/20 league playing time(min)','19/20 league mean rating')
full_data_withTimeRating$`19/20 league playing time(min)`<-as.integer(full_data_withTimeRating$`19/20 league playing time(min)`)
typeof(full_data_withTimeRating$`19/20 league playing time(min)`)
full_data_withTimeRating$`19/20 league mean rating`<-as.double(full_data_withTimeRating$`19/20 league mean rating`)
typeof(full_data_withTimeRating$`19/20 league mean rating`)
typeof(full_data_withTimeRating$`marketvalue(€)(M)`)


####경기시간 1000시간 미만 데이터행 삭제####

full_data_withTimeRating$`19/20 league playing time(min)`<-ifelse(full_data_withTimeRating$`19/20 league playing time(min)`<1000,NA,full_data_withTimeRating$`19/20 league playing time(min)`)

####나이 20살 미만 데이터 행 삭제####
#full_data_withTimeRating$`age`<-ifelse(full_data_withTimeRating$`age`<20,NA,full_data_withTimeRating$`age`)


####결측값제거#####

sum(is.na(full_data_withTimeRating))
full_data_withTimeRating<-na.omit(full_data_withTimeRating)
summary(full_data_withTimeRating)

####그래프 그려보기####
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("plotly")
library(plotly)


plot(full_data_withTimeRating[,2:5])

install.packages("corrplot")
library(corrplot)
c<-cor(full_data_withTimeRating[,2:5])
corrplot(c,tl.srt=20,method="square")
corrplot(c,tl.srt=20,method="number")

c

g1<-ggplot(data=full_data_withTimeRating ,aes(y=`marketvalue(€)(M)`, x=`19/20 league mean rating`))+geom_point()
g2<-ggplot(data=full_data_withTimeRating ,aes(y=`marketvalue(€)(M)`, x=`19/20 league playing time(min)`))+geom_point()
g3<-ggplot(data=full_data_withTimeRating ,aes(y=`marketvalue(€)(M)`, x=`age`))+geom_point()
ggplotly(g1) 
ggplotly(g2) 
ggplotly(g3) 
ggplot(data=full_data_withTimeRating ,aes(x=`marketvalue(€)(M)`, y=`19/20 league mean rating`))+geom_point()
ggplot(data=full_data_withTimeRating ,aes(x=`marketvalue(€)(M)`, y=`19/20 league playing time(min)`))+geom_col()
ggplot(data=full_data_withTimeRating ,aes(x=`marketvalue(€)(M)`, y=(`age`)))+geom_point()
ggplot(data=full_data_withTimeRating ,aes(x=`19/20 league mean rating`))+geom_boxplot()
ggplot(data=full_data_withTimeRating ,aes(x=`19/20 league mean rating`))+geom_boxplot()
ggplot(data=full_data_withTimeRating ,aes(x=`marketvalue(€)(M)`))+geom_boxplot()
ggplot(data=full_data_withTimeRating ,aes(x=`age`))+geom_boxplot()



####상관계수 분석####
summary(full_data_withTimeRating$`marketvalue(€)(M)`)
summary(full_data_withTimeRating$`19/20 league mean rating`)

cor(full_data_withTimeRating[,2:5])
attach(full_data_withTimeRating)

cor(`19/20 league mean rating`,`marketvalue(€)(M)`)
cor(`19/20 league playing time(min)`,`marketvalue(€)(M)`)
cor(`age`,`marketvalue(€)(M)`)
cor(`age`,`19/20 league mean rating`)

cor.test(`19/20 league mean rating`,`marketvalue(€)(M)`)
cor.test(`19/20 league playing time(min)`,`marketvalue(€)(M)`)
cor.test(`age`,`marketvalue(€)(M)`)
cor.test(`age`,`19/20 league mean rating`)
cor.test(`age`,`19/20 league playing time(min)`)
cor.test(`19/20 league playing time(min)`,`19/20 league mean rating`)

#...상관계수 현재 평균평점x시장가치&평균출전시간x시장가치 유의하게 나옴.

####가설검정####
#가설1.평균 평점으로 정렬한 뒤 반으로 나뉜 두 그룹의 시장가치는 차이가 있다.(평균 평점이 높은 그룹의 시장가치가 더 높다.)
desc_rating<-full_data_withTimeRating%>%arrange(desc(`19/20 league mean rating`))
mv_over<-desc_rating$`marketvalue(€)(M)`[1:218]
mv_under<-desc_rating$`marketvalue(€)(M)`[219:436]

var.test(mv_over,mv_under)
t.test(mv_over,mv_under,paired=FALSE, var.equal=FALSE)
#두 그룹간 평균 시장가치 차이 있음->평균 평점이 높은 선수들의 시장가치가 더 높다.

#가설2.시장가치로 정렬되어 반으로 나뉜 두 그룹의 지난시즌 평균 평점에는 차이가 있을 것이다. (시장가치가 높으면 지난 시즌 평균 평점이 높을 것이다.)
r_over <- full_data_withTimeRating$`19/20 league mean rating`[1:218]
r_under<- full_data_withTimeRating$`19/20 league mean rating`[219:436]

var.test(r_over,r_under)
t.test(r_over,r_under,paired=FALSE, var.equal=FALSE)
#두 그룹간 평균 차이있음->시장가치가 높은 선수들의 평균 평점이 더 높다.


#가설3. (지난 시즌 출전시간이 많으면 시장가치가 높을 것이다.)
desc_playing<-full_data_withTimeRating%>%arrange(desc(`19/20 league playing time(min)`))
p_over<-desc_playing$`marketvalue(€)(M)`[1:218]
p_under<-desc_playing$`marketvalue(€)(M)`[219:436]

var.test(p_over, p_under)
t.test(p_over,p_under,paired=FALSE, var.equal=TRUE)
#두 그룹간 평균 시장가치 차이 있음.->출전시간 많으면 시장가치 높다.

####회귀분석####
#나이는 지난 시즌 평점과 출전시간과 상관을 갖고 있어 독립변수 요건을 맞추지 못하여 뺌.
fit<-lm(`marketvalue(€)(M)`~`19/20 league mean rating`+`19/20 league playing time(min)`)
summary(fit)
#유의하지 않은 출전시간 독립변수에서 제거
fit2<-lm(`marketvalue(€)(M)`~`19/20 league mean rating`)
summary(fit2)
plot(x=`19/20 league mean rating`,y=`marketvalue(€)(M)`)
abline(fit2,col="red")
fitted(fit2)[1:4]