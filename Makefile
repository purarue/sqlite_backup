.DEFAULT_GOAL := install

install:
	python3 -m pip install .

docs: install
	python3 -m pip list --format=freeze | cut -d"=" -f1 | grep -x 'pdoc3' -q || python3 -m pip install pdoc3
	rm -rf ./docs
	pdoc3 -o ./docs sqlite_backup
	# replace pathlib._local with pathlib in the generated docs
	sed -i 's/pathlib._local/pathlib/g' docs/sqlite_backup/*.md
