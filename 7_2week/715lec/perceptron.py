import numpy as np

class Perceptron:
    # 생성자 만들기
    # threshold : 임곗값 , 계산된 예측값을 비교하는 값
    # eta : 학습률
    # n_iter: 학습 횟수 
    def __init__(self, thresholds=0.0, eta=0.01, n_iter=10):
        self.thresholds = thresholds
        self.eta = eta
        self.n_iter=n_iter

    # 학습
    def fit(self,X,y):
        pass

    # 가중치 * 입력값 총합 계산
    # X: 입력값
    # y=ax+b
    def net_input(self,X):
         # ax 구해주기 + b값 의미
         # 각 자리의 값과 가중치를 곱한 총합 +b
        a1=np.dot(X, self.w_[1:]) + self.w_[0]
        return a1

    # 예측된 결과를 가지고 판단
    # X: 입력값, 배열
    def predict(self,X):
        a2= np.where(self.net_input(X)> self.thresholds,1,-1)
        return a2

