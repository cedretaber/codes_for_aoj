import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nklr = readln.split.to!(long[]);
    auto N = nklr[0];
    auto K = nklr[1];
    auto L = nklr[2];
    auto R = nklr[3];
    auto as = readln.split.to!(long[]);

    if (N == 1) {
        writeln(L <= as[0] && as[0] <= R ? 1 : 0);
        return;
    }

    long[][] bs, cs;
    bs.length = 21;
    cs.length = 21;
    void make(size_t i, size_t j, long c, long s, long[][] xs) {
        if (i == j) return;
        make(i+1, j, c, s, xs);
        xs[c+1] ~= s + as[i];
        make(i+1, j, c+1, s + as[i], xs);
    }
    make(0, as.length/2, 0, 0, bs);
    foreach (ref b; bs) sort(b);
    make(as.length/2, as.length, 0, 0, cs);
    foreach (ref c; cs) sort(c);

    long res;
    foreach (i, bb; bs) {
        if (K-i.to!int < 0 || K-i.to!int > 20) continue;
        auto cc = cs[K-i.to!int];
        if (cc.empty) continue;
        foreach (b; bb) {
            if (cc[0] + b > R) continue;
            if (cc[$-1] + b < L) continue;
            int s, t;
            if (cc[0] + b >= L) {
                s = 0;
            } else {
                int l, r = cc.length.to!int;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (cc[m] + b >= L) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                s = r;
            }
            int l, r = cc.length.to!int;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (cc[m] + b > R) {
                    r = m;
                } else {
                    l = m;
                }
            }
            t = r;
            res += t-s;
        }
    }
    if (bs.length > K) foreach (b; bs[K]) if (L <= b && b <= R) ++res;
    if (cs.length > K) foreach (c; cs[K]) if (L <= c && c <= R) ++res;
    writeln(res);
}