import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias C = Tuple!(int, "size", int, "p");

void solve(int N, int M)
{
    auto CS = new int[](N);
    foreach (s; readln.split.to!(int[])[1..$]) CS[s-1] = 0;
    foreach (s; readln.split.to!(int[])[1..$]) CS[s-1] = 1;
    foreach (s; readln.split.to!(int[])[1..$]) CS[s-1] = 2;

    int s, min_s, max_s = 3^^N-1;
    foreach_reverse (c; CS) {
        s *= 3;
        s += c;
    }
    if (s == min_s || s == max_s) {
        writeln(0);
        return;
    }
    auto memo = new bool[](3^^N);
    memo[s] = true;
    auto ss = [s];
    foreach (cnt; 1..M+1) {
        int[] nss;
        foreach (x; ss) {
            int a = -1, b = -1, c = -1;
            foreach (i; 0..N) {
                CS[i] = x%3;
                x /= 3;
                switch (CS[i]) {
                    case 0: a = i.to!int; break;
                    case 1: b = i.to!int; break;
                    default: c = i.to!int;
                }
            }
            int add() {
                int y;
                foreach_reverse (x; CS) {
                    y *= 3;
                    y += x;
                }
                return y;
            }
            int r = -1;
            if (a > b) {
                CS[a] = 1;
                r = add();
                CS[a] = 0;
            } else if (a < b) {
                CS[b] = 0;
                r = add();
                CS[b] = 1;
            }
            if (r != -1 && !memo[r]) {
                if (r == min_s || r == max_s) {
                    writeln(cnt);
                    return;
                }
                nss ~= r;
                memo[r] = true;
            }
            r = -1;
            if (b > c) {
                CS[b] = 2;
                r = add();
                CS[b] = 1;
            } else if (b < c) {
                CS[c] = 1;
                r = add();
                CS[c] = 2;
            }
            if (r != -1 && !memo[r]) {
                if (r == min_s || r == max_s) {
                    writeln(cnt);
                    return;
                }
                nss ~= r;
                memo[r] = true;
            }
        }
        ss = nss;
    }
    writeln(-1);
}

void main()
{
    for (;;) {
        auto nm = readln.split.to!(int[]);
        auto N = nm[0];
        auto M = nm[1];
        if (N == 0 && M == 0) break;
        solve(N, M);
    }
}