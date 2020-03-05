import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
enum EPS = 1e-10;

///
double add(double a, double b) {
    if (abs(a + b) < EPS * (abs(a) + abs(b))) return 0;
    return a + b;
}

///
struct P {
    double x, y;

    this(double x, double y) {
        this.x = x;
        this.y = y;
    }

    P opBinary(string op)(P p) {
        static if (op == "+") return P(add(x, p.x), add(y, p.y));
        else static if (op == "-") return P(add(x, -p.x), add(y, -p.y));
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    P opBinary(string op)(double d) {
        static if (op == "*") return P(x * d, y * d);
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    // dot product
    double dot(P p) {
        return add(x * p.x, y * p.y);
    }

    // cross product
    double det(P p) {
        return add(x * p.y, -y * p.x);
    }

    double dist(P p) {
        return sqrt((x - p.x)^^2 + (y - p.y)^^2);
    }

    P middle(P p) {
        return P((x + p.x)/2, (y + p.y)/2);
    }
}

///
P[] convex_hull(P[] ps)
{
    auto n = ps.length;
    sort!"a.y == b.y ? a.x < b.x : a.y < b.y"(ps);
    size_t k;
    auto qs = new P[](n*2);

    foreach (i; 0..n) {
        while (k > 1 && (qs[k-1] - qs[k-2]).det(ps[i] - qs[k-1]) < 0) k--;
        qs[k++] = ps[i];
    }

    auto t = k;
    foreach_reverse (i; 0..n-1) {
        while (k > t && (qs[k-1] - qs[k-2]).det(ps[i] - qs[k-1]) < 0) k--;
        qs[k++] = ps[i];
    }

    qs.length = k;
    return qs;
}

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }
    auto qs = convex_hull(ps);
    writeln(qs.length-1);
    foreach (q; qs[0..$-1]) {
        writefln("%d %d", q.x.to!int, q.y.to!int);
    }
}