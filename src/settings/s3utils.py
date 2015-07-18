# -*- coding: utf-8 -*-

"""
    S3BotoStorage
    Author  :   Alvaro Lizama <nekrox@gmail.com>
"""

from storages.backends.s3boto import S3BotoStorage


StaticRootS3BotoStorage = lambda: S3BotoStorage(location='static')
MediaRootS3BotoStorage  = lambda: S3BotoStorage(location='media')
