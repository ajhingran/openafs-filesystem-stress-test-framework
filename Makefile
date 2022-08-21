clean:
	@echo "Cleaning test files..."
	@rm -rf `find . -type d -name 'testFiles*'`
	@rm -rf metrics
	@echo "Cleaned"
	@rm -rf test-directory

removeexec:
	rm -f setupexec
	rm -f setup
	rm -f fileexec-1
	rm -f fileexec-2
	rm -f filemonkeytester
	rm -f fileexec

init: setupexec
	@echo "Setting up test directories and files... (Will take some time)"
	@./setupexec

setupexec: setup.c config-parser.c
	@gcc -o setupexec setup.c config-parser.c -Wall

run: fileexec
	@./fileexec

fileexec: filetest filetester.c config-parser.c
	@gcc -o fileexec filetester.c config-parser.c -Wall

filetest: filemonkeytest.c fileoperations.c config-parser.c
	@gcc -o filemonkeytester filemonkeytest.c fileoperations.c config-parser.c -Wall

fileexec-1: fileoperations.c filemonkeytest-1.c
	@gcc -o fileexec-1 filemonkeytest-1.c fileoperations.c -Wall

fileexec-2: fileoperations.c filemonkeytest-2.c
	@gcc -o fileexec-2 filemonkeytest-2.c fileoperations.c -Wall
reset: clean init run