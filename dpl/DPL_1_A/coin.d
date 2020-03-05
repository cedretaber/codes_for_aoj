import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto CS = readln.split.to!(int[]);

    auto DP = new int[][](M+1, N+1);
    foreach (ref dp; DP) dp[] = int.max/3;
    DP[0][N] = 0;

    foreach (i; 0..M) {
        foreach_reverse (j; 0..N+1) {
            auto c = j-CS[i];
            if (c >= 0) {
                DP[i][c] = min(DP[i][c], DP[i][j] + 1);
            }
            DP[i+1][j] = min(DP[i+1][j], DP[i][j]);
        }
    }
    writeln(DP[M][0]);
}