#https://1xbet.whoscored.com/Players/300713/History/Kylian-Mbapp%C3%A9
#https://1xbet.whoscored.com/Regions/252/Tournaments/2/Seasons/7811/Stages/17590/PlayerStatistics/England-Premier-League-2019-2020
#https://1xbet.whoscored.com/Regions/108/Tournaments/5/Seasons/7928/Stages/17835/PlayerStatistics/Italy-Serie-A-2019-2020
#https://1xbet.whoscored.com/Regions/206/Tournaments/4/Seasons/7889/Stages/17702/PlayerStatistics/Spain-LaLiga-2019-2020
#https://1xbet.whoscored.com/Regions/81/Tournaments/3/Seasons/7872/Stages/17682/PlayerStatistics/Germany-Bundesliga-2019-2020
#https://1xbet.whoscored.com/Regions/74/Tournaments/22/Seasons/7814/Stages/17593/PlayerStatistics/France-Ligue-1-2019-2020
#동적 크롤링으로 선수 이름 검색->히스토리->지난시즌 리즈 평점 긁어오기?
#or 각 리그별 url 수동으로 주고 지난시즌 선수들 평점 전체 긁어 온 후 시장가치 탑 500에 없는 선수 삭제하기

'''
https://1xbet.whoscored.com/Search/?t=mbappe 여기서 ?t 다음에 변수로 놓고 트랜스퍼 마켓에서 갖고온 선수이름 하나씩 검색 후
<a href="/Players/300713/Show/Kylian-Mbappé" class="iconize iconize-icon-left"><span class="ui-icon country flg-fr"></span>Kylian Mbappé</a>이거(이름버튼) 실행 명령
그다음 <a href="/Players/300713/History/Kylian-Mbappé" class="">History</a> 이거(hitory 버튼) 실행
그다음 2019/2020시즌의 평균평점, <td class="rating   ">8.14</td> 긁어 오기
이걸 트랜스퍼마켓에서 갖고온 선수이름으로 전체 반복


#selenium 시도..
name='mbappe'
url='https://1xbet.whoscored.com/Search/?t='

#url+name
from selenium import webdriver
 
# 내려받은 chromedriver의 위치
driver = webdriver.Chrome('/Users/DongJinS/Desktop/R을 이용한 빅데이터 분석/프로젝트!!!/chromedriver')
# 웹 자원 로드를 위해 3초까지 기다린다.
driver.implicitly_wait(3)
 
#url접근
driver.get(url+name)
'''
#beautifulsoup시도
import requests
from bs4 import BeautifulSoup

url = "https://1xbet.whoscored.com/Search/?t="
name='mbappe'

webpage=requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
soup = BeautifulSoup(webpage.content, "html.parser")

print(soup)
