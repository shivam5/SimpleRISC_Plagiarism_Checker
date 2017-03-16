#include <plagcheck.h>
#include <dirent.h>

int main(int argc, char** argv) {

	vector <char *> v;
	vector<string> t;
    string s=argv[1], x;

    if(argc != 2) {
        std::cout << "Command format is assembler <directory>" << std::endl;
        exit(1);
    }

    DIR *dir;
	struct dirent *ent;
	if ((dir = opendir (argv[1])) != NULL) {
	  /* print all the files and directories within directory */
	  while ((ent = readdir (dir)) != NULL) {
	   	if (ent->d_name[0]!='.'){ 
		    t.push_back(ent->d_name);
		}
	  }
	  closedir (dir);
	} else {
	  /* could not open directory */
	  perror ("");
	  return EXIT_FAILURE;
	}

	if (s[(s.size()-1)]!='/')
		s+='/';

	for(int i=0; i<t.size(); i++)
		t[i]=s+t[i];		

	for(int i=0; i<t.size(); i++)
		v.push_back(const_cast<char*>(t[i].c_str()));

	for (int i=0; i<v.size(); i++){
		for (int j=i+1; j<v.size(); j++)
			plagcheck p(v[i],v[j],i,j);
	}

//    plagcheck p(argv[1], argv[2]);
    return 0;
}
