#include<bits/stdc++.h>
using namespace std;

const int maxn = 1e5 + 1;
vector<int> adj[maxn];
int n, m, k, total_cycle = 0, visited[maxn];

void dfs(int start, int u, int cnt) {
	visited[u] = 1;
	if (cnt == 0) {
		visited[u] = 0;
		if (find(adj[u].begin(), adj[u].end(), start) != adj[u].end())
			total_cycle++;
		return;
	}

	for (int v : adj[u]) 
		if (!visited[v])
			dfs(start, v, cnt - 1);

	visited[u] = 0;
}

void solve() {
	cin >> n >> m >> k;
	for (int i = 0; i < m; i++) {
		int u, v;	cin >> u >> v;
		adj[u].push_back(v);
		adj[v].push_back(u);
	}
	for (int i = 1; i <= n; i++)
		if (!visited[i]) {
			dfs(i, i, k - 1);
			visited[i] = 1;
		}

	cout << total_cycle / 2;	//Intension
}

int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	solve();
	return 0;
}