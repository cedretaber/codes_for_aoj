import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    long[] CS, xs;
    CS.length = 16;
    xs.length = 20000;
    auto DP = new long[][](20000, 256);

    for (;;) {
        auto nm = readln.split.to!(int[]);
        auto N = nm[0];
        auto M = nm[1];

        if (N == 0 && M == 0) return;
        foreach (i; 0..M) CS[i] = readln.chomp.to!long;
        foreach (i; 0..N) xs[i] = readln.chomp.to!long;

        foreach (ref dp; DP) dp[] = -1;
        long solve(int i, long n) {
            if (i == N) return 0;
            if (DP[i][n] == -1) {
                auto r = long.max/3;
                foreach (c; CS[0..M]) {
                    auto m = max(0, min(255, n+c));
                    r = min(r, solve(i+1, m) + (xs[i] - m)^^2);
                }
                DP[i][n] = r;
            }
            return DP[i][n];
        }
        writeln(solve(0, 128));
    }
}