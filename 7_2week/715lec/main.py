import numpy as np
from time import time
import pickle
from perceptron import Perceptron

def step1_learning():
    X=np.array([[0,0],[0,1],[1,0],[1,1]])
    y=np.array([-1,-1,-1,-1])
    ppn=Perceptron(eta=0.1)

    # 학습 
    stime=time()
    ppn.fit(X,y)
    etime=time()
    print("학습에 걸린 시간 : ", (etime-stime))
    print(" 학습 중 오차가 난 갯수 : ", ppn.errors_)
    # 학습이 완료된 객체를 파일로 저장
    with open("perceptron.pickle", "wb") as fp:
        pickle.dump(ppn,fp)
    print("학습 완료, 잘 저장")


def step2_using():
    # 파일로부터 객체를 복원
    with open("perceptron.pickle", "rb") as fp:
        ppn=pickle.load(fp)
    while True:
        a1=input(" 첫 번쨰 2진수를 입력")
        a2=input(" 두번쨰 2진수를 입력")
        X=np.array([int(a1),int(a2)])
        # 계산된 결과를 가져온다
        result= ppn.predict(X)
        if result==1:
            print("결과 1")
        else:
            print("결과 0")

step1_learning()
step2_using()