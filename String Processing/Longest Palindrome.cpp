#include<bits/stdc++.h>
#define ll long long
using namespace std;

const int maxn = 1e6 + 1;
const ll mod = 1e9 + 7;
const int base = 127;

string s;
int n, maxval = 1, maxpos = 1;

ll POW[maxn], h[maxn], rh[maxn];

ll ihash(int i, int j) {
	return (h[j] - h[i - 1] * POW[j - i + 1] + mod * mod) % mod;
}

ll rhash(int i, int j) {
	return (rh[i] - rh[j + 1] * POW[j - i + 1] + mod * mod) % mod;
}

void init() {
	POW[0] = 1;
	for (int i = 1; i <= n; i++) {
		POW[i] = (POW[i - 1] * base) % mod;
		h[i] = (h[i - 1] * base + s[i] - 'a' + 1) % mod;
	}

	for (int i = n; i > 0; i--)
		rh[i] = (rh[i + 1] * base + s[i] - 'a' + 1) % mod;
}

bool check(int l) {
	for (int i = 1; i <= n - l + 1; i++)
		if (ihash(i, i + l - 1) == rhash(i, i + l - 1)) {
			if (maxval < l) {
				maxval = l;
				maxpos = i;
			}
			return true;
		}
	return false;
}
int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	cin >> s;
	n = s.size();
	s = " " + s + " ";

	init();

	int low = 1, high = n - (n % 2 == 0);
	while (low < high) {
		int mid = low + high >> 1;
		if (mid % 2 == 0)	mid++;
		if (check(mid))
			low = mid;
		else
			high = mid - 2;
	}
	int res = low;
	low = 0;
	high = n - n % 2;
	while (low < high) {
		int mid = low + high >> 1;
		if (mid % 2)	mid++;
		if (check(mid))
			low = mid;
		else
			high = mid - 2;
	}

	cout << max(res, low) << '\n';
	cout << s.substr(maxpos, maxval);
	return 0;
}	
