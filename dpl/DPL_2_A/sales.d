import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "to", int, "d");

void main()
{
    auto ve = readln.split.to!(int[]);
    auto V = ve[0];
    auto E = ve[1];

    P[][] ps;
    ps.length = V;
    foreach (_; 0..E) {
        auto std = readln.split.to!(int[]);
        auto s = std[0];
        auto t = std[1];
        auto d = std[2];
        ps[s] ~= P(t, d);
    }

    auto DP = new int[][][](V, V, 1<<V);
    foreach (ref dp; DP) foreach (ref dp2; dp) dp2[] = -1;

    int solve(int i, int f, uint s) {
        if (s == (1<<V)-1) {
            foreach (n; ps[i]) if (n.to == f) return n.d;
            return int.max/3;
        }
        if (DP[i][f][s] == -1) {
            auto r = int.max/2;
            foreach (n; ps[i]) if (!(s & (1<<n.to))) {
                r = min(r, solve(n.to, f, s | (1<<n.to)) + n.d);
            }
            DP[i][f][s] = r;
        }
        return DP[i][f][s];
    }
    auto r = int.max;
    foreach (i; 0..V) r = min(r, solve(i, i, 1<<i));
    if (r > 15000) r = -1;
    writeln(r);
}