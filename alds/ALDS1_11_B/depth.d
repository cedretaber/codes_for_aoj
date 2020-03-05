import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;
    int[][] G;
    G.length = n;
    foreach (i; 0..n) {
        auto ukv = readln.split.to!(int[]);
        if (ukv[1] > 0) foreach (j; ukv[2..$]) G[i] ~= j-1;
    }

    auto ds = new int[](n);
    auto fs = new int[](n);
    int go(int i, int t) {
        ds[i] = t;
        foreach (j; G[i]) if (ds[j] == 0) t = go(j, t+1);
        fs[i] = t+1;
        return t+1;
    }
    int t = 1;
    foreach (i; 0..n) if (ds[i] == 0) t = go(i, t) + 1;
    foreach (i; 0..n) {
        writefln("%d %d %d", i+1, ds[i], fs[i]);
    }
}