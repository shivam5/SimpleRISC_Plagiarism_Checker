all:
	g++ -g -I./include src/plagcheck.cpp src/main.cpp -o ./bin/plagcheck

clean:
	rm -f bin/* src/*.bak
