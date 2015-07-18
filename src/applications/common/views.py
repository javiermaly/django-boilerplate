# -*- coding: utf-8 -*-

"""
    Views for common app
    Author  :   Alvaro Lizama <nekrox@gmail.com>
"""

from django.shortcuts import render


def home(request):
    """
    Home
    """

    return render(request, 'layout.html', {})
