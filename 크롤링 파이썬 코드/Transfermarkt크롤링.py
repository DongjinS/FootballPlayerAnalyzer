import requests
from bs4 import BeautifulSoup

ran = range(1,21)#21까지 해야함
url = "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop?page="
url_list = []
n=''
m=''
name_mrktvalue=[]
name=[]
mrktvalue=[]
a=''
age=[]
i=0

for r in ran:
    url_list.append(url+str(r))
#print(url_list)

for url in url_list:
    webpage=requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
    soup = BeautifulSoup(webpage.content, "html.parser")
    #name, market value 갖고오기
    for x in range(0,50):
        if x/2!=0:
            m=(soup.select(".hauptlink")[x].get_text())
            name_mrktvalue.append(m)
        else:
            n=(soup.select(".hauptlink")[x].get_text())
            name_mrktvalue.append(n)
    #age 갖고오기
    for x in range(0,104):
        if x<4:
            pass
        else:#5,9,13 규칙 #x==5+4n
            if (x-5)%4==0:
                a=(soup.select(".zentriert")[x].get_text())
                age.append(a)                
    for x in range(50*i,50*(i+1)):
        if x%2!=0:
            mrktvalue.append(name_mrktvalue[x])
        else:
            name.append(name_mrktvalue[x])
    i+=1
#######################################################
import pandas as pd
data_n = pd.DataFrame(name) 
data_m = pd.DataFrame(mrktvalue)
data_a = pd.DataFrame(age)

#data_n.to_csv("transfermarket_name.csv",encoding='cp949') 깨지는 문자 확인
data_n= data_n.applymap(lambda x: x.replace('\xe9','e'))
data_n= data_n.applymap(lambda x: x.replace('\xe3','a'))
data_n= data_n.applymap(lambda x: x.replace('\xed','i'))
data_n= data_n.applymap(lambda x: x.replace('\xeb','e'))
data_n= data_n.applymap(lambda x: x.replace('\xfa','u'))
data_n= data_n.applymap(lambda x: x.replace('\xe1','a'))
data_n= data_n.applymap(lambda x: x.replace('\xf2','o'))
data_n= data_n.applymap(lambda x: x.replace('\xfc','u'))
data_n= data_n.applymap(lambda x: x.replace('\xd6','O'))
data_n= data_n.applymap(lambda x: x.replace('\xc9','E'))
data_n= data_n.applymap(lambda x: x.replace('\xf6','o'))
data_n= data_n.applymap(lambda x: x.replace('\xef','i'))
data_n= data_n.applymap(lambda x: x.replace('\xc1','A'))
data_n= data_n.applymap(lambda x: x.replace('\xf3','o'))
data_n= data_n.applymap(lambda x: x.replace('\xf1','n'))
data_n= data_n.applymap(lambda x: x.replace('\xe0','a'))
data_n= data_n.applymap(lambda x: x.replace('\xee','i'))
#data_m.to_csv("transfermarket_marketvalue.csv",encoding='cp949')
data_m= data_m.applymap(lambda x: x.replace('\xa0',''))

data_n.to_csv("transfermarket_name.csv")
data_m.to_csv("transfermarket_marketvalue.csv",encoding='cp949')#그냥 하면 '€' 인식을 못
data_a.to_csv("transfermarket_age.csv")


