import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] G;
    G.length = N;
    foreach (i; 0..N) {
        auto ukv = readln.split.to!(int[]);
        if (ukv[1] > 0) G[i] = ukv[2..$];
    }

    auto rr = new int[](N);
    rr[] = -1;
    rr[0] = 0;
    auto ss = [[0, 1]];
    while (!ss.empty) {
        auto s = ss[0];
        ss = ss[1..$];
        foreach (j; G[s[0]]) {
            --j;
            if (rr[j] == -1) {
                rr[j] = s[1];
                ss ~= [j, s[1]+1];
            }
        }
    }

    foreach (i; 0..N) {
        writefln("%d %d", i+1, rr[i]);
    }
}