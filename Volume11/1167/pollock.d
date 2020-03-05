import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto DP1 = new int[](10^^6+1);
    auto DP2 = new int[](10^^6+1);

    foreach (x; 1..10^^6+1) {
        auto r = int.max/3, s = int.max/3;
        foreach (n; 1..181) {
            auto d = n*(n+1)*(n+2)/6;

            if (x-d >= 0) r = min(r, DP1[x-d] + 1);
            if (d%2 == 1 && x-d >= 0) s = min(s, DP2[x-d] + 1);
        }
        DP1[x] = r;
        DP2[x] = s;
    }

    for (;;) {
        auto N = readln.chomp.to!int;
        if (N == 0) return;

        writefln("%d %d", DP1[N], DP2[N]);
    }
}