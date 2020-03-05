import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto nw = readln.split.to!(int[]);
    auto N = nw[0];
    auto W = nw[1];
    int[] vs, ws;
    foreach (_; 0..N) {
        auto vw = readln.split.to!(int[]);
        vs ~= vw[0];
        ws ~= vw[1];
    }

    auto DP = new int[][](N+1, W+1);
    foreach (i; 0..N) {
        foreach (j; 0..W+1) {
            auto w = j-ws[i];
            if (w >= 0) {
                DP[i+1][w] = max(DP[i+1][w], DP[i][j] + vs[i]);
            }
            DP[i+1][j] = max(DP[i+1][j], DP[i][j]);
        }
    }
    int r = -1;
    foreach (dp; DP[N]) r = max(r, dp);
    writeln(r);
}