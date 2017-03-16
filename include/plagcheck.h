#ifndef __PLAGCHECK_H__
#define __PLAGCHECK_H__

#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <map>
#include <stdlib.h>
#include <iomanip>
#include <stdint.h>
#include <math.h>

using namespace std;

#define threshold 1
#define minblock 2
#define allow 10

enum Opcode {
    ADD,
    SUB,
    MUL,
    DIV,
    MOD,
    CMP,
    AND,
    OR,
    NOT,
    MOV,
    LSL,
    LSR,
    ASR,
    NOP,
    LD,
    ST,
    BEQ,
    BGT,
    B,
    CALL,
    RET
};

struct character {
    char c;
    int address;
};

class plagcheck {
        public:
            plagcheck(char *inputfile1, char *inputfile2,int x,int y);
        private:
            void stringify(char *input, vector<vector<character*> > &output);
            void check(vector<vector<character*> > p1, vector<vector<character*> > p2, char *inputfile1, char *inputfile2, int x, int y);
            void initOpcodes();
            void removeInitialWhiteSpace(string &);
            void removeWhiteSpace(string &);
            bool isComment(string &);
            bool isEmpty(string &);
            void lowerCase(string &input);
            bool encodeInstruction(string &line, int &opcode, int &I);
            bool isimm(string &input);
            int levenshtein (string s, string t);
            string constructstring (vector <character*> x );
            void display (int i, int j, char *inputfile1, char *inputfile2, char *file);
            string displayfileline (char *inputfile, int x);

        private:
            map<string, Opcode> opcodes;
            vector<vector<character*> > program1;
            vector<vector<character*> > program2;
            vector <string> prog1;
            vector <string> prog2;

};


#endif