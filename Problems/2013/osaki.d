import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int parse(string s)
{
    int r;

    if (s[0] == '0') {
        r += s[1] - '0';
    } else {
        r += s[0..2].to!int;
    }
    r *= 60;

    if (s[3] == '0') {
        r += s[4] - '0';
    } else {
        r += s[3..5].to!int;
    }
    r *= 60;

    if (s[6] == '0') {
        r += s[7] - '0';
    } else {
        r += s[6..8].to!int;
    }

    return r;
}

void main()
{
    for (;;) {
        auto N = readln.chomp.to!int;
        if (N == 0) return;

        auto tt = new int[](60*60*24);
        foreach (_; 0..N) {
            auto t = readln.split;
            ++tt[parse(t[0])];
            --tt[parse(t[1])];
        }
        int max_t = tt[0];
        foreach (i; 1..tt.length) {
            tt[i] += tt[i-1];
            max_t = max(max_t, tt[i]);
        }
        writeln(max_t);
    }
}