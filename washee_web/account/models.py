from django.db import models
from django.conf import settings
from django.contrib.auth.models import (
    AbstractBaseUser
)

from account.managers import (
    UserManager, AccountManager
)


class User(AbstractBaseUser):
    """
        This has been taken as a template from the web.
        It makes a user have only an email and password, and makes it more explicit what model we have
        It can be changed in a future PR, if we don't think users should write their mail
        
        TODO: Presently has no real security, see has_perm and has_module_perms
    """
    id = models.AutoField(primary_key=True)
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )
    username = models.CharField(max_length=30, unique=True)
    date_joined = models.DateTimeField(verbose_name="date joined", auto_now_add=True)
    last_login = models.DateTimeField(verbose_name="last logged in", auto_now=True)
    is_active = models.BooleanField(default=True)
    
    staff = models.BooleanField(default=False) # an admin, non super-user
    @property
    def is_staff(self):
        "Is the user a member of staff? Mandatory by Django"
        return self.staff

    admin = models.BooleanField(default=False) # an admin, super-user
    @property
    def is_admin(self):
        "Is the user a admin member? Mandatory by Django"
        return self.admin
    
    superuser = models.BooleanField(default=False) # a non-admin, super-user
    @property
    def is_superuser(self):
        "Is the user a superuser? Mandatory by Django"
        return self.superuser

    # notice the absence of a "Password field", that is built in.
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = [] # USERNAME_FIELD & Password are required by default.
    
    # Managers
    objects = UserManager()

    def get_full_name(self):
        # The user is identified by their email address
        return self.email

    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True
    
    def has_perms(self,perm,obj=None):
        return self.has_perm(perm,obj)

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True
    
    class Meta:
        ordering = ['-date_joined']
        db_table = 'user'
        managed = True
        verbose_name = "user"
        verbose_name_plural = "users"
    

class Account(models.Model):
    """
        Represents an account with money on it, which can be shared with other users 
        (sharing an account for an apartment for example)
    """
    # Fields
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=36)    
    balance = models.DecimalField(max_digits=19, decimal_places=4, default=0)
    
    created = models.DateTimeField(auto_now_add=True, editable=False)
    last_updated = models.DateTimeField(auto_now=True, editable=False)
    
    # Choices
    
    # Foreign Keys
    owners = models.ManyToManyField(
        settings.AUTH_USER_MODEL, 
        related_name="accounts"
    )
    
    # Managers
    objects = AccountManager()
    
    def __str__(self):
        return self.name
    
    class Meta:
        ordering = ['-created']
        db_table = 'account'
        managed = True
        verbose_name = "account"
        verbose_name_plural = "accounts"
        
        