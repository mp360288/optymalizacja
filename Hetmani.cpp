#include <iostream>
#include <fstream>
using namespace std;
void hetman(int n)
{
    fstream file;
    file.open("hetmani.txt",ios::out);
	file<<"Maximize\n";
	for(int i=0;i<n;i++)
	{
		for(int j=0;j<n;j++)
		{
			file<<"x"<<i<<"_"<<j;
			if((j!=i) || (j!=(n-1))) file<<"+";
		}
	}
	file<<"\n\nSubject To\n";
	for(int i=0;i<n;i++)
	{
		file<<"x"<<i<<"_"<<0;
		for(int j=1;j<n;j++)
		{
			file<<"+x"<<i<<"_"<<j;
		}
		file<<"<=1\n";
	}
	for(int i=0;i<n;i++)
	{
		file<<"x"<<0<<"_"<<i;
		for(int j=1;j<n;j++)
		{
			file<<"+x"<<j<<"_"<<i;
		}
		file<<"<=1\n";
	}
	//
    for(int i=1;i<n;i++)
	{
		file<<"x"<<0<<"_"<<i;
		for(int j=1;j<i+1;j++)
		{
			file<<"+x"<<j<<"_"<<i-j;
		}
		file<<"<=1\n";
	}
    for(int i=1;i<n;i++)
	{
		file<<"x"<<n-1<<"_"<<i;
		for(int j=1;j<i+1;j++)
		{
			file<<"+x"<<n-j-1<<"_"<<i-j;
		}
		file<<"<=1\n";
	}
	//
	  for(int i=1;i<n-1;i++)
	{
		file<<"x"<<n-1<<"_"<<n-i-1;
		for(int j=1;j<i+1;j++)
		{
			file<<"+x"<<n-j-1<<"_"<<n-i+j-1;
		}
		file<<"<=1\n";
	}
    for(int i=1;i<n-1;i++)
	{
		file<<"x"<<0<<"_"<<n-i-1;
		for(int j=1;j<i+1;j++)
		{
			file<<"+x"<<j<<"_"<<n-i+j-1;
		}
		file<<"<=1\n";
	}

	file<<"\nBounds\n";
	for(int i=0;i<n;i++)
	{
		for(int j=0;j<n;j++)
		{
			file<<"x"<<i<<"_"<<j<<"<=1\n";
			file<<"x"<<i<<"_"<<j<<">=0\n";
		}
	}
	file<<"\nGenerals\n";
	for(int i=0;i<n;i++)
	{
		for(int j=0;j<n;j++)
		{
			file<<"x"<<i<<"_"<<j<<"\n";
		}
	}
	file<<"End";
	file.close();
}

int main()
{
	int N;
	cin>>N;
    hetman(N);
}
