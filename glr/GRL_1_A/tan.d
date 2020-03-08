import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
struct PriorityQueue(alias _fun, T) {
    import std.functional : binaryFun;
    import std.algorithm : swap;
    alias fun = binaryFun!_fun;

    ///
    this(T[] ts) {
        foreach (t; ts) enqueue(t);
    }

    ///
    PriorityQueue!(_fun, T) enqueue(T e) {
        if (this.tree.length == 0) this.tree.length = 1;
        if (this.tree.length == this.n) this.tree.length *= 2;
        this.tree[this.n] = e;
        auto i = this.n;
        this.n += 1;
        while (i) {
            auto j = (i-1)/2;
            if (fun(this.tree[i], this.tree[j])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return this;
    }

    alias insertFront = enqueue;
    alias insert = enqueue;

    ///
    T dequeue() {
        auto ret = this.tree[0];
        this.n -= 1;
        this.tree[0] = this.tree[this.n];
        this.tree = this.tree[0..$-1];
        size_t i;
        for (;;) {
            auto l = i*2+1;
            auto r = i*2+2;
            if (l >= this.n) break;
            size_t j;
            if (r >= this.n) {
                j = l;
            } else {
                j = fun(this.tree[r], this.tree[l]) ? r : l;
            }
            if (fun(this.tree[j], this.tree[i])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return ret;
    }

    ///
    @property
    T front() {
        return this.tree[0];
    }

    ///
    @property
    bool empty() {
        return this.n == 0;
    }

    ///
    void popFront() {
        this.dequeue();
    }

    alias removeFront = popFront;

    ///
    @property
    size_t length() {
        return this.n;
    }

private:
    size_t n;
    T[] tree;
}

///
PriorityQueue!(fun, T) priority_queue(alias fun, T)(T[] ts = []) {
    return PriorityQueue!(fun, T)(ts);
}

alias Path = Tuple!(int, "to", long, "d");

void main()
{
    auto ver = readln.split.to!(int[]);
    auto V = ver[0];
    auto E = ver[1];
    auto r = ver[2];

    Path[][] G;
    G.length = V;
    foreach (_; 0..E) {
        auto std = readln.split.to!(int[]);
        auto s = std[0];
        auto t = std[1];
        long d = std[2];
        G[s] ~= Path(t, d);
    }

    auto LS = new long[](V);
    LS[] = long.max/3;
    LS[r] = 0;

    auto pq = priority_queue!("a.d < b.d", Path)();
    pq.enqueue(Path(r, 0));
    while (!pq.empty) {
        auto h = pq.dequeue();
        foreach (p; G[h.to]) if (LS[p.to] > h.d + p.d) {
            LS[p.to] = h.d + p.d;
            pq.enqueue(Path(p.to, LS[p.to]));
        }
    }

    foreach (l; LS) if (l <= 10^^9) writeln(l); else writeln("INF");
}