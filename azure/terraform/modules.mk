.PHONY: init
init:
	@CUR_DIR=$$(pwd); \
	for D in ${MODULES}; do \
	    cd "$$CUR_DIR/$$D"; \
		$(MAKE) init; \
        cd "$$CUR_DIR"; \
	done

.PHONY: plan
plan:
	@CUR_DIR=$$(pwd); \
	for D in ${MODULES}; do \
	    cd "$$CUR_DIR/$$D"; \
		$(MAKE) plan || exit 1; \
	done

.PHONY: apply
apply:
	@CUR_DIR=$$(pwd); \
	for D in ${MODULES}; do \
	    cd "$$CUR_DIR/$$D"; \
		$(MAKE) apply || exit 1; \
	done

# Iterate in the reverse order to destroy the modules
.PHONY: destroy
destroy:
	@CUR_DIR=$$(pwd); \
	for D in $(shell echo $(MODULES) | awk '{for (i=NF; i>0; i--) printf "%s ", $$i}'); do \
	    cd "$$CUR_DIR/$$D"; \
		$(MAKE) destroy || exit 1; \
	done
