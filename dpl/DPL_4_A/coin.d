import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nv = readln.split.to!(long[]);
    auto N = nv[0];
    auto V = nv[1];
    auto aa = readln.split.to!(long[]);
    auto bb = readln.split.to!(long[]);
    auto cc = readln.split.to!(long[]);
    auto dd = readln.split.to!(long[]);
    long[long] ab, cd;
    foreach (a; aa) foreach (b; bb) ab[a+b] += 1; 
    foreach (c; cc) foreach (d; dd) cd[c+d] += 1;
    long r;
    foreach (x, n; ab) if (V-x in cd) r += n * cd[V-x];
    writeln(r);
}