SUBDIRS = foo bar baz
subdirs:
  for dir in $(SUBDIRS); do \
    $(MAKE) -C $$dir; \
  done
 
 SUBDIRS = foo bar baz
.PHONY: subdirs $(SUBDIRS)
subdirs: $(SUBDIRS)
$(SUBDIRS):
  $(MAKE) -C $@
foo: baz
