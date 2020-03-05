import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int solve(int n, int x, int p) {
        if (p == 0) return x == 0 ? 1 : 0;
        if (n == 0) return 0;
        int r;
        if (x >= n) r += solve(n-1, x-n, p-1);
        r += solve(n-1, x, p);
        return r;
    }

    for (;;) {
        auto nx = readln.split.to!(int[]);
        auto n = nx[0];
        auto x = nx[1];
        if (n == 0 && x == 0) return;
        writeln(solve(n, x, 3));
    }
}