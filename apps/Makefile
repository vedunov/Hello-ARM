app image app_clean:
	@for i in *; do \
		test -d $$i && make "$@" -C $$i || echo "" >/dev/null; \
	done
