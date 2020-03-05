import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] xs, ys;
    foreach (_; 0..N) {
        auto rc = readln.split.to!(int[]);
        xs ~= rc[1];
        ys ~= rc[0];
    }
    xs.length = 8;
    ys.length = 8;

    bool solve(int p, int n) {
        if (n == 8) return true;
        if (p == 64) return false;

        auto x = p%8;
        auto y = p/8;
        foreach (i; 0..n) {
            if (x == xs[i] || y == ys[i] || x+ys[i] == y+xs[i] || x+y == xs[i]+ys[i]) goto ng;
        }
        xs[n] = x;
        ys[n] = y;
        if (solve(p+1, n+1)) return true;
        ng:
        return solve(p+1, n);
    }

    solve(0, N);
    auto res = new char[][](8, 8);
    foreach (ref r; res) r[] = '.';
    foreach (i; 0..8) res[ys[i]][xs[i]] = 'Q';
    foreach (r; res) writeln(r);
}