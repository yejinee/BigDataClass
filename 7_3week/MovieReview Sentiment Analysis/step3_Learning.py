from sklearn.linear_model import LogisticRegression
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.pipeline import Pipeline
from sklearn.metrics import accuracy_score
import pickle
from time import time
import pandas as pd
from konlpy.tag import *

kkma = Kkma()

def tokenizer(text):
    return kkma.morphs(text)

def step3_Learning():
    # 데이터 읽어오기
    # train_df = pd.read_csv('naver_train_data.csv')
    # test_df = pd.read_csv('naver_test_data.csv')
    train_df = pd.read_csv('movie_train_data.csv')
    test_df = pd.read_csv('movie_test_data.csv')

    X_train = train_df['text'].tolist()
    y_train = train_df['star'].tolist()

    X_test = test_df['text'].tolist()
    y_test = test_df['star'].tolist()

    tfidf = TfidfVectorizer(lowercase=False, tokenizer = tokenizer) # 토근화 함수 정의 필요
    logistic = LogisticRegression(C=10.0, penalty='l2', random_state=0)
    pipe = Pipeline([('vect', tfidf), ('clf', logistic)])
    # 학습 및 평가
    stime = time()
    print('학습시작')
    pipe.fit(X_train, y_train)
    print('학습종료')
    etime = time()
    print('총 학습 시간 : %d' % (etime - stime))
    y_pred = pipe.predict(X_test)
    print('정확도 : %.3f' % accuracy_score(y_test, y_pred))

    # 모델 저장
    with open('model.pickle', 'wb') as fp:
        pickle.dump(pipe, fp)
    print('저장 완료')
