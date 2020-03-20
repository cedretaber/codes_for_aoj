import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

alias R = Tuple!(long, "x1", long, "y1", long, "x2", long, "y2");

void main()
{
    auto N = readln.chomp.to!int;
    R[] rs;
    long[] xs, ys;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(long[]);
        xs ~= xy[0];
        xs ~= xy[2];
        ys ~= xy[1];
        ys ~= xy[3];
        rs ~= R(xy[0], xy[1], xy[2], xy[3]);
    }
    sort(xs);
    xs = xs.uniq().array();
    sort(ys);
    ys = ys.uniq().array();
    long[long] xm, ym;
    foreach (i, x; xs) xm[x] = i.to!long;
    foreach (i, y; ys) ym[y] = i.to!long;
    foreach (ref r; rs) {
        r.x1 = xm[r.x1];
        r.y1 = ym[r.y1];
        r.x2 = xm[r.x2];
        r.y2 = ym[r.y2];
    }
    auto MAP = new int[][](ys.length, xs.length);
    foreach (r; rs) {
        MAP[r.y1][r.x1] += 1;
        MAP[r.y2][r.x2] += 1;
        MAP[r.y1][r.x2] -= 1;
        MAP[r.y2][r.x1] -= 1;
    }
    foreach (i; 0..ys.length) {
        foreach (j; 0..xs.length-1) {
            MAP[i][j+1] += MAP[i][j];
        }
    }
    foreach (j; 0..xs.length) {
        foreach (i; 0..ys.length-1) {
            MAP[i+1][j] += MAP[i][j];
        }
    }
    long r;
    foreach (i; 0..ys.length-1) {
        foreach (j; 0..xs.length-1) {
            if (MAP[i][j] > 0) {
                r += (ys[i+1] - ys[i]) * (xs[j+1] - xs[j]);
            }
        }
    }
    writeln(r);
}