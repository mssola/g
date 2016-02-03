test ::
	@docker build -t mssola/g:latest .
	@docker run --rm mssola/g:latest bash test.sh
