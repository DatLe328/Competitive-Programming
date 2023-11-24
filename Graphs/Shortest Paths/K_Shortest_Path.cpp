#include<bits/stdc++.h>
#define ar array
#define ll long long
using namespace std;

const int maxn = 1e5 + 1;
int n, m, k;
vector<ar<ll, 2>> adj[maxn];
priority_queue<ll> best[maxn];

void dijkstra(int s) {
	best[s].push(0);
	priority_queue<ar<ll, 2>, vector<ar<ll, 2>>, greater<ar<ll, 2>>> pq;
	pq.push({0, s});
	while (pq.size()) {
		auto [d, u] = pq.top();	pq.pop();
		if (d > best[u].top())	continue;
		for (auto [v, w] : adj[u]) {
			ll tmp = d + w;
			if (best[v].size() < k) {
				best[v].push(tmp);
				pq.push({tmp, v});
			}
			else if (best[v].top() > tmp) {
				best[v].pop();
				best[v].push(tmp);
				pq.push({tmp, v});
			}
		}
	}
}

void solve() {
	cin >> n >> m >> k;
	for (int i = 0; i < m; i++) {
		ll u, v, w;	cin >> u >> v >> w;
		adj[u].push_back({v, w});
	}
	dijkstra(1);
	vector<ll> ans;
	while (best[n].size()) {
		ans.push_back(best[n].top());
		best[n].pop();
	}
	reverse(ans.begin(), ans.end());
	for (ll i : ans)
		cout << i << ' ';
}

int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	solve();
	return 0;
}
