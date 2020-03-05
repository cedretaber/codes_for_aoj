import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    for (;;) {
        auto N = readln.chomp.to!int;
        if (N == 0) return;

        auto ws = readln.split.to!(int[]);
        auto DP = new int[][](N, N);
        int max_l;
        foreach (i; 0..N-1) if (abs(ws[i] - ws[i+1]) <= 1) {
            DP[i][i+1] = 2;
        }
        foreach (jj; 1..N) {
            foreach (i; 0..N) {
                auto j = i+jj;
                if (j >= N) break;

                DP[i][j] = max(DP[i][j-1], DP[i+1][j]);
                if (abs(ws[i] - ws[j]) <= 1 && DP[i+1][j-1] == j-i-1) {
                    DP[i][j] = j-i+1;
                }
                foreach (k; i+1..j) {
                    DP[i][j] = max(DP[i][j], DP[i][k] + DP[k+1][j]);
                }
            }
        }
        writeln(DP[0][N-1]);
    }
}