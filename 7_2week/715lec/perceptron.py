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
        ## 가중치를 담을 행렬 생성
        ## shape[1]은 행렬 중에 행이다.
        self.w_ = np.zeros(1 + X.shape[1]) 

        #예측값과 실제값을 비교해서, 다른 예측값의 개수를 담을 리스트
        self.errors_ = []
        for _ in range(self.n_iter):
            ## 예측값과 실제값이 다른 개수를 담을 변수
            errors = 0

            ## 임시변수 생성: 입력받은 입력값과 결과값을 묶는다.(pack)
            temp1 = zip(X,y)

            ## 루프돌림: 입력값과 결과값을 묵음을 가지고, 반복
            for xi, target in temp1:
                ## 입력값을 가지고 예측
                a1 = self.predict(xi)
                # 입력값과 예측값이 다른 경우 가중치 계산
                if target != a1:
                    update = self.eta *(target - a1)
                    self.w_[1:] += update * xi
                    self.w_[0] += update
                    #값이 다른 횟수를 누적
                    errors += int(update != 0.0)
            ## 값이 다른 횟수값을 배열에 담는다. 
            self.errors_.append(errors)
            print(self.w_)


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