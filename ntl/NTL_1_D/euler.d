import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, core.bitop;

Tuple!(N, N)[] prime_division(N)(N n)
{
    auto nn = n;
    Tuple!(N, N)[] res;
    for (N i = 2; i^^2 <= nn; ++i) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != cast(N)1) res ~= tuple(n, cast(N)1);
    return res;
}

void main()
{
    auto N = readln.chomp.to!long;
    long[] ps;
    foreach (p; prime_division(N)) {
        ps ~= p[0];
    }

    auto r = N;
    foreach (x; 1..(1<<(ps.length))) {
        long n = 1;
        foreach (i; 0..ps.length) if (x & (1L<<i)) n *= ps[i];
        r += N/n * (-1)^^popcnt(x);
    }
    writeln(r);
}