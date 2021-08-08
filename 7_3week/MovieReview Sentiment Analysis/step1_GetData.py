import requests
from bs4 import BeautifulSoup
from time import sleep
import pandas as pd

def step1_GetData():
    # 영화코드
    code_list = [184318, 191597]
    # 현재 크롤링 중인 영화가 첫번째 영화인지 여부
    chk = False
    # 영화의 갯 수 만큼 반복
    for code in code_list:
        # 1단계 : 해당 영화의 평점 페이지 수 계산
        site1 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?code=%d&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false" % code
        res1 = requests.get(site1)
        if res1.status_code == requests.codes.ok:
            # html 코드 분석
            bs1 = BeautifulSoup(res1.text, 'html.parser')

            score_total = bs1.find(class_='score_total')
            ems = score_total.find_all('em')
            score_total = int(ems[0].text.replace(',', ''))
            # print(score_total)
            # 페이지 수 계산
            pageCnt = score_total // 10
            if score_total % 10 > 0:
                pageCnt += 1
            # print(pageCnt)

            # 현재 페이지 번호
            now_page = 1
            pageCnt = 1

            # 2단계 : 평점 글, 평점 .... 필요한 정보 가져오기.
            while now_page <= pageCnt:
                sleep(0.5)
                # 요청 페이지 주소
                site2 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.naver?"
                site2 += "code=%d&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false" % code
                site2 += "&isMileageSubscriptionReject=false&page=%d" % now_page
                # print(site2)
                res2 = requests.get(site2)
                if res2.status_code == requests.codes.ok:
                    bs2 = BeautifulSoup(res2.text, 'html.parser')
                    score_result = bs2.find(class_='score_result')
                    lis = score_result.find_all('li')
                    # print(len(lis))
                    df = pd.DataFrame()
                    for obj in lis:
                        # 평점
                        star_score = obj.find(class_='star_score')
                        star_em = star_score.find('em')
                        star_score = int(star_em.text)
                        # 평가글
                        score_reple = obj.find(class_='score_reple')
                        reple_p = score_reple.find('p')
                        reple_p_span = reple_p.find_all('span')
                        # print(len(reple_p_span[1].text))
                        score_reple = reple_p_span[1].text
                        # ID
                        reple_id = obj.find(class_='score_reple')
                        id_a = reple_id.find('a')
                        id_span = reple_id.find_all('span')
                        # print(id_span[2].text)
                        id = id_span[2].text

                        # 테이터 누적
                        df = df.append([[id, score_reple, star_score]], ignore_index=True)
                    # 저장 : 처음 저장(파일이 없을때), 두번째 이후 저장(파일이 있을때)
                    if chk == False:
                        df.columns = ['id', 'text', 'star']
                        df.to_csv('naver_star_data.csv', index=False, encoding = 'utf-8')
                    else:
                        df.to_csv('naver_star_data.csv', index=False, encoding = 'utf-8', mode='a', header=False)
                print('%d / %d' % (now_page, pageCnt))
                now_page += 1




