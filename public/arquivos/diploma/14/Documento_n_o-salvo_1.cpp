#include<vector>
#include<cstdio>
#include<string>
#include<sstream>

using namespace std;
 
class GoodAndBadPostmen {

	public:
	vector <int> whoIsWho(vector <string> white, vector <string> black){
	vector <int> resposta = vector <int>(3);
	vector <string> bad;
	vector <string> good;
	vector <string> indef;
	string nome;
	int jatem = 0;
	int bons = 0;
	int total = 0;
	int jabad = 0;
	resposta[0] = 0;
	resposta[1] = 0;
	resposta[2] = 0;
		
	
		for(int i = 0; i < white.size() ; i ++){
			stringstream s;
			s << white[i];
			while(!s.eof()){
				jatem = 0;
				s >> nome;
				for(int j = 0; j < good.size(); j ++)
					if(good[j] == nome)
						jatem = 1;
				if(jatem == 0){
					good.push_back(nome);
					printf("%s ",nome.c_str());
					resposta[0]++;
				}
			
			} 
		}
		
		
		for(int i = 0; i < black.size() ; i ++){
			bons = 0;
			total = 0;
			stringstream s;
			s << black[i];
			while(!s.eof()){
				jatem = 0;
				s >> nome;
				for(int j = 0; j < good.size(); j ++)
					if(good[j] == nome){
						jatem = 1;
						bons ++;
					}
				total ++;
			} 
			if(total - bons <= 1){
				s << black[i];
				while(!s.eof()){
					jatem = 0;
					jabad = 0;
					s >>nome;
					for(int j = 0; j < good.size(); j ++)
						if(good[j] == nome){
							jatem = 1;
						}
					for(int j = 0; j < bad.size(); j ++)
						if(bad[j] == nome){
							jabad = 1;
						}
					if(jatem == 0 && jabad == 0){
						bad.push_back(nome);
						printf("%s ",nome.c_str());
						resposta[1]++;
					}
				} 
			}
			else{
				
				s << black[i];
				while(!s.eof()){
					jatem = 0;
					jabad = 0;
					s >>nome;
					for(int j = 0; j < good.size(); j ++)
						if(good[j] == nome){
							jatem = 1;
						}
			
					for(int j = 0; j < indef.size(); j ++)
						if(indef[j] == nome){
							jabad = 1;
						}
					if(jatem == 0 && jabad == 0){
						indef.push_back(nome);
						printf("%s ",nome.c_str());
						resposta[2]++;
					}
				}
			
			}
		
		}
	
	
	return resposta;
	
	}
};



