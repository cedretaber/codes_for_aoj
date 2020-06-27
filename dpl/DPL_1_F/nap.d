import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nw = readln.split.to!(int[]);
    auto N = nw[0];
    long W = nw[1];
    int[] vs;
    long[] ws;
    foreach (_; 0..N) {
        auto vw = readln.split.to!(int[]);
        vs ~= vw[0];
        ws ~= vw[1];
    }

    auto DP = new long[][](N+1, 100*N+1);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (v; 0..100*N+1) {
            DP[i+1][v] = min(DP[i+1][v], DP[i][v]);
            if (v >= vs[i]) DP[i+1][v] = min(DP[i+1][v], DP[i][v-vs[i]] + ws[i]);
        }
    }
    foreach_reverse (v; 0..100*N+1) if (DP[N][v] <= W) {
        writeln(v);
        return;
    }
}