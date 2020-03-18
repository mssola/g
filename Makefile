.PHONY: test
test: git-validation shellcheck unit-test

.PHONY: unit-test
unit-test:
	@docker build -t mssola/g:latest .
	@docker run --rm mssola/g:latest bash test.sh

.PHONY: git-validation
git-validation:
ifeq (, $(shell which git-validation 2> /dev/null))
	@echo "You don't have 'git-validation' installed, consider installing it (see the CONTRIBUTING.org file)."
else
	@git-validation -q -range da5b6722c940..HEAD -travis-pr-only=false
endif

.PHONY: shellcheck
shellcheck:
ifeq (, $(shell which shellcheck 2> /dev/null))
	@echo "You don't have 'shellcheck' installed, consider installing it (see the CONTRIBUTING.org file)."
else
	@shellcheck g.sh
endif
