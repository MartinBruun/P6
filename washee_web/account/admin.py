from django.contrib import admin

from account.models import (
    User, Account
)

admin.site.register(Account)
admin.site.register(User)