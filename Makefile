PROJECT = hazzarddesigns.com
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = jiffy lambdapad

# Override jiffy to get a more modern version that compiles properly
dep_jiffy = git https://github.com/davisp/jiffy.git 1.0.8
dep_lambdapad = git https://github.com/philipcristiano/lambdapad.git master

.PHONY: site_gen
site_gen:
	$(SHELL_ERL) -pa $(SHELL_PATHS) -noshell -eval "lpad:run([])." -eval "init:stop()."

server: site_gen
	cd site; python -m SimpleHTTPServer 8000

.PHONY: netlify
netlify: deps site_gen

include erlang.mk
