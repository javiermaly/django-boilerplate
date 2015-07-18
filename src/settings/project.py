# -*- coding: utf-8 -*-

"""
    Project settings
    Author  :   Alvaro Lizama <nekrox@gmail.com>
"""

from defaults import *
from getenv import env

##
## Admins
##
ADMINS = (
        ('Alvaro Lizama', 'nekrox@gmail.com'),
)
MANAGERS = ADMINS


##
## Custom context
##
TEMPLATE_CONTEXT_PROCESSORS += (
        )


##
## Project Apps
##
INSTALLED_APPS += (
    'storages',
    'applications.common'
)


##
## Storage
##
if not DEBUG:

    STATICFILES_STORAGE = 'setting.s3utils.StaticRootS3BotoStorage'
    DEFAULT_FILE_STORAGE = 'setting.s3utils.MediaRootS3BotoStorage'
    COMPRESS_STORAGE = STATICFILES_STORAGE

    BASE_URL = 'http://%s.s3.amazonaws.com/' % env('DJANGO_AWS_S3_BUCKET')
    COMPRESS_URL = BASE_URL + STATIC_URL
    STATIC_URL = BASE_URL + STATIC_URL
    MEDIA_URL = BASE_URL + MEDIA_URL

    AWS_ACCESS_KEY_ID = env('DJANGO_AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = env('DJANGO_AWS_SECRET_ACCESS_KEY')
    AWS_STORAGE_BUCKET_NAME = env('DJANGO_AWS_S3_BUCKET')
    AWS_QUERYSTRING_AUTH = False


##
## Suit
##
SUIT_CONFIG = {
    'ADMIN_NAME': 'Admin',

    'SEARCH_URL': '/admin/auth/user/',
    'MENU': (
        {
            'label': 'Users',
            'icon':'icon-user',
            'models': (
                'auth.user',
                'auth.group'
                )
            },
    ),

    'LIST_PER_PAGE': 20
}
