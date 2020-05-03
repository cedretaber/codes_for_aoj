import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

struct LazySegTree(alias opt, alias opu, alias _add, alias mul, alias E, alias F, T, U)
if (is(typeof(E) : T))
{
    import std.functional : binaryFun;
    alias OPT = binaryFun!opt;
    alias OPU = binaryFun!opu;
    alias ADD = binaryFun!_add;
    alias MUL = binaryFun!mul;

    ///
    this(size_t n, T[] ts) {
        this.n = 1;
        while (this.n < n) this.n *= 2;
        this.tree.length = this.n * 2 - 1;
        foreach (ref e; this.tree) e = E;
        foreach (i, e; ts) this.replace(i, e);
        this.ltree.length = this.n * 2 - 1;
        foreach (ref f; this.ltree) f = F;
    }

    ///
    void replace(size_t i, T e) {
        i += this.n - 1;
        this.tree[i] = e;
        while (i > 0) {
            i = (i-1) / 2;
            this.tree[i] = OPT(this.tree[i*2+1], this.tree[i*2+2]);
        }
    }

    ///
    void update(size_t i, T e) {
        replace(i, OPT(e, tree[i + this.n - 1]));
    }

    void update(size_t a, size_t b, U e) {
        void impl(size_t i, size_t l, size_t r) {
            eval(i, l, r);
            if (r <= a || b <= l) return;
            if (a <= l && r <= b) {
                import std.conv;
                ltree[i] = OPU(ltree[i], e);
                eval(i, l, r);
                return;
            }
            impl(i*2+1, l, (l+r)/2);
            impl(i*2+2, (l+r)/2, r);
            tree[i] = OPT(tree[i*2+1], tree[i*2+2]);
        }
        impl(0, 0, this.n);
    }

    ///
    T query(size_t a, size_t b) {
        T impl(size_t i, size_t l, size_t r) {
            eval(i, l, r);
            if (r <= a || b <= l) return E;
            if (a <= l && r <= b) return this.tree[i];
            return OPT(
                impl(i*2+1, l, (l+r)/2),
                impl(i*2+2, (l+r)/2, r)
            );
        }
        return impl(0, 0, this.n);
    }

private:
    size_t n;
    T[] tree;
    U[] ltree;

    void eval(size_t i, size_t l, size_t r) {
        if (ltree[i] == F) return;

        import std.conv;
        tree[i] = ADD(tree[i], MUL(ltree[i], (r-l).to!U));
        if (i < this.n - 1) {
            ltree[2*i+1] = OPU(ltree[2*i+1], ltree[i]);
            ltree[2*i+2] = OPU(ltree[2*i+2], ltree[i]);
        }
        ltree[i] = F;
    }
}

///
auto lazy_seg_tree(alias opt, alias opu, alias add, alias mul, alias E, alias F, T, U)(size_t n, T[] arr = [])
{
    return LazySegTree!(opt, opu, add, mul, E, F, T, T)(n, arr);
}

///
auto lazy_seg_tree(alias opt, alias opu, alias add, alias mul, alias E, alias F, T, U)(T[] arr)
{
    return LazySegTree!(opt, opu, add, mul, E, F, T, T)(arr.length, arr);
}

///
auto lazy_sum_seg_tree(T)(size_t n, T[] arr = [])
{
    return lazy_seg_tree!("a + b", "a + b", "a + b", "a * b", 0, 0, T, T)(n, arr);
}

///
auto lazy_sum_seg_tree(T)(T[] arr)
{
    return lazy_sum_seg_tree!T(arr.length, arr);
}

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto segt = lazy_sum_seg_tree!long(N);
    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        if (q[0] == 0) {
            segt.update(q[1]-1, q[2], q[3]);
        } else {
            writeln(segt.query(q[1]-1, q[2]));
        }
    }
}