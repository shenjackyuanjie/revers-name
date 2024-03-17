import json
import csv# 打开json文件并加载数据
with open('data.json', 'r',encoding='utf-8') as f:
    data = json.load(f)
with open('output.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['标签', 'QP', 'QD', 'skills'])
    left_labels=[]
    # 写入每行数据
    rows = []
    for index, (label, values) in enumerate(data['data'].items()):
        qp = values['QP']
        qd = values['QD']
        if (qp==-1 or qd==-1): 
            left_labels.append(label)
            continue

        if (qp==0 or qd ==0): continue 
        if 'skills' in values.keys():
            skills = ','.join([f"{k},{v}" for k, v in values['skills']['QP 100%'].items()])
        else:
            skills = ''
        
        rows.append([label, qp, qd, skills])

    # 按照QP字段降序排序
    sorted_rows = sorted(rows, key=lambda x: int(x[1]), reverse=True)
    with open('left_names.txt','w',newline='\n',encoding='utf-8') as f2:
        for name in left_labels:
            f2.write(name+'\n')
    # 写入排序后的数据
    for row in sorted_rows:
        writer.writerow(row)
