# Generated by Django 3.2.25 on 2025-04-21 10:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mall', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Admin',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('phone', models.CharField(max_length=11, unique=True)),
                ('password', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='OrderPerform',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('code', models.CharField(max_length=255, null=True)),
                ('menu_id', models.CharField(max_length=255, null=True)),
                ('user_id', models.CharField(max_length=255, null=True)),
                ('date', models.CharField(max_length=20, null=True)),
                ('seat', models.CharField(max_length=3000, null=True)),
                ('price', models.CharField(max_length=20, null=True)),
                ('status', models.CharField(max_length=10, null=True)),
                ('de', models.CharField(max_length=1, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Perform',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('pic', models.CharField(max_length=255, null=True)),
                ('name', models.CharField(max_length=255, null=True)),
                ('addr', models.CharField(max_length=255, null=True)),
                ('date', models.CharField(max_length=20, null=True)),
                ('performer', models.CharField(max_length=30, null=True)),
                ('price', models.CharField(max_length=10, null=True)),
                ('descx', models.CharField(max_length=5000, null=True)),
                ('de', models.CharField(max_length=1, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Staff',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=20, null=True)),
                ('sex', models.CharField(max_length=1, null=True)),
                ('health', models.CharField(max_length=50, null=True)),
                ('phone', models.CharField(max_length=11, unique=True)),
                ('password', models.CharField(max_length=30)),
                ('de', models.CharField(max_length=1, null=True)),
            ],
        ),
        migrations.DeleteModel(
            name='Address',
        ),
        migrations.DeleteModel(
            name='Goods',
        ),
        migrations.DeleteModel(
            name='order',
        ),
        migrations.DeleteModel(
            name='order_goods',
        ),
        migrations.AddField(
            model_name='user',
            name='de',
            field=models.CharField(max_length=1, null=True),
        ),
        migrations.AddField(
            model_name='user',
            name='password',
            field=models.CharField(default=1, max_length=30),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='user',
            name='date',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='name',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='nickname',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='phone',
            field=models.CharField(max_length=11, unique=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='qq',
            field=models.CharField(max_length=15, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='sex',
            field=models.CharField(max_length=1, null=True),
        ),
    ]
