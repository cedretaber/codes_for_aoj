import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto X = readln.chomp;
        auto Y = readln.chomp;

        auto DP = new int[][](X.length, Y.length);
        foreach_reverse (i; 0..X.length) {
            foreach_reverse (j; 0..Y.length) {
                if (X[i] == Y[j]) {
                    DP[i][j] = max(
                        DP[i][j],
                        (i+1 != X.length && j+1 != Y.length ? DP[i+1][j+1] : 0) + 1
                    );
                } else {
                    DP[i][j] = max(
                        i+1 != X.length ? DP[i+1][j] : 0,
                        j+1 != Y.length ? DP[i][j+1] : 0
                    );
                }
            }
        }
        writeln(DP[0][0]);
    }
}