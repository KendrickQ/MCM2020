import pandas as pd
from nltk.corpus import stopwords
from multi_rake import Rake
from xlwt import Workbook
import re
from sklearn.cluster import KMeans
from sklearn.externals import joblib
import numpy as np
from gensim.models import Word2Vec
from gensim.models.word2vec import LineSentence
import matplotlib.pyplot as plt
from gensim.test.utils import datapath, get_tmpfile
from gensim.models import KeyedVectors
from gensim.scripts.glove2word2vec import glove2word2vec


def csv_vectorCompute(text, keywords):
    model = KeyedVectors.load_word2vec_format('F:/0.美赛/0.0 Go/C/model/test_word2vec.txt', binary=False)
    words = []
    data = open(text, 'r', encoding='utf-8')
    for line in data.readlines():
        line = line.replace('\n', '')
        if line not in words:
            words.append(line)

    for word in words:
        list2 = word.split(' ')
        list3 = []
        for word in list2:
            if word == '':
                continue
            else:
                list3.append(word)
        res = []
        for keyword in keywords:
            res.append(model.n_similarity([keyword], list3))


def wordCluster(text, vectorsize, classCount):
    name = []
    data = open(text, 'r', encoding='utf-8')
    for line in data.readlines():
        line = line.replace('\n', '')
        if line not in name:
            name.append(line)
    # word2vec向量化
    model = Word2Vec(LineSentence(text), size=vectorsize, window=5, min_count=2, workers=4)
    model.wv.save_word2vec_format('./word_model.txt', binary=False)
    # 获取model里面的说有关键词
    keys = model.wv.vocab.keys()
    # 获取词对于的词向量
    wordvector = []
    for key in keys:
        wordvector.append(model[key])
    # 聚类
    clf = KMeans(n_clusters=classCount)
    s = clf.fit_predict(wordvector)
    for i in range(0, classCount):
        label_i = []
        for j in range(0, len(s)):
            if s[j] == i:
                label_i.append(name[j])
        print('label_' + str(i) + ':' + str(label_i))
    # print(len(wordvector))
    return clf.inertia_


def K_cluseter(data, cluster_num=5, save_path='F:/0.美赛/0.0 Go/C/Data/'):
    '''

    :param data: DataFrame的数据格式
    :param cluster_num: 聚合的类别数目
    :param save_path: 路径
    :return:
    '''
    kmeans = KMeans(n_clusters=cluster_num).fit(data)
    data['Label'] = kmeans.labels_
    data.to_csv(save_path + str(cluster_num) + '_cluster.csv', index=False)
    Size = data.groupby('Label').size()
    print(Size)
    print(kmeans.inertia_)


def CSV_read(path, filename):
    data = pd.read_csv(path + filename)
    data['review_date'] = pd.to_datetime(data['review_date'])
    return data


def title_keyword(path, filename):
    '''
    统计关键词的词频
    :return:
    '''
    stop_words = stopwords.words('english')
    stop_words.append(' ')
    # print(stop_words)
    keyword = {}
    r = '[’!"#$%&\'()*+,./:;<=>?@[\\]^`{|}~]+'
    data = pd.read_csv(path + filename)
    for i in range(len(data)):
        txt = re.sub(r, ' ', data.iat[i, 5])
        words = txt.split(' ')
        for word in words:
            if word in stop_words:
                continue
            if word in keyword:
                keyword[word] += 1
            else:
                keyword[word] = 1
    KeyWord = pd.DataFrame.from_dict(keyword, orient='index')
    KeyWord = KeyWord.reset_index()
    KeyWord.columns = ['keyword', 'times']
    res = KeyWord.sort_values(by='times', ascending=False)
    file = filename.split('.')[0]
    res.to_csv(path + 'title/' + file + '_title_keywords.csv', index=False)
    print("Store the file successfully")


def keyword_extraction(text, rake, num=5):
    keywords = rake.apply(text)
    return keywords[: num]

