from sentiment import sentiment_score
import numpy as np 
import pandas as pd 
import os 
from tqdm import tqdm

'''
Usage:
    >>> input = u"xxx"
    >>> print sentiment_score(input)
'''

### NOTE: test the sentiment score function
# x = u"I love you"
# print sentiment_score(x)

# load the .csv data
data_path = './ICMdata/'
result_path = './result/'
log_path = './log/'
data_name = os.listdir(data_path)
# print data_name

# error logging
def log_error(f, line, string, errortype=None):
    '''
    logging 
    '''
    log_str = str(line) + '     | ' + string + '\n'
    f.writelines(log_str)

# read and revise the dataset
review_list = [u'review_headline', u'review_body']
for item in data_name:
    log_name = log_path + item + 'log.txt'
    with open(log_name, mode='a') as f:
        f.writelines(item + '\n')

        item_path = data_path + item
        print item_path
        df = pd.read_csv(item_path)
        item_columns = df.columns
        for review in review_list:
            if review in item_columns:
                str_list = df[review]
                # print str_list
                score_list = []
                count = 0
                total_count = len(str_list)
                print total_count
                tqdm_iter = tqdm(enumerate(list(str_list)))
                for i in tqdm_iter:
                    try:
                        str_item = unicode(i[1].encode("utf-8"))
                        count += 1
                        str_item_score_tmp = sentiment_score(str_item)
                        score_list.append(str_item_score_tmp)
                    except:
                        log_error(f, i[0], str(i[1]))
                        count += 1
                        score_list.append(str(i[1]))
                               
                score_list = pd.DataFrame(score_list)
                df = pd.concat([df, score_list], axis=1)
                ori_columns = list(df.columns)
                ori_columns[-1] = review + u'_score'
                df.columns = pd.Series(ori_columns)
        save_path = result_path + item
        df.to_csv(save_path)
        print df
