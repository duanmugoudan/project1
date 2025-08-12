from django.db import models

# Create your models here.






class User(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #昵称
    nickname=models.CharField(max_length=30,null=True)
    #真实姓名
    name=models.CharField(max_length=20,null=True)
    #出生日期
    date=models.CharField(max_length=20,null=True)
    #性别(0是女，1是男)
    sex=models.CharField(max_length=1,null=True)
    #电子邮箱
    email=models.CharField(max_length=20,null=True)
    #qq
    qq=models.CharField(max_length=15,null=True)
    #手机号
    phone=models.CharField(max_length=11,unique=True)
    #密码
    password=models.CharField(max_length=30)
    #是否被删除(0为删除，1为未删除)
    de=models.CharField(max_length=1,null=True)

class Staff(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #真实姓名
    name=models.CharField(max_length=20,null=True)
    #性别
    sex=models.CharField(max_length=1,null=True)
    #工位
    addr=models.CharField(max_length=50,null=True)
    #照片
    pic=models.CharField(max_length=255,null=True)
    #手机号
    phone=models.CharField(max_length=11,unique=True)
    #密码
    password=models.CharField(max_length=30)
    #是否被删除(0为删除，1为未删除)
    de=models.CharField(max_length=1,null=True)

class Admin(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #手机号
    phone=models.CharField(max_length=11,unique=True)
    #密码
    password=models.CharField(max_length=30)




class News(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #标题
    title=models.CharField(max_length=50,null=True)
    #分类
    cate=models.CharField(max_length=50,null=True)
    #摘要
    simple=models.CharField(max_length=500,null=True)
    #内容
    content=models.CharField(max_length=5000,null=True)
    #发布人
    staff_id=models.CharField(max_length=50,null=True)
    #图片
    pic=models.CharField(max_length=255,null=True)
    #发布时间
    timex=models.CharField(max_length=50,null=True)
    #状态
    status=models.CharField(max_length=50,null=True)
    #状态
    look=models.CharField(max_length=50,null=True)
    #是否被删除(0为删除，1为未删除)
    de=models.CharField(max_length=1,null=True)



class Save(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #新闻id
    newsId=models.CharField(max_length=50,null=True)
    #状态
    status=models.CharField(max_length=50,null=True)
    #用户
    user_id=models.CharField(max_length=50,null=True)
    #是否被删除(0为删除，1为未删除)
    de=models.CharField(max_length=1,null=True)


class Comment(models.Model):
    #id
    id=models.AutoField(primary_key=True)
    #新闻id
    newsId=models.CharField(max_length=50,null=True)
    #状态
    content=models.CharField(max_length=5000,null=True)
    #用户
    user_id=models.CharField(max_length=50,null=True)
    #时间
    timex=models.CharField(max_length=50,null=True)
    #是否被删除(0为删除，1为未删除)
    de=models.CharField(max_length=1,null=True)





