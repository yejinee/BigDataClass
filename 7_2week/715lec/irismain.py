import numpy as np
from time import time
import pickle
from perceptron import Perceptron
import pandas as pd

# 데이터 전처리
def step1_get_data():
    # iris.data 파일 읽어오기 (이때 working directory가 열려잇는 거 기준임)
    df=pd.read_csv('./IrisPerceptron/iris.data', header=None)
    #print(df.shape)
    # 꽃잎 데이터만 추출 
    X=df.iloc[:100,[2,3]].values
    # 꽃 종류 데이터를 추출 
    y=df.iloc[:100,[4]].values
    # 종류에 따라서 One hot encoding 수행
    y=np.where(y=="Iris-setosa", 1, -1)
    return X,y

# 학습
def step2_learning():
    ppn=Perceptron(eta=0.1)
    X,y=step1_get_data()
    # 학습 
    ppn.fit(X,y)
    print(ppn.errors_)
    print(ppn.w_)
    # 학습된 모델을 저장
    with open("./IrisPerceptron/perceptron.pickle","wb") as fp:
        pickle.dump(ppn,fp)
    print(" 학습 완료")

# 예측
def step3_using():
    # 학습된걸 읽어와서 모델을 다시 만들어줌
    with open('./IrisPerceptron/perceptron.pickle',"rb") as fp:
        ppn=pickle.load(fp)
    while True:
        a1=input(" 길이를 입력")
        a2= input("넓이 입력")
        X = np.array([float(a1), float(a2)])
        # 결과를 예측 ( 1, -1)
        result=ppn.predict(X)
        if result==1:
            print(" The result is Iris-setosa")
        else:
            print("The result is Iris-versicolor")


step1_get_data()
step2_learning()
step3_using()
