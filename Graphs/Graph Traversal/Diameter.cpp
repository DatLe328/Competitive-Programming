//Find the longest path in the graph
/*  First, we choose an arbitrary node a in the tree and find the
    farthest node b from a. Then, we find the farthest node c from b. The diameter
    of the tree is the distance between b and c.  
*/
//input
 7 6
 1 2
 1 3
 2 5
 2 6
 1 4
 4 7

expected
4
    */
#include<bits/stdc++.h>
using namespace std;
const int maxn = 1e5 + 1;

vector<int> adj[maxn];
int m, n, visited[maxn], maxVal = 0, maxIdx = 0;
void dfs(int u, int cnt) {
  	visited[u] = 1;
  	if (cnt > maxVal) {
    		maxVal = cnt;
    		maxIdx = u;
  	}
  	for (int v : adj[u]) {
    		if (!visited[v])
    			  dfs(v, cnt + 1);
  	}
  	visited[u] = 0;
}

void solve() {
  	cin >> n >> m;
  	for (int i = 0; i < m; i++) {
    		int u, v;	cin >> u >> v;
    		adj[u].push_back(v);
    		adj[v].push_back(u);
  	}
  
  	for (int i = 1; i <= n; i++)
    		dfs(i, 0);
  	dfs(maxIdx, 0);
  	cout << maxVal;
}

int main() {
  	solve();
  	return 0;
}
