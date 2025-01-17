#import "@preview/showybox:2.0.1": showybox

#import "@preview/codly:0.2.0": *
#show: codly-init.with()

#import "@preview/lovelace:0.2.0": *
#show: setup-lovelace

#set page(
  paper: "a4"
)
#set page(numbering: "1")
#counter(page).update(1)


#codly(
  languages: (
    cpp: (
      name: "C++",
      icon: "", //text(font: "FiraCode Nerd Font", "\u{e61d}"),
      color: rgb("#2995df")
    ),
  )
)
#set page(
  header: [
    #grid(columns: (50%, 50%),
        grid.cell( "Linear Algebra for Computer Science", ),
        grid.cell( "Matteo Bongiovanni (S5560349)",align: right ),
      )
  Homework 4
  ]
)
#set heading(numbering: "1.")
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#outline(indent: auto)


Compilation Command

`g++ -std=c++11 -O2 -Wall test.cpp -o test`

= Template

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
using ld = long double;
#define FOR(a, c) for (int(a) = 0; (a) < (c); (a)++) 
#define FAST_IO                     \
  ios_base::sync_with_stdio(false); \
  cin.tie(0);                       \
  cout.tie(0);

int main() {
}
```

= Number Theory
== GCD
```cpp
template <typename T>
inline T gcd(T a, T b) {
  if (b == 0) {
    return a;
  }
  return gcd(b, a % b);
}
```

== Primes
```cpp
bool isPrime(int n) {
  if (n < 2) {
    return false;
  }
  for (int x = 2; x * x <= n; ++x) {
    if (n % x == 0) {
      return false;
    }
  }
  return true;
}

vector<int> getFactors(int n) {
  vector<int> facts;
  for (int x = 2; x * x <= n; ++x) {
    while (n % x == 0) {
      facts.push_back(x);
      n /= x;
    }
  }
  if (n > 1) {
    facts.push_back(n);
  }
  return facts;
}
```

= Graph
== Dijkstra

```cpp
// Time Complexity: O(E log V)
// Space Complexity: O(V + E)
#include <bits/stdc++.h>
using namespace std;
#define int long long
#define fi first
#define se second

typedef pair<int, int> ii;
signed main() {
    ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int v, e; cin >> v >> e;

    vector<ii> adj[v];
    int dist[v];

    for (int i = 0; i < v; i++) dist[i] = INT64_MAX;
    for (int i = 0; i < e; i++) {
        int u, v, wi; cin >> u >> v >> wi; u--, v--;
        adj[u].push_back(ii(v, wi));
        adj[v].push_back(ii(u, wi));
    }

    priority_queue<ii> q; // (dist, node)
    q.push(ii(-0, 0));
    while(!q.empty()) {
        ii cur = q.top(); q.pop();
        int curDist = -cur.fi, curNode = cur.se;

        if (curDist > dist[curNode]) continue;

        for (int i = 0; i < adj[curNode].size(); i++) {
            ii nx = adj[curNode][i];
            int nxDist = curDist + nx.se;
            if (nxDist < dist[nx.fi]) {
                dist[nx.fi] = nxDist;
                q.push(ii(-nxDist, nx.fi));
            }
        }   
    }
    cout << dist[v-1] << '\n';
}

```

== Floyd Warshall

```cpp
int main() {
    ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    ll t; cin >> t;

    while (t--) {
        string s; cin >> s;
        ll n = s.size();
        
        ll adj[n][n]; adj[0][0] = 0;
        
        for (ll j=1; j<n; j++) adj[0][j] = (s[j]=='Y'?1:1e9);
        for (ll i=1; i<n; i++) {
            cin >> s;
            for (ll j=0; j<n; j++) {
                if (i == j) adj[i][j] = 0;
                else adj[i][j] = (s[j]=='Y'?1:1e9);
            }
        }

        for (ll k=0; k<n; k++) {
            for (ll i=0; i<n; i++) {
                for (ll j=0; j<n; j++) {
                    adj[i][j] = min(adj[i][j], adj[i][k] + adj[k][j]);
                }
            }
        }

        ll mxVal = 0, mxInd = 0;
        for (ll i=0; i<n; i++) {
            ll ans = 0;
            for (ll j=0; j<n; j++) {
                if (adj[i][j] == 2) ans++;
            }
            
            if (ans > mxVal) {
                mxVal = ans;
                mxInd = i;
            }
        }

        cout << mxInd << ' ' << mxVal << '\n';
    }
}
```
