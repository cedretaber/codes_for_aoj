import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct BITree(alias _fun, alias E, T)
if (is(typeof(E) : T))
{
    import std.functional : binaryFun;
    alias OP = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = E;
        foreach (i, t; ts) this.update(i, t);
    }

    void update(size_t i, T e) {
        i += 1;
        while (i <= this.n) {
            this.tree[i] = OP(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = E;
        while (i > 0) {
            r = OP(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

auto bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
auto bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

auto sum_bitree(T)(size_t n, T[] ts = [])
{
    return bitree!("a + b", 0, T)(n, ts);
}

auto sum_bitree(T)(T[] ts)
{
    return sum_bitree!T(ts.length, ts);
}

void main()
{
    for (;;) {
        auto ql = readln.split.to!(int[]);
        auto Q = ql[0];
        auto L = ql[1];

        if (Q == 0 && L == 0) break;

        int[] xs;
        size_t[int] xi;
        auto bit = sum_bitree!int(Q);
        foreach (_; 0..Q) {
            auto q = readln.split.to!(int[]);
            if (q[0] == 0) {
                auto x = q[1];
                auto i = xs.length;
                xi[x] = i;
                xs ~= x;
                bit.update(i, 1);

                if (bit.query(Q) > L) {
                    if (bit.query(1) == 1) {
                        bit.update(0, -1);
                    } else {
                        size_t l = 1, r = Q;
                        while (l+1 < r) {
                            auto m = (l+r)/2;
                            if (bit.query(m) > 0) {
                                r = m;
                            } else {
                                l = m;
                            }
                        }
                        bit.update(l, -1);
                    }
                }
            }
            if (q[0] == 1) {
                auto i = q[1];
                if (bit.query(1) == i) {
                    bit.update(0, -1);
                } else if (bit.query(Q) >= i) {
                    size_t l = 1, r = Q;
                    while (l+1 < r) {
                        auto m = (l+r)/2;
                        if (bit.query(m) < i) {
                            l = m;
                        } else {
                            r = m;
                        }
                    }
                    bit.update(l, -1);
                }
            }
            if (q[0] == 2) {
                auto i = q[1];
                if (bit.query(Q) >= i) {
                    int x;
                    if (bit.query(1) == i) {
                        x = xs[0];
                    } else {
                        size_t l = 1, r = Q;
                        while (l+1 < r) {
                            auto m = (l+r)/2;
                            if (bit.query(m) < i) {
                                l = m;
                            } else {
                                r = m;
                            }
                        }
                        x = xs[l];
                    }
                    writeln(x);
                }
            }
            if (q[0] == 3) {
                bit.update(xi[q[1]], -1);
            }
        }
        writeln("end");
    }
}