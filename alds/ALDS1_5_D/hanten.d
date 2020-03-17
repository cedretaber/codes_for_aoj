import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

/// [..), 1-origin
struct BITree(alias _fun, alias init, T)
if (is(typeof(init) : T))
{
    import std.functional : binaryFun;
    alias fun = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = init;
        foreach (i, t; ts) this.put(i+1, t);
    }

    /// This method does not replace the element but applies old one and new one to the `fun`.
    void put(size_t i, T e) {
        while (i <= this.n) {
            this.tree[i] = fun(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = init;
        while (i > 0) {
            r = fun(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

/// The `init` value is used for the `query` method as first value,
/// so you can not use this argument to initialise the tree.
/// In other words, this is identity element.
BITree!(fun, init, T) bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

void main()
{
    auto N = readln.chomp.to!int;
    int[] as, bs;
    foreach (a; readln.split.to!(int[])) {
        as ~= a;
        bs ~= a;
    }
    sort(bs);
    int[int] cs;
    foreach (i, b; bs) cs[b] = i.to!int+1;

    long r;
    auto bit = bitree!("a + b", 0, int)(N);
    foreach (i, a; as) {
        auto b = cs[a];
        r += i.to!int - bit.query(b);
        bit.put(b, 1);
    }
    writeln(r);
}