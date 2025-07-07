import os
import time
from datetime import datetime

from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

import json
from django.db.models import Q


from mall_project import settings
from .models import User
from .models import Admin
from .models import Staff
from .models import News
from .models import Save
from .models import Comment


# Create your views here.
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile




#上传图片
@csrf_exempt
def upload_file_perform(request):
    print("前端传来的goods_id_file:"+str(request.POST.get('goods_id_file')))
    goods_id=request.POST.get('goods_id_file')
    goods_file=request.FILES['file']
    goods_file_name=time.strftime('%Y%m%d%H%M%S')+goods_file.name
    file_path=os.path.join(settings.MEDIA_ROOT,goods_file_name)
    try:
        with open(file_path,'wb') as f:
            for fimg in goods_file.chunks():
                f.write(fimg)


        #获取本机ip+port
        pic=request.build_absolute_uri('/')+'static/uploads/'+goods_file_name

        resp_data={
            "code":0,
            "url":"",
            "message":"图片上传成功"
        }
        resp_data['url']=pic

    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"图片上传失败"
        }

    return HttpResponse(json.dumps(resp_data))




def hello_world(request):
    return HttpResponse("hello")

@csrf_exempt
def test(request):
    data=request.body
    print(data)
    json_data = json.loads(data)


    resp_data={
        "code":"ok",
        "message":"test成功"
    }
    return HttpResponse(json.dumps(resp_data))

