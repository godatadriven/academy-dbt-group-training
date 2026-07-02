# The training commands live in the repo-root Makefile. This thin forwarder
# lets the same targets (e.g. `make show-tables`) also work from inside the
# jaffle_shop folder, by delegating to the Makefile one level up.
%:
	@$(MAKE) --no-print-directory -C .. $@
