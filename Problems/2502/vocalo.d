import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] ss, ls, ps;
    foreach (_; 0..N) {
        auto slp = readln.split.to!(int[]);
        ss ~= slp[0];
        ls ~= slp[1];
        ps ~= slp[2];
    }
    auto DP = new int[][](N+1, 393+1);
    foreach (ref dp; DP) dp[] = int.min;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (f; 0..393+1) {
            DP[i+1][f] = max(DP[i+1][f], DP[i][f]);
            foreach (d; ss[i]..ls[i]+1) {
                if (f+d <= 393) DP[i][f+d] = max(DP[i][f+d], DP[i][f] + ps[i]);
            }
        }
    }
    foreach (i; 1..N+1) {
        foreach (f; 0..393+1) {
            DP[i][f] = max(DP[i][f], DP[i-1][f]);
        }
    }
    auto M = readln.chomp.to!int;
    int[] res;
    foreach (_; 0..M) {
        auto m = DP[N][readln.chomp.to!int];
        if (m <= 0) {
            writeln(-1);
            return;
        }
        res ~= m;
    }
    foreach (r; res) writeln(r);
}