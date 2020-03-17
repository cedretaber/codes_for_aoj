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
        else static if (op == "/") return P(x / d, y / d);
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

    P rotate(double th) {
        return P(add(x * cos(th), -y * sin(th)), add(x * sin(th), y * cos(th)));
    }

    P rotate(P p, double th) {
        auto q = P(x - p.x, y - p.y).rotate(th);
        return P(q.x + p.x, q.y + p.y);
    }
}

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = [P(0, 0), P(100, 0)];
    foreach (_; 0..N) {
        P[] nps;
        foreach (i; 0..ps.length-1) {
            auto x = ps[i];
            auto y = ps[i+1];
            nps ~= x;
            nps ~= P((x.x*2+y.x)/3, (x.y*2+y.y)/3);
            auto d = x.dist(y);
            auto th = atan2(y.y-x.y, y.x-x.x);
            nps ~= P(x.x+d/2, x.y+d/6.0*sqrt(3.0)).rotate(x, th);
            nps ~= P((x.x+y.x*2)/3, (x.y+y.y*2)/3);
        }
        ps = nps ~ ps[$-1];
    }
    foreach (p; ps) writefln("%.10f %.10f", p.x, p.y);
}