#############################################################
#
# domoticz
#
#############################################################

DOMOTICZ_SITE = http://svn.code.sf.net/p/domoticz/code/trunk
DOMOTICZ_SITE_METHOD = svn
DOMOTICZ_VERSION = 2313
DOMOTICZ_DEPENDENCIES = libcurl boost openssl lighttpd sqlite
DOMOTICZ_CONF_OPT += -DUSE_STATIC_BOOST=OFF

$(eval $(cmake-package))
