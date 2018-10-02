#include<bits/stdc++.h>
#include<tr1/unordered_map>
using namespace std;
using namespace std::tr1;
#define N 5005
unsigned short cell[N][N] = { 0 };

class Cells {
	//	unsigned short cell[N][N] = {0};
	unordered_map<string, int> cellToNum;
	unordered_map<string, int> geneToNum;
	unordered_map<int, string> numToCell;
	unordered_map<int, string> numToGene;
public:
	void readFile();
	void findCell(string cellName);
	void findGene(string geneName);
	void findCellAndGene(string cellName, string geneName);
	unsigned short strToNum(string str);
};

unsigned short Cells::strToNum(string str) {
	unsigned short sum = 0;
	for (int i = 0; i < str.size(); i++) {
		sum = sum * 10 + (str[i] - '0');
	}
	return sum;
}
void Cells::readFile() {
	ifstream inFile("scimpute-0.01-1-data.csv", ios::in);
	string lineStr;
	string geneName;
	string str;
	int i = 0;
	if (getline(inFile, lineStr)) {
		stringstream ss(lineStr);
		while (getline(ss, str, ',')) {
			cellToNum[str] = i;
			numToCell[i] = str;
			i++;
		}
	}

	i = 1;
	while (getline(inFile, lineStr)) {
		stringstream ss(lineStr);
		int flag = 0, j = 1;
		while (getline(ss, str, ',')) {
			if (flag == 0) {
				geneToNum[str] = i;
				numToGene[i] = str;
				flag = 1;
			}
			else {
				cell[i][j] = strToNum(str);
				j++;
			}
		}
		i++;
	}
}

void Cells::findCell(string cellName) {
	cellName = "\"" + cellName + "\"";
	int index = cellToNum[cellName];
	for (int i = 0; i < geneToNum.size(); i++) {
		if (cell[i][index])
			cout << numToGene[i] << " " << cell[i][index] << endl;
	}
}

void Cells::findGene(string geneName) {
	geneName = "\"" + geneName + "\"";
	int index = geneToNum[geneName];
	for (int i = 0; i < cellToNum.size(); i++) {
		if (cell[i][index])
			cout << numToCell[i] << " " << cell[i][index] << endl;
	}
}

void Cells::findCellAndGene(string cellName, string geneName) {
	cellName = "\"" + cellName + "\"";
	geneName = "\"" + geneName + "\"";
	cout << cell[geneToNum[geneName]][cellToNum[cellName]] << endl;
}

int main() {
	Cells cells;
	cells.readFile();
	//	cells.findCell("AAACCTGAGCCACTAT.1");
	//	cells.findGene("ENSMUSG00000037221");
	cells.findCellAndGene("AAACCTGAGCCACTAT.1", "ENSMUSG00000015312");
	return 0;
}
