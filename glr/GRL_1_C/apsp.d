import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ve = readln.split.to!(int[]);
    auto V = ve[0];
    auto E = ve[1];
    auto G = new long[][](V, V);
    foreach (i, ref g; G) {
        g[] = long.max/3;
        g[i] = 0;
    }
    foreach (_; 0..E) {
        auto std = readln.split.to!(int[]);
        G[std[0]][std[1]] = std[2];
    }

    foreach (k; 0..V) {
        foreach (i; 0..V) {
            foreach (j; 0..V) {
                if (G[i][j] > G[i][k] + G[k][j]) {
                    G[i][j] = G[i][k] + G[k][j];
                }
            }
        }
    }
    auto G2 = new long[][](V, V);
    foreach (i; 0..V) foreach (j; 0..V) G2[i][j] = G[i][j];
    foreach (k; 0..V) {
        foreach (i; 0..V) {
            foreach (j; 0..V) {
                if (G[i][j] > G[i][k] + G[k][j]) {
                    G[i][j] = G[i][k] + G[k][j];
                }
            }
        }
    }
    foreach (i; 0..V) foreach (j; 0..V) if (G2[i][j] != G[i][j]) {
        writeln("NEGATIVE CYCLE");
        return;
    }
    auto R = new string[][](V, V);
    foreach (i; 0..V) foreach (j; 0..V) {
        if (G[i][j] >= long.max/4) {
            R[i][j] = "INF";
        } else {
            R[i][j] = G[i][j].to!string;
        }
    }

    foreach (r; R) writeln(r.join(" "));
}