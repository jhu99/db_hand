#include<bits/stdc++.h>

using namespace std;

int k = 0;

class Cell{
	string cellName;
	map<string,string> cellGene;
	int hashValue;
	public:
		string getCellName();
		void setCellName(string cellName);
		map<string,string> getCellGene();
		void setCellGene(string key, string value);
		void setHashValue();
		int getHashValue();
};

void Cell::setHashValue(){
	int sum = 0;
	for(int i = 0;i < cellName.size();i++){
		if(cellName[i]=='A'){
			sum += 1;
		}
		else if(cellName[i]=='C'){
			sum += 2;
		}
		else if(cellName[i]=='G'){
			sum += 3;
		}
		else if(cellName[i]=='T'){
			sum += 4;
		}
	}	
	this->hashValue = sum;
}

int Cell::getHashValue(){
	return hashValue;	
}

void Cell::setCellName(string cellName){
	this->cellName = cellName;
}

string Cell::getCellName(){
	return cellName;
}

map<string,string> Cell::getCellGene(){
	return cellGene;
}

void Cell::setCellGene(string key, string value){
	cellGene[key] = value;
}

class Cells{
	Cell cells[1<<12];
	public:
	void readFile();
	void findCell(string cellName);
	void sortCell();
};

void Cells::readFile(){
	ifstream inFile("data.csv", ios::in);
	string lineStr;
	string geneName;
	string str;
	if(getline(inFile, lineStr)){
		stringstream ss(lineStr);
		while(getline(ss, str, ',')){
			cells[k].setCellName(str);
			cells[k].setHashValue();
			k++;
		}
	}
	
	while(getline(inFile, lineStr)){
		stringstream ss(lineStr);
		int flag = 0, i = 1;
		while(getline(ss, str, ',')){
			if(flag == 0){
				geneName = str;
				flag = 1;
			}
			else{
				if(str != "0"){
						cells[i].setCellGene(geneName,str);
				}
				i++;
			}
		}
	}
	
}

int cmp(Cell x, Cell y){
	return x.getHashValue() < y.getHashValue();
}
void Cells::sortCell(){
	sort(cells,cells+k,cmp);
}

void Cells::findCell(string name){
	Cell cell;
	cell.setCellName(name);
	cell.setHashValue();
	int key = cell.getHashValue();
	int left = 0,right = k,mid;
	while(left <= right){
		mid = (left + right)/2;
		if(key>cells[mid].getHashValue()) left = mid + 1;
		else if(key<cells[mid].getHashValue()) right = mid -1;
		else{
			for(map<string,string>::iterator it = cells[mid].getCellGene().begin();it != cells[mid].getCellGene().end();it++){
				cout<<it->first<<" "<<it->second<<endl;
			}
			break;
		}
	}
}

int main(){
	string cellName;
	Cells cells;
	cells.readFile();
	cells.sortCell();
	while(1){
		cout<<"请输入细胞名称,退出输入0"<<endl;
		cin>>cellName;
		if(cellName=="0")break;
		cells.findCell("\""+cellName+"\"");
		cout<<"-----------------------------------"<<endl;
	}
	return 0;
}
