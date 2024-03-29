all: rest-server-example rest-server-example-z1 coap-client-example coap-client-example-anchor1 coap-client-example-anchor2 coap-client-example-coord

ifndef TARGET
TARGET=z1
endif

APPS=servreg-hack
CFLAGS+= -DUIP_CONF_IPV6_RPL

CONTIKI=../..

WITH_UIP6=1
UIP_CONF_IPV6=1

WITH_COAP = 1

CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"

ifeq ($(WITH_COAP), 1)
CFLAGS += -DWITH_COAP
APPS += rest-coap
else
CFLAGS += -DWITH_HTTP
APPS += rest-http
endif

include $(CONTIKI)/Makefile.include

$(CONTIKI)/tools/tunslip6:	$(CONTIKI)/tools/tunslip6.c
	(cd $(CONTIKI)/tools && $(MAKE) tunslip6)

connect-router:	$(CONTIKI)/tools/tunslip6
	sudo $(CONTIKI)/tools/tunslip6 aaaa::1/64

connect-router-cooja:	$(CONTIKI)/tools/tunslip6
	sudo $(CONTIKI)/tools/tunslip6 -a 127.0.0.1 aaaa::1/64
