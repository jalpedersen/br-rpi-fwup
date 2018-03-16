################################################################################
#
## python-pip
#
#################################################################################

PYTHON3_PIP_VERSION = 9.0.1
PYTHON3_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON3_PIP_SITE = http://pypi.python.org/packages/source/p/pip
PYTHON3_PIP_SETUP_TYPE = setuptools
PYTHON3_PIP_DEPENDENCIES = python3 python3-setuptools
PYTHON3_PIP_LICENSE = MIT
PYTHON3_PIP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
