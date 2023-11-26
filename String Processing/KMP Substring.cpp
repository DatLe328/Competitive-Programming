//https://oj.vnoi.info/problem/substr
//Print position that appear patterm string
#include<bits/stdc++.h>
using namespace std;

vector<int> prefix_function(string s) {
	int n = s.length();
	vector<int> f(n);
	for (int i = 1; i < n; i++) {
		int j = f[i - 1];
		while (j && s[i] != s[j])
			j = f[j - 1];
		if (s[i] == s[j])
			j++;
		f[i] = j;
	}
	return f;
}

void solve() {
	string s, t;	cin >> s >> t;
	int n = s.size();
	int m = t.size();
	vector<int> f = prefix_function(t);
	
	for (int i = 0, j = 0; i < n; i++) {
		while (j && s[i] != t[j])
			j = f[j - 1];
		if (s[i] == t[j])
			j++;
		if (j == m)
			cout << i - j + 2 << ' ';
	}
}

int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	solve();
	return 0;
}