#用户注册接口
@csrf_exempt
def register(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    phone=json_data['username']
    password=json_data['password']

    try:
        User.objects.create(phone=phone,password=password,de='1')
        resp_data={
            "code":"ok",
            "message":"注册成功"
        }
    except Exception as e:
        resp_data={
            "code":"error",
            "message":"注册失败"
        }


    return HttpResponse(json.dumps(resp_data))

#用户登录接口
@csrf_exempt
def login(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    phone=json_data['username']
    password=json_data['password']
    print(phone)
    print(password)
    role=json_data['role']

    if role=='user':
        user=User.objects.filter(Q(phone=phone)&Q(password=password)&Q(de='1'))
        if len(user)>0 :
            resp_data={
                "id":"",
                "nickname":"",
                "name":"",
                "phone":"",
                "qq":"",
                "email":"",
                "date":"",
                "sex":"",
                "role":"user",
                "code":"ok",
                "message":"登录成功"
            }
            resp_data['id']=user[0].id
            resp_data['nickname']=user[0].nickname
            resp_data['name']=user[0].name
            resp_data['date']=user[0].date
            resp_data['email']=user[0].email
            resp_data['phone']=user[0].phone
            resp_data['qq']=user[0].qq
            resp_data['sex']=user[0].sex
        else:
            resp_data={
                "code":"error",
                "message":"登录失败"
            }
    elif role=='staff':
        user=Staff.objects.filter(Q(phone=phone)&Q(password=password)&Q(de='1'))
        if len(user)>0 :
            resp_data={
                "id":"",
                "name":"",
                "phone":"",
                "sex":"",
                "addr":"",
                "role":"staff",
                "code":"ok",
                "message":"登录成功"
            }
            resp_data['id']=user[0].id
            resp_data['name']=user[0].name
            resp_data['phone']=user[0].phone
            resp_data['sex']=user[0].sex
            resp_data['addr']=user[0].addr
        else:
            resp_data={
                "code":"error",
                "message":"登录失败"
            }
    elif role=='admin':
        admin=Admin.objects.filter(Q(phone=phone)&Q(password=password))
        if len(admin)>0 :
            resp_data={
                "id":"",
                "name":"admin",
                "role":"admin",
                "code":"ok",
                "message":"登录成功"
            }
            resp_data['id']=admin[0].id
        else:
            resp_data={
                "code":"error",
                "message":"登录失败"
            }
    else:
        resp_data={
            "code":"error",
            "message":"角色有误"
        }

    return HttpResponse(json.dumps(resp_data))

#根据user_id获取用户信息##############################
@csrf_exempt
def select_user_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['user_id']

    try:
         user=User.objects.filter(id=user_id)
         resp_data={
            "code":"ok",
            "message":"查询成功",
             "nickname":"",
             "name":"",
             "date":"",
             "sex":"",
             "email":"",
             "qq":"",
             "phone":""
         }
         resp_data['nickname']="" if (user[0].nickname is None) else user[0].nickname
         resp_data['name']="" if (user[0].name is None) else user[0].name
         resp_data['email']="" if (user[0].email is None) else user[0].email
         resp_data['qq']="" if (user[0].qq is None) else user[0].qq
         resp_data['date']="" if (user[0].date is None) else user[0].date
         resp_data['phone']="" if (user[0].phone is None) else user[0].phone
         resp_data['sex']="" if (user[0].sex is None) else user[0].sex
         if user[0].sex is None:
             resp_data['sex']=""
         else:
             if user[0].sex=="1":
                 resp_data['sex']="男"
             elif user[0].sex=="0":
                 resp_data['sex']="女"
             elif user[0].sex=="2":
                 resp_data['sex']="保密"
             else:
                 resp_data['sex']=""
                 resp_data['code']="error"
                 resp_data['message']="获取信息失败，性别获取有误"

    except Exception as e:
        print("异常信息："+e)
        resp_data={
                "code":"error",
                "message":"信息获取失败"
        }

    return HttpResponse(json.dumps(resp_data))
#####用户########用户#########用户#######用户#################################################################
@csrf_exempt
def update_user_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']


    try:
        users=User.objects.filter(id=user_id)
        print(list(users.values()))
        users.update(nickname=json_data['nickname'],name=json_data['name'],date=json_data['date'],sex=json_data['sex'],email=json_data['email'],qq=json_data['qq'],phone=json_data['phone'])
        resp_data={
            "code":"ok",
            "message":"更新用户信息成功",
            "nickname":""
        }
        resp_data['nickname']=json_data['nickname']
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新用户信息失败"
        }

    return HttpResponse(json.dumps(resp_data))



#根据user_id删除用户
@csrf_exempt
def del_user_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']
    try:
        users=User.objects.filter(id=user_id)
        #users.delete()
        users.update(de='0')
        resp_data={
            "code":"ok",
            "message":"删除用户成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"删除用户失败"
        }

    return HttpResponse(json.dumps(resp_data))


@csrf_exempt
def add_user(request):
    data=request.body
    print(data)
    json_data = json.loads(data)


    try:
        User.objects.create(de='1',date=json_data['date'],name=json_data['name'],nickname=json_data['nickname'],qq=json_data['qq'],email=json_data['email'],phone=json_data['phone'],password=json_data['password'],sex=json_data['sex'])
        resp_data={
            "code":"ok",
            "message":"新增用户成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"新增用户失败"
        }
    return HttpResponse(json.dumps(resp_data))


from django.core.paginator import Paginator

@csrf_exempt
def select_user_all(request):
    resp_data = {
        "code": "ok",
        "message": "获取数据成功",
        "data": [],
        "total_pages": 0,
        "current_page": 0,
        "total_count": 0
    }

    try:
        # 获取分页参数
        page_num = int(request.GET.get('pageNum', 1))  # 默认第一页
        page_size = int(request.GET.get('pageSize', 10))  # 默认每页10条

        # 获取查询集（增加de='1'过滤条件）
        user_queryset = User.objects.filter(de='1',name__contains=request.GET.get('name')).order_by('id')
        
        # 创建分页器
        paginator = Paginator(user_queryset, page_size)
        resp_data['total_count'] = paginator.count
        resp_data['total_pages'] = paginator.num_pages

        try:
            current_page = paginator.page(page_num)
            resp_data['current_page'] = current_page.number
            
            for user in current_page.object_list:
                data_tmp = {
                    "id": user.id,
                    "nickname": user.nickname,
                    "name": user.name,
                    "sex":  user.sex,
                    "date": user.date,
                    "email": user.email,
                    "password": user.password,
                    "qq": user.qq,
                    "phone": user.phone
                }
                resp_data['data'].append(data_tmp)

        except PageNotAnInteger:
            # 如果页码不是整数返回第一页
            current_page = paginator.page(1)
            resp_data['message'] = "页码参数类型错误"
        except EmptyPage:
            # 如果页码超出范围返回最后一页
            current_page = paginator.page(paginator.num_pages)
            resp_data['message'] = "页码超出范围"

    except Exception as e:
        print("异常信息：", str(e))
        resp_data = {
            "code": "error",
            "message": "数据获取失败: " + str(e)
        }

    return HttpResponse(json.dumps(resp_data), content_type='application/json')

































###########员工###############员工#########################员工#############员工###################员工###########################
@csrf_exempt
def update_staff_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']


    try:
        users=Staff.objects.filter(id=user_id)
        print(list(users.values()))
        users.update(name=json_data['name'],sex=json_data['sex'],phone=json_data['phone'],password=json_data['password'],addr=json_data['addr'],pic=json_data['pic'])
        resp_data={
            "code":"ok",
            "message":"更新员工信息成功",
            "nickname":""
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新员工信息失败"
        }

    return HttpResponse(json.dumps(resp_data))


@csrf_exempt
def del_staff_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']
    try:
        users=Staff.objects.filter(id=user_id)
        users.update(de='0')
        resp_data={
            "code":"ok",
            "message":"删除员工成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"删除员工失败"
        }

    return HttpResponse(json.dumps(resp_data))


@csrf_exempt
def add_staff(request):
    data=request.body
    print(data)
    json_data = json.loads(data)


    try:
        Staff.objects.create(de='1',name=json_data['name'],phone=json_data['phone'],password=json_data['password'],sex=json_data['sex'],addr=json_data['addr'],pic=json_data['pic'])
        resp_data={
            "code":"ok",
            "message":"新增员工成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"新增员工失败"
        }
    return HttpResponse(json.dumps(resp_data))


from django.core.paginator import Paginator

@csrf_exempt
def select_staff_all(request):
    resp_data = {
        "code": "ok",
        "message": "获取数据成功",
        "data": [],
        "total_pages": 0,
        "current_page": 0,
        "total_count": 0
    }

    try:
        # 获取分页参数
        page_num = int(request.GET.get('pageNum', 1))  # 默认第一页
        page_size = int(request.GET.get('pageSize', 10))  # 默认每页10条

        # 获取查询集（增加de='1'过滤条件）
        user_queryset = Staff.objects.filter(de='1',name__contains=request.GET.get('name')).order_by('id')
        
        # 创建分页器
        paginator = Paginator(user_queryset, page_size)
        resp_data['total_count'] = paginator.count
        resp_data['total_pages'] = paginator.num_pages

        try:
            current_page = paginator.page(page_num)
            resp_data['current_page'] = current_page.number
            
            for user in current_page.object_list:
                data_tmp = {
                    "id": user.id,
                    "name": user.name,
                    "sex":  user.sex,
                    "password": user.password,
                    "phone": user.phone,
                    "pic": user.pic,
                    "addr": user.addr,
                }
                resp_data['data'].append(data_tmp)

        except PageNotAnInteger:
            # 如果页码不是整数返回第一页
            current_page = paginator.page(1)
            resp_data['message'] = "页码参数类型错误"
        except EmptyPage:
            # 如果页码超出范围返回最后一页
            current_page = paginator.page(paginator.num_pages)
            resp_data['message'] = "页码超出范围"

    except Exception as e:
        print("异常信息：", str(e))
        resp_data = {
            "code": "error",
            "message": "数据获取失败: " + str(e)
        }

    return HttpResponse(json.dumps(resp_data), content_type='application/json')




############################新闻管理##########################################################################33
@csrf_exempt
def update_news_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']


    try:
        users=News.objects.filter(id=user_id)
        print(list(users.values()))
        users.update(title=json_data['title'],cate=json_data['cate'],pic=json_data['pic'],
                     simple=json_data['simple'],content=json_data['content'],timex=json_data['timex'],
                     status=json_data['status'])
        resp_data={
            "code":"ok",
            "message":"更新新闻信息成功",
            "nickname":""
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新新闻信息失败"
        }

    return HttpResponse(json.dumps(resp_data))




@csrf_exempt
def del_news_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']
    try:
        users=News.objects.filter(id=user_id)
        users.update(de='0')
        resp_data={
            "code":"ok",
            "message":"删除新闻成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"删除新闻失败"
        }

    return HttpResponse(json.dumps(resp_data))


@csrf_exempt
def add_news(request):
    data=request.body
    print(data)
    json_data = json.loads(data)


    try:
        News.objects.create(de='1',
                    title=json_data['title'],cate=json_data['cate'],pic=json_data['pic'],look="0",
                     simple=json_data['simple'],content=json_data['content'],staff_id=json_data['staff_id'],timex=json_data['timex'],
                     status=json_data['status'])
        resp_data={
            "code":"ok",
            "message":"新增新闻成功"
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"新增新闻失败"
        }
    return HttpResponse(json.dumps(resp_data))


from django.core.paginator import Paginator

@csrf_exempt
def select_news_all(request):
    resp_data = {
        "code": "ok",
        "message": "获取数据成功",
        "data": [],
        "total_pages": 0,
        "current_page": 0,
        "total_count": 0
    }

    try:
        # 获取分页参数
        page_num = int(request.GET.get('pageNum', 1))  # 默认第一页
        page_size = int(request.GET.get('pageSize', 10))  # 默认每页10条

        # 获取查询集（增加de='1'过滤条件）
        user_queryset = News.objects.filter(de='1',title__contains=request.GET.get('title'),staff_id__contains=request.GET.get('staff_id')).order_by('id')
        
        # 创建分页器
        paginator = Paginator(user_queryset, page_size)
        resp_data['total_count'] = paginator.count
        resp_data['total_pages'] = paginator.num_pages

        try:
            current_page = paginator.page(page_num)
            resp_data['current_page'] = current_page.number
            
            for user in current_page.object_list:
                staff_one=Staff.objects.filter(id=user.staff_id)
                data_tmp = {
                    "id": user.id,
                    "title": user.title,
                    "cate":  user.cate,
                    "pic": user.pic,
                    "simple": user.simple,
                    "content": user.content,
                    "timex": user.timex,
                    "status": user.status,
                    "de": user.de,
                    "look": user.look,
                    "staff": staff_one[0].name,

                }
                resp_data['data'].append(data_tmp)

        except PageNotAnInteger:
            # 如果页码不是整数返回第一页
            current_page = paginator.page(1)
            resp_data['message'] = "页码参数类型错误"
        except EmptyPage:
            # 如果页码超出范围返回最后一页
            current_page = paginator.page(paginator.num_pages)
            resp_data['message'] = "页码超出范围"

    except Exception as e:
        print("异常信息：", str(e))
        resp_data = {
            "code": "error",
            "message": "数据获取失败: " + str(e)
        }

    return HttpResponse(json.dumps(resp_data), content_type='application/json')



@csrf_exempt
def select_news_allx(request):
    resp_data = {
        "code": "ok",
        "message": "获取数据成功",
        "data": [],
        "total_pages": 0,
        "current_page": 0,
        "total_count": 0
    }

    try:
        # 获取分页参数
        page_num = int(request.GET.get('pageNum', 1))  # 默认第一页
        page_size = int(request.GET.get('pageSize', 10))  # 默认每页10条

        # 获取查询集（增加de='1'过滤条件）
        user_queryset = News.objects.filter(de='1',status='通过',
                title__contains=request.GET.get('title')).order_by('id')
        
        # 创建分页器
        paginator = Paginator(user_queryset, page_size)
        resp_data['total_count'] = paginator.count
        resp_data['total_pages'] = paginator.num_pages

        try:
            current_page = paginator.page(page_num)
            resp_data['current_page'] = current_page.number
            
            for user in current_page.object_list:
                staff_one=Staff.objects.filter(id=user.staff_id)
                data_tmp = {
                    "id": user.id,
                    "title": user.title,
                    "cate":  user.cate,
                    "pic": user.pic,
                    "simple": user.simple,
                    "content": user.content,
                    "timex": user.timex,
                    "status": user.status,
                    "de": user.de,
                    "look": user.look,
                    "staff": staff_one[0].name,

                }
                resp_data['data'].append(data_tmp)

        except PageNotAnInteger:
            # 如果页码不是整数返回第一页
            current_page = paginator.page(1)
            resp_data['message'] = "页码参数类型错误"
        except EmptyPage:
            # 如果页码超出范围返回最后一页
            current_page = paginator.page(paginator.num_pages)
            resp_data['message'] = "页码超出范围"

    except Exception as e:
        print("异常信息：", str(e))
        resp_data = {
            "code": "error",
            "message": "数据获取失败: " + str(e)
        }

    return HttpResponse(json.dumps(resp_data), content_type='application/json')




@csrf_exempt
def select_news_ally(request):
    # data=request.body
    # print(data)
    # json_data = json.loads(data)

    # cate=json_data['cate']

    try:
        resp_data={
            "code":"ok",
            "message":"获取数据成功",
            "data":[]
        }
        user_all=News.objects.filter(status='通过')
        print(list(user_all.values()))
        for user in user_all:
            data_tmp={
                    "id":"",
                    "title":"",
                    "look":""
            }
            data_tmp['id']=user.id
            data_tmp['title']=user.title
            data_tmp['look']=user.look
            if user.de=='1':
                resp_data['data'].append(data_tmp)

        print("发送之前看一下："+json.dumps(resp_data))
    except Exception as e:
        print("异常信息："+e)
        resp_date={
            "code":"error",
            "message":"数据获取失败"
        }

    return HttpResponse(json.dumps(resp_data))



@csrf_exempt
def select_news_byid(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['id']


    try:
         
         user=News.objects.filter(id=user_id)
         user.update(look=str(int(user[0].look)+1))
         resp_data={
            "code":"ok",
            "message":"查询成功",
             "title":"",
             "cate":"",
             "simple":"",
             "content":"",
             "staff_name":"",
             "pic":"",
             "look":"",
             "timex":"",

         }
         resp_data['title']=user[0].title
         resp_data['cate']=user[0].cate
         resp_data['simple']=user[0].simple
         resp_data['content']=user[0].content
         resp_data['pic']=user[0].pic
         resp_data['timex']=user[0].timex
         resp_data['look']=user[0].look

         staff_one=Staff.objects.filter(id=user[0].staff_id)
         resp_data['staff_name']=staff_one[0].name



    except Exception as e:
        print("异常信息："+e)
        resp_data={
                "code":"error",
                "message":"信息获取失败"
        }

    return HttpResponse(json.dumps(resp_data))



############################收藏##########################################################################33
@csrf_exempt
def collect(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['user_id']
    newsId=json_data['newsId']


    try:
        save_all=Save.objects.filter(user_id=user_id,newsId=newsId,de='1')
        if len(save_all)>0:
            save_all.update(status=json_data['status'])
        else:
            Save.objects.create(de='1',user_id=json_data['user_id'],newsId=json_data['newsId'],status=json_data['status'])

        save_num=Save.objects.filter(newsId=newsId,status='true',de='1')
        resp_data={
            "code":"ok",
            "message":"更新收藏信息成功",
            "save_num":""
        }
        resp_data['save_num']=len(save_num)
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新收藏信息失败"
        }

    return HttpResponse(json.dumps(resp_data))





@csrf_exempt
def collect_status(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['user_id']
    newsId=json_data['newsId']


    try:
        resp_data={
            "code":"ok",
            "message":"更新收藏信息成功",
            "isCollected":"",
            "collectCount":"",
        }
        save_all=Save.objects.filter(user_id=user_id,newsId=newsId,de='1')
        if len(save_all)>0:
            if "True"==save_all[0].status:   
                resp_data['isCollected']=True
            else:
                resp_data['isCollected']=False
        else:
            resp_data['isCollected']=False

        save_num=Save.objects.filter(newsId=newsId,status='true',de='1')
        resp_data['collectCount']=len(save_num)
        
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新收藏信息失败"
        }

    return HttpResponse(json.dumps(resp_data))




############################评论##########################################################################33
@csrf_exempt
def comment(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    user_id=json_data['user_id']
    newsId=json_data['newsId']
    content=json_data['content']
    timex=time.strftime('%Y-%m-%d %H:%M:%S')


    try:
        Comment.objects.create(de='1',user_id=json_data['user_id'],newsId=json_data['newsId'],content=json_data['content'],timex=timex)
        resp_data={
            "code":"ok",
            "message":"新增评论成功",
        }
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"新增评论失败"
        }

    return HttpResponse(json.dumps(resp_data))






@csrf_exempt
def getComment(request):
    data=request.body
    print(data)
    json_data = json.loads(data)

    newsId=json_data['newsId']


    try:
        resp_data={
            "code":"ok",
            "message":"获取数据成功",
            "data":[]
        }
        comment_all=Comment.objects.filter(de='1',newsId=newsId)
        print(list(comment_all.values()))
        for comment in comment_all:
            data_tmp={
                    "id":"",
                    "content":"",
                    "timex":"",
                    "username":"",
            }
            data_tmp['id']=comment.id
            data_tmp['content']=comment.content
            data_tmp['timex']=comment.timex

            user_all=User.objects.filter(id=comment.user_id)
            data_tmp['username']=user_all[0].nickname
            resp_data['data'].append(data_tmp)
        
    except Exception as e:
        print("异常信息："+e)
        resp_data={
            "code":"error",
            "message":"更新收藏信息失败"
        }

    return HttpResponse(json.dumps(resp_data))















