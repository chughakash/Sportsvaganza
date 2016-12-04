import wikipedia
str1 = ''
str2 = ''
list1 = ['Australian Open','National Football League','NCAA Football','NBA','2016 Barclays ATP Finals','BNP Paribas Open',
        'FIFA Beach Soccer World Cup', 'FIFA World Cup', 'Indoor Archery World Cup', 'Archery World Cup', 'Canadian Regional Indoor Championships',
        'WWE Smackdown',
        'Canadian Cup', 'Canadian Indoor 3D Championships',
        '3rd Test - India v England',
        '4th Test - India v England',
        '5th Test - India v England',
        'Ranji Trophy',
        'India v England ODI Series',
        'Abu Dhabi Grand Pix',
        'Canada Grand Pix',
        'Australian Grand Pix',
        'Russian Grand Pix',
        'WWE NXT Live',
        'WWE Survivor Series']
for items in list1:
    ao = wikipedia.page(items)
    file = open("wiki_content","a")

    try:
        str3 = str(ao.links)
        str1 = str1 + str(ao.title) + "\t" + str(ao.summary) + "\t" + str(ao.links[0]) + "\n\n"
        file.write(str1)
        file.close()
    except:
        str2 = str2 + str(items) + "\tNo links available" + "\n\n"
        file.write(str2)
        file.close()
    ao = ''
    str1= ''
    str2= ''
