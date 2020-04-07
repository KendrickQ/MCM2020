from scipy import stats
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
import scipy.io as sio 

df = pd.read_csv(r'D:\Seafile\Group\2020-C\Code\dataset\hair_dryer.csv')
# print(df)
# print(df.columns)

star = {'star':np.array(list(df['star_rating']))}
sio.savemat('star.mat', star)

# vine = df.vine
# vine = vine == 'Y'

# y = df['star_rating'][vine] / 5
# s1 = df['review_headline_score'][vine] 
# s2 = df['review_body_score'][vine]

# y = df['star_rating'] / 5
# s1 = df['review_headline_score'] 
# s2 = df['review_body_score']

# x = []
# for i in range(len(y)):
#     if abs(s1.iloc[i] - y.iloc[i]) < abs(s2.iloc[i] - y.iloc[i]):
#         x.append(s1.iloc[i])
#     else:
#         x.append(s2.iloc[i])

# x = np.stack(x)

# X = sm.add_constant(x)

# est = sm.OLS(y, X)
# est = est.fit()
# print(est.summary())
# print(est.params)

# plt.scatter(y, x)
# plt.title('star_rating and sentiment')
# plt.xlabel('star_rating')
# plt.ylabel('sentiment_score')
# plt.grid()
# plt.show()


