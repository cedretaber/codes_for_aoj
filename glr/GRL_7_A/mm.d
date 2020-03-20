import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct Graph(T)
{
    T L, R;
    T[][] adj;

    this(T L, T R)
    {
        this.L = L;
        this.R = R;
        adj.length = L + R;
    }

    void add_edge(T u, T v)
    {
        adj[u] ~= v+L;
        adj[v+L] ~= u;
    }

    T maximum_matching()
    {
        bool[] visited;
        T[] meta;
        visited.length = L;
        meta.length = L + R;
        meta[] = -1;

        bool augment(T u) {
            if (visited[u]) return false;
            visited[u] = true;
            foreach (w; adj[u]) {
                auto v = meta[w];
                if (v < 0 || augment(v)) {
                    meta[u] = w;
                    meta[w] = u;
                    return true;
                }
            }
            return false;
        }

        auto match = 0;
        foreach (u; 0..L) {
            visited[] = false;
            if (augment(u)) ++match;
        }
        return match;
    }
}

void main()
{
    auto xye = readln.split.to!(int[]);
    auto X = xye[0];
    auto Y = xye[1];
    auto E = xye[2];

    auto G = Graph!int(X, Y);
    foreach (_; 0..E) {
        auto xy = readln.split.to!(int[]);
        G.add_edge(xy[0], xy[1]);
    }
    writeln(G.maximum_matching());
}