import pickle
import numpy as np

def step4_Using():
    # 모델 복원
    with open('model.pickle', 'rb') as fp:
        pipe = pickle.load(fp)
    while True:
        text = input('리뷰를 작성 해 주세요. :')
        str1 = [text]
        r1 = np.max(pipe.predict_proba(str1) * 100)
        r2 = pipe.predict(str1)[0]

        if r2 == 1:
            print('긍적적인 리뷰')
        else:
            print('부정적인 리뷰')
        print('정확도 : %.3f' % r1)