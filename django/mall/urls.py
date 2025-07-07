
from django.urls import  path,include

import mall.views

urlpatterns=[
    path('hello_world',mall.views.hello_world),
    path('test',mall.views.test),
    path('register',mall.views.register),
    path('login',mall.views.login),
    path('add_user',mall.views.add_user),
    path('select_user_byid',mall.views.select_user_byid),
    path('update_user_byid',mall.views.update_user_byid),
    path('select_user_all',mall.views.select_user_all),
    path('del_user_byid',mall.views.del_user_byid),


    path('add_staff',mall.views.add_staff),
    path('update_staff_byid',mall.views.update_staff_byid),
    path('select_staff_all',mall.views.select_staff_all),
    path('del_staff_byid',mall.views.del_staff_byid),


    path('upload_file_perform',mall.views.upload_file_perform),

    path('add_news',mall.views.add_news),
    path('update_news_byid',mall.views.update_news_byid),
    path('select_news_all',mall.views.select_news_all),
    path('del_news_byid',mall.views.del_news_byid),
    path('select_news_allx',mall.views.select_news_allx),
    path('select_news_ally',mall.views.select_news_ally),
    path('select_news_byid',mall.views.select_news_byid),



    path('collect',mall.views.collect),
    path('collect_status',mall.views.collect_status),
    path('comment',mall.views.comment),
    path('getComment',mall.views.getComment),







 
]
