import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] rs, cs;
    foreach (_; 0..N) {
        auto rc = readln.split.to!(long[]);
        rs ~= rc[0];
        cs ~= rc[1];
    }

    auto DP = new long[][](N, N);
    foreach (ref dp; DP) dp[] = long.max/3;
    foreach (i; 0..N-1) {
        DP[i][i] = 0;
        DP[i][i+1] = rs[i] * cs[i] * cs[i+1];
    }
    DP[N-1][N-1] = 0;
    foreach (jj; 2..N) {
        foreach (i; 0..N-2) {
            auto j = jj + i;
            if (j >= N) break;
            foreach (k; i..j) {
                DP[i][j] = min(DP[i][j], DP[i][k] + DP[k+1][j] + rs[i] * cs[k] * cs[j]);
            }
        }
    }
    writeln(DP[0][N-1]);
}