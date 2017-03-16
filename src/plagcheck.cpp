#include <plagcheck.h>

plagcheck::plagcheck(char *inputfile1,char *inputfile2, int x, int y) {
    initOpcodes();
    stringify(inputfile1, program1);
    stringify(inputfile2, program2);
    check(program1, program2, inputfile1, inputfile2, x, y);
}

void plagcheck::stringify(char *input, vector<vector<character*> > &output){
    ifstream fin;
    fin.open(input);
    if(fin.fail()) {
        cout << "Invalid input file" << endl;
        exit(1);
    }

    string line, buff;
    vector <character*> S;
    character *encodec;
    int line_no = 0, opcode,prevopcode=0, I, encoding;


    while(getline(fin, buff)) {
        line_no++;

        encodec = new character;
        line = buff;
        removeInitialWhiteSpace(line);
        if(isComment(line)) {
            continue;
        }
        if(isEmpty(line)) {
            continue;
        }
        if(line.length() == 0) {
            continue;
        }

        //find if it is a label
        if(line.find(':') != string::npos) {
            //There is a label
            if (S.size()>0)
                output.push_back(S);
            S.clear();

            string rest;
            rest = line.substr(line.find_first_of(':') + 1, string::npos);
            removeInitialWhiteSpace(rest);
            if(isEmpty(rest) || isComment(rest)) {
                continue;
            }
            line=rest;
        }

        // Comments, whitespaces, labels all removed.
        if(encodeInstruction(line, opcode, I)) {
            encoding = (opcode << 1) | I;
            
            if (prevopcode == B || prevopcode == BEQ || prevopcode == BGT || prevopcode == RET){
                if (S.size()>0)
                    output.push_back(S);
                S.clear();
            }

            prevopcode = opcode;

            encodec->c = encoding+40;
            encodec->address = line_no;
            S.push_back(encodec);

        } else {
            continue;
        }
    }
    if (S.size()>0){
        output.push_back(S);
    }

    fin.close();
}

void plagcheck::check(vector<vector<character*> > p1, vector<vector<character*> > p2,char *inputfile1,char *inputfile2, int x, int y){
    int i,j;
    float matched=0, totala=0, totalb=0, total, lev, blocksize; 
    float matrix;

    for(i=0; i<p1.size(); i++){
        prog1.push_back(constructstring(p1[i]));
        totala += p1[i].size();
    }

    for(i=0; i<p2.size(); i++){
        prog2.push_back(constructstring(p2[i]));
        totalb += p2[i].size();
    }

    total = totala + totalb;

    for(i=0; i<prog1.size();i++){
        for(j=0; j<prog2.size(); j++){
            lev=levenshtein(prog1[i], prog2[j]);
            blocksize = min(prog1[i].length(), prog2[j].length());
            if(lev<=threshold && blocksize > minblock){
                //matched += (prog1[i].length() + prog2[j].length())/2;
                matched += (blocksize/(lev+1));
                //display(i,j, inputfile1, inputfile2);
            }
        }
    }

    matrix = (matched/total) * (threshold + 1) * 100;
    
    if (matrix > allow){
        cout<<"("<<x<<","<<y<<")"<<endl;
        cout<<inputfile1<<"\n"<<inputfile2<<"\nMatch - "<<matrix<<endl<<endl;

        stringstream ss;
        ss<<"result/"<<x<<"_"<<y;
        char* file = const_cast<char*>(ss.str().c_str());

        ofstream fout;
        fout.open(file);

        fout<<"("<<x<<","<<y<<")"<<endl;
        fout<<inputfile1<<"\n"<<inputfile2<<"\nMatch - "<<matrix<<"%"<<endl<<endl;

        fout.close();


        ofstream fout2;
        fout2.open("result/results", ofstream::out|ofstream::app);

        fout2<<"("<<x<<","<<y<<")"<<endl;
        fout2<<inputfile1<<"\n"<<inputfile2<<"\nMatch - "<<matrix<<"%"<<endl<<endl;

        fout2.close();
    

        for(i=0; i<prog1.size();i++){
            for(j=0; j<prog2.size(); j++){
                lev=levenshtein(prog1[i], prog2[j]);
                blocksize = min(prog1[i].length(), prog2[j].length());
                if(lev<=threshold && blocksize > minblock){
                    display(i,j, inputfile1, inputfile2, file);
                }
            }
        }

    }

}

void plagcheck::display (int i, int j, char *inputfile1, char *inputfile2, char *file){
    vector<character*> x1 = program1[i];
    vector<character*> x2 = program2[j];
    int a;

    ofstream fout1;
    fout1.open(file, ofstream::app);

    fout1<<"The matched blocks are :\n1st program : \n";
    for (a=0; a<x1.size(); a++){
        fout1<<displayfileline(inputfile1, x1[a]->address);
    }

    fout1<<"\n2nd program : \n";
    for (a=0; a<x2.size(); a++){
        fout1<<displayfileline(inputfile2, x2[a]->address);
    }

    fout1<<endl<<endl;
    fout1.close();

}

string plagcheck::displayfileline (char *inputfile, int x){
    ifstream fin1;
    string buff;
    stringstream ss;
    int i=0;
    fin1.open(inputfile);
    if(fin1.fail()) {
        cout << "Invalid input file" << endl;
        exit(1);
    }

    while(getline(fin1, buff)) {
        i++;
        if(i==x){
            ss<<"Line "<<i<<":"<<buff<<endl;
            return ss.str();
        }
    }
    fin1.close();    
    return NULL;
}

string plagcheck::constructstring (vector <character*> x ){
    string s="";
    for (int i=0; i<x.size();i++)
            s+=x[i]->c;
    return s;    
}

int plagcheck::levenshtein (string s, string t){
    int i,j,m,n,temp,tracker;
    m = s.length();
    n = t.length();
    int d[n+1][m+1];
 
    for(i=0;i<=m;i++)
        d[0][i] = i;
    for(j=0;j<=n;j++)
        d[j][0] = j;
 
    for (j=1;j<=m;j++)
    {
        for(i=1;i<=n;i++)
        {
            if(s[i-1] == t[j-1])
            {
                tracker = 0;
            }
            else
            {
                tracker = 1;
            }
            temp = min((d[i-1][j]+1),(d[i][j-1]+1));
            d[i][j] = min(temp,(d[i-1][j-1]+tracker));
        }
    }
    return d[n][m];
}

bool plagcheck::encodeInstruction(string &line, int &opcode, int &I){
    string opString;
    lowerCase(line);
    opString = line.substr(0, line.find_first_of(' '));
    line = line.substr(line.find_first_of(' ') + 1); //line is trimmed
    
    if(opcodes.find( opString) != opcodes.end()) {
        opcode = opcodes[opString];
        
        //TODO : Calculate I
        if (opcode == NOP || opcode == RET)
            I=0;
        else if (opcode == CALL || opcode == B || opcode == BEQ || opcode == BGT || opcode == LD || opcode == ST)
            I=1;
        else if (opcode == MOV || opcode ==NOT || opcode == CMP){
            isimm(line);
            if(isimm(line))
                I=1;
            else
                I=0;
        }
        else{
            isimm(line);
            isimm(line);
            if(isimm(line))
                I=1;
            else
                I=0;
        }
        return true;

    } else {
       return false;
    }

    return false;
}

bool plagcheck::isimm(string &input) {
    removeInitialWhiteSpace(input);
    string operString = input.substr(0, input.find_first_of(','));
    input = input.substr(input.find_first_of(',') + 1); //input is trimmed
    lowerCase(operString);
    if(operString[0] == 'r' && operString[1] == 'a')
        return false;
    else if(operString[0] == 'r') 
        return false;
    else if(operString[0] == 's' && operString[1] == 'p')
        return false;
    //not a register, so must be an immediate
    return true;
}

void plagcheck::lowerCase(string &input) {
    int i;
    for(i=0; i < input.size(); i++) {
        input[i] = tolower(input[i]);
    }
}

void plagcheck::removeInitialWhiteSpace(string &str) {
    if(str.length() == 0) return;
    size_t first = str.find_first_not_of(" \t");
    if(first == string::npos) {
       str = "";
       return;
    }
    str = str.substr(first); //return the string from 'first' non space character till the end
    return;
}

//remove all the white space found in the string
void plagcheck::removeWhiteSpace(string &input) {
    string output;
    int i;
    for(i=0; i < input.length(); i++) {
        if(input[i] != ' ' && input[i] != '\t')
            output += input[i];
    }
    input = output;
}

bool plagcheck::isComment(string &str) {
    if((str[0] == '%') || (str[0] == '#') || (str[0] == '@'))
        return true;
    if(str[0] == '/' && str[1] == '/')
        return true;
    if(str[0] == '/' && str[1] == '*') {
        return true;
    }
    return false;
}

bool plagcheck::isEmpty(string &str) {
    if(str.length() == 0) return true;
}


void plagcheck::initOpcodes() {
    opcodes["add"] = ADD; //0
    opcodes["sub"] = SUB; //1
    opcodes["mul"] = MUL; //2
    opcodes["div"] = DIV; //3
    opcodes["mod"] = MOD; //4
    opcodes["cmp"] = CMP; //5
    opcodes["and"] = AND; //6
    opcodes["or"]  = OR;  //7
    opcodes["not"] = NOT; //8
    opcodes["mov"] = MOV; //9
    opcodes["lsl"] = LSL; //10
    opcodes["lsr"] = LSR; //11
    opcodes["asr"] = ASR; //12
    opcodes["nop"] = NOP; //13
    opcodes["ld"]  = LD;  //14
    opcodes["st"]  = ST;  //15
    opcodes["beq"] = BEQ; //16
    opcodes["bgt"] = BGT; //17
    opcodes["b"]   = B;   //18
    opcodes["call"]= CALL;//19
    opcodes["ret"] = RET; //20
    opcodes[".print"] = NOP; //Nullyfy the .print macro for now.
}