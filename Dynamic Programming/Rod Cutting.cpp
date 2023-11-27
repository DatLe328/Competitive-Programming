*/ input
  8
  1 5 8 9 10 17 17 20
  expected
  22
*/
#include<bits/stdc++.h>
using namespace std;
const int maxn = 1000;
int opt[maxn], val[maxn];
int main() {
	int n;	cin >> n;
	for (int i = 1; i <= n; i++)
		cin >> val[i];
	for (int i = 0; i <= n; i++)
		opt[i] = 0;
	opt[1] = val[1];
	opt[0] = 0;
	for (int i = 2; i <= n; i++) {
		opt[i] = val[i];
		for (int j = 1; j <= i; j++)
			opt[i] = max(opt[j] + val[i - j], opt[i]);
	}
	// for (int i = 1; i <= n; i++)
	// 	cout << opt[i] << ' ';
	cout << opt[n];
	return 0;
}
