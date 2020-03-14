import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto n = N;
    int[] ps;
    foreach (i; 2..10^^6) {
        while (n%i == 0) {
            n /= i;
            ps ~= i;
        }
    }
    if (n != 1) ps ~= n;
    writefln("%d: %s", N, ps.to!(string[]).join(" "));
}