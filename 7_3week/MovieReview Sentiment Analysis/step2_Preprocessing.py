import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

def text_preprocessing(text):
    return text

# 폄점 전처리 함수
def star_preprocessing(text):
    value = int(text)
    if value <= 5:
        return 0
    else:
        return 1

def step2_Preprocessing():
    # 수집 데이터 읽어오기
    df = pd.read_csv('naver_star_data.csv')
    # print(df.head())
    # train_test_split를 이용 하지 못하는 경우 -> 데이터를 랜덤하게 섞어 줘야 한다.
    np.random.seed(0)
    df = df.reindex(np.random.permutation(df.index))

    # 전처리
    # text 컬럼 내용을 정리 -> 지금은 할게 없음
    # 평점 데이터를 레이블 작업 -> 평점 5점 이상이면 1, 0
    # star_preprocessing
    df['text'] = df['text'].apply(text_preprocessing)
    df['star'] = df['star'].apply(star_preprocessing)

    text_list = df['text'].tolist()
    star_list = df['star'].tolist()

    text_train, text_test, star_train, star_test = train_test_split(text_list, star_list, test_size=0.3, random_state=0)
    print(len(text_train), len(text_test), len(star_train), len(star_test))

    # 저장을 위한 데이터 프레임 작업
    dic_train = {'text': text_train, 'star': star_train}
    df_tran = pd.DataFrame(dic_train)
    dic_test = {'text': text_test, 'star': star_test}
    df_test = pd.DataFrame(dic_test)
    
    # 저장
    df_tran.to_csv('naver_train_data.csv', index=False, encoding='utf-8')
    df_test.to_csv('naver_test_data.csv', index=False, encoding='utf-8')
