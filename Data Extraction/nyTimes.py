import requests
import csv
import json
from nytimesarticle import articleAPI
def parse_articles(articles):
    news = []
    #print(data["response"]["docs"])
    #print(data)
    sports = ['Archery','Cricket','Football','Soccer','Hockey','Cricket','Pro Basketball','Tennis','Wrestling','Wheels','Golf']
    for i in data["response"]["docs"]:
        dic = {}
        if i['subsection_name'] is None:
            continue
        if i['subsection_name'] not in sports:
            continue
        if i['subsection_name'] == 'Pro Basketball':
            i['subsection_name'] = 'Basketball'
        if i['subsection_name'] == 'Wheels':
            i['subsection_name'] = 'Formula1'
        #dic['id'] = i['_id']
        # if i['abstract'] is not None:
        #     dic['abstract'] = i['abstract'].encode("utf8")
        dic['headline'] = i['headline']['main'].encode("utf8")
        #dic['desk'] = i['news_desk']
        dic['date'] = i['pub_date'][0:10] # cutting time of day.
        dic['lead_paragraph'] = i['lead_paragraph']
        dic['subsection_name'] = i['subsection_name']
        if i['snippet'] is not None:
            dic['snippet'] = i['snippet'].encode("utf8")
        #dic['source'] = i['source']
        #dic['type'] = i['type_of_material']
        dic['url'] = i['web_url']
        #dic['word_count'] = i['word_count']
    #locations
        locations = []
        for x in range(0,len(i['keywords'])):
            if 'glocations' in i['keywords'][x]['name']:
                locations.append(i['keywords'][x]['value'])
        dic['locations'] = locations
        # subject
        subjects = []
        for x in range(0,len(i['keywords'])):
            if 'subject' in i['keywords'][x]['name']:
                subjects.append(i['keywords'][x]['value'])
        dic['subjects'] = subjects
        news.append(dic)
    return(news)
#print(news)
# api = articleAPI('51621dcea8a44941b7b75789250a68f0')
# all_articles = []
query = str(input("enter the category"))
query1 = str(input("enter the country"))
text = query+'+'+query1
# text = 'sports+USA'
text1 ="http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
text2 = "&begin_date="
date = "2016"
text3 = "1001&api-key=89607b8dfade49b2b1b997a192141fd6"
r = requests.get(text1 + text + text2 + date + text3)
data = r.json()
articles = parse_articles(data["response"]["docs"])
#print(articles)
#print(len(articles))
#f = csv.writer(open("news.csv","wb+"))
#articles = articles[0:2]
#print(articles)
# file = open("news_sem.txt","a")
for i in range (0,len(articles)):
    print(articles[i])
list1 = ['headline','snippet','lead_paragraph','url','date','locations','subsection_name']
# strn = 'Country'
# for item in list1:
#     strn = strn + '\t'
# strn = strn + '\n'
# file.write(strn)
# file.close()
# str
final = []
file = open("news_sem.txt","a")
str_value = query1
str_value = str_value + '\t'
for i in range(0,len(articles)):
    for items in list1:
        str_value = str_value + str(articles[i][items]) + '\t'
    str_value = str_value + '\n'+ query1 +'\t'
file.write(str_value)
file.close()


# wr = csv.writer(file, dialect='excel')
# wr.writerows(list1)
# file.write(strn)
# file.close()
# for i in range (0,len(articles)):
#     print(articles[i])
#     print(articles[i].keys())
#     final.append(text)
#     file = open("news.csv", "a")
#     for j in range (0,len(list1)):
#         # final.append(list1[j])
#         # final.append(':')
#         final.append(articles[i].get(list1[j]))
#         final.append(',')
#         wr = csv.writer(file, dialect='excel')
#
#     file.write(strn)
#     file.close()
#     final = []
#print(final)

#file.write(list1)

# with open('news1.csv', 'w') as outf:
#     dw = list1
#     dw.writeheader()
#     final.writeheader()