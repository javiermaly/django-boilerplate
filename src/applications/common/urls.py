# -*- coding: utf-8 -*-

"""
    URL's for common app
    Author  :   Alvaro Lizama <nekrox@gmail.com>
"""

from django.conf.urls import url


urlpatterns = [

    url(r'^$', 'applications.common.views.home'),

]

