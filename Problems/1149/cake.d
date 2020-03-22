import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias R = Tuple!(int, "w", int, "d");

void solve(int n, int w, int d)
{
    auto rs = [R(w, d)];
    foreach (_; 0..n) {
        auto ps = readln.split.to!(int[]);
        auto p = ps[0]-1;
        auto s = ps[1];
        auto r = rs[p];
        foreach (i; p..rs.length-1) rs[i] = rs[i+1];
        rs = rs[0..$-1];

        while (s > r.w*2 + r.d*2) s -= r.w*2 + r.d*2;
        if (s < r.w) {
            auto w1 = s;
            auto w2 = r.w - s;
            if (w1 > w2) swap(w1, w2);
            rs ~= [R(w1, r.d), R(w2, r.d)];
        } else if (r.w < s && s < r.w + r.d) {
            s -= r.w;
            auto d1 = s;
            auto d2 = r.d - s;
            if (d1 > d2) swap(d1, d2);
            rs ~= [R(r.w, d1), R(r.w, d2)];
        } else if (r.w + r.d < s && s < r.w*2 + r.d) {
            s -= r.w + r.d;
            auto w1 = s;
            auto w2 = r.w - s;
            if (w1 > w2) swap(w1, w2);
            rs ~= [R(w1, r.d), R(w2, r.d)];
        } else {
            s -= r.w*2 + r.d;
            auto d1 = s;
            auto d2 = r.d - s;
            if (d1 > d2) swap(d1, d2);
            rs ~= [R(r.w, d1), R(r.w, d2)];
        }
    }
    auto nd = rs.map!(r => r.w * r.d).array;
    sort(nd);
    writeln(nd.to!(string[]).join(" "));
}

void main()
{
    for (;;) {
        auto nwd = readln.split.to!(int[]);
        if (nwd == [0, 0, 0]) return;
        solve(nwd[0], nwd[1], nwd[2]);
    }
}