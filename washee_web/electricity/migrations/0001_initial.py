# Generated by Django 3.2.12 on 2022-04-16 20:59

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='ElectricityBlock',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('start_time', models.DateTimeField()),
                ('end_time', models.DateTimeField(editable=False)),
                ('price', models.DecimalField(decimal_places=4, default=0, max_digits=19)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('last_updated', models.DateTimeField(auto_now=True)),
                ('zone', models.CharField(choices=[('NON', 'No given zone'), ('DK1', 'West Denmark'), ('DK2', 'East Denmark')], default='NON', max_length=32)),
            ],
            options={
                'verbose_name': 'electricity_block',
                'verbose_name_plural': 'electricity_blocks',
                'db_table': 'electricity_block',
                'ordering': ['-created'],
                'managed': True,
            },
        ),
    ]
