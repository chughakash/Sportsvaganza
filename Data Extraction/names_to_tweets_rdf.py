import twitter
from textblob import TextBlob
from googleapiclient.discovery import build
import re
import sys

def gettweets(name_list):
    my_key = "l7yf5EFXUtXB9UyEFaeEoEYaF"
    my_secret = "IF1y2rcLiHPJ6lee7cvaPLfX6BeGn3PbMxFTqEwEeWN2X3zZx5"
    access_token = "65866196-KBSOBjsr752bZgg6cUojrNR6FjkjoU04nIrSKAATd"
    access_token_secret = "NnAnLZ1U5plyK5A4Gm2OSxnW2DwrnlBoFjRtIe50UgUUu"
    auth1 = twitter.oauth.OAuth(access_token, access_token_secret, my_key, my_secret)
    twitter_api = twitter.Twitter(auth=auth1)
    main_dict = {}
    for names in name_list:
        try:
            statuses = twitter_api.statuses.user_timeline(screen_name=names, count=5)

            strin = ''
            for status in statuses:
                    user = status['user']['name']
                    data = status['text']
                    strin = strin + data + "\n\n\n\n"
            main_dict[names] = strin
        except:
            main_dict[names] = "No Tweets \n\n\n"
    return main_dict


def create_tweets_rdf(tweets,tweets_key_list ):
    output_tweet = ''
    for items in tweets_key_list:
        if items != "status":
            individual_tweets = ''
            individual_tweets = tweets[items]
            each_tweet = re.split("\n\n\n\n", individual_tweets)
            output_tweet = output_tweet + str(items) + " Tweets \n"
            for speakings in each_tweet:
                output_tweet = items+","+str(speakings) + "\n"
                file = open("tweets_rdf", 'a')
                file.write(output_tweet)
                file.close()


def main():
    filename = 'twitterNames'
    twitterName = open(filename,'r')
    name_list = []
    twitter_handle_list = []
    for lines in twitterName:
        name_list.append(lines[:-1],)
    for item in name_list:
        handle = get_twitter_handle(item)
        twitter_handle_list.append(handle)
    main_dict = gettweets(twitter_handle_list)
    create_tweets_rdf(main_dict, twitter_handle_list)



def get_twitter_handle(search_term):

        my_api_key = "AIzaSyC_P6to4SQcOv3K1BqPkHParGzIppm31ZA"
        my_cse_id = "012140601996440350212:9yyqe6rzpnu"

        def google_search(search_term, api_key, cse_id, **kwargs):
            service = build("customsearch", "v1", developerKey=api_key)
            res = service.cse().list(q=search_term, cx=cse_id, **kwargs).execute()
            if res['items'] is not None:
                return res['items']
        try:
            results = google_search(search_term, my_api_key, my_cse_id, )
            json_string = (results)
            extracted_string = (json_string[0]['formattedUrl'])
            extracted_string = extracted_string[20:]
            if "%" in extracted_string:
                extracted_string = (json_string[1]['formattedUrl'])
                extracted_string = extracted_string[20:]

            if "/" in extracted_string:
                split_words = re.split("/", extracted_string)
                if len(split_words):
                    extracted_string = split_words[1]
            return  extracted_string
        except:
            return"status"

if __name__ == '__main__':
    main()