def filter_str(desstr,restr=''):
    #过滤除中英文及数字以外的其他字符
    res = re.compile("[^\u4e00-\u9fa5^a-z^A-Z^0-9^ ]")
    return res.sub(restr, desstr)


def transfer():
    glove_file = datapath('F:/0.美赛/0.0 Go/C/model/glove.6B.50d.txt')
    # 指定转化为word2vec格式后文件的位置
    tmp_file = get_tmpfile("F:/0.美赛/0.0 Go/C/model/test_word2vec.txt")
    glove2word2vec(glove_file, tmp_file)



def w2v(words, model, keyword):
    # data = pd.read_csv('./Score/Hair_dryer_1.csv')
    words = str(words)
    # print(words)
    list3 = []
    for kword in words:
        list2 = kword.split(' ')
        for word in list2:
            if word == '':
                continue
            else:
                list3.append(word)
    if len(list3) == 0:
        return 0

    if len(keyword.split(' ')) == 1:
        # print('1')
        res = model.n_similarity([keyword], list3)
    else:
        des = keyword.split(' ')
        res = model.n_similarity(des, list3)
    return res


if __name__ == '__main__':
    path = 'F:/0.美赛/0.0 Go/C/'

    data = pd.read_csv(path + 'Score/Microwave_1.csv')
    model = KeyedVectors.load_word2vec_format('F:/0.美赛/0.0 Go/C/model/test_word2vec.txt', binary=False)
    keywords = ['color', 'big', 'animal', 'refundable', 'delivery fast', 'cheap', 'suitable',
                'package', 'certification', 'silicon', 'durable', 'convenient', 'giveaway', 'safe']  # pacifier
    # keywords = ['color', 'big', 'animal', 'refundable', 'delivery fast', 'cheap', 'energy', 'certification',
    #             'durable', 'technology', 'convenience', 'efficient', 'quiet', 'giveaway', 'scenes', 'hair concern',
    #             'hair type', 'spa']  # hair_dryer
    # keywords = ['color', 'large', 'refundable', 'cheap', 'power', 'certification', 'material', 'durable',
    #             'function', 'technology', 'convenience', 'efficient', 'noise', 'giveaway']

    for keys in keywords:
        print(keys)
        # body_kewords
        # description
        data[keys] = data.apply(lambda x: w2v(x.body_kewords, model, keys), axis=1)

    data.to_csv(path + '0308/microwave.csv')
    print("done")
    # w2v('delivery', model, 'delivery fast')









    # title_keyword(path, 'Microwave_timesorted.csv')
    # title_keyword(path, 'Hair_dryer_timesorted.csv')
    # title_keyword(path, 'Pacifier_timesorted.csv')
    # data = pd.read_csv(path + 'Pacifier_timesorted.csv')
    # file = 'Hair_dryer_timesorted.csv'
    # file = 'Hair_dryer_timesorted.csv'
    # data = CSV_read(path, file)
    # rake = Rake()
    # error = []
    # book = Workbook(encoding='utf-8')
    # sheet1 = book.add_sheet('Sheet1')
    # # data['Keyword_Score'] = data.apply(lambda x: keyword_extraction(x.review_body, rake), axis=1)
    # # data.to_csv(path + 'body_keywords/' + file.split('.')[0] + '_body_keyword.csv', index=False)
    # for i in range(1, len(data)):
    #     text = data.iat[i, 5]
    #     sheet1.write(i, 0, text)
    #     print(text)
    #     # if i in [7498, 8968, 8970]:
    #     #     continue
    #     # if text == 'nan':
    #     #     error.append(i)
    #     #     continue
    #
    #     text = filter_str(text)
    #     keywords = rake.apply(text)
    #     now = 1
    #     print(i)
    #     for j in range(len(keywords)):
    #         sheet1.write(i, now, keywords[j][0])
    #         sheet1.write(i, now+1, keywords[j][1])
    #         now += 2
    #         if j > 10:
    #             break
    # book.save(path + 'title/' + file.split('.')[0] + '_keywords.xls')



