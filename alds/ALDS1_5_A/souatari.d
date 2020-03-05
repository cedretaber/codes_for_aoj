import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    auto ss = new bool[](2000*n+1);
    
    void solve(int i, int s) {
        if (i == n) return;
        solve(i+1, s);
        s += as[i];
        ss[s] = true;
        solve(i+1, s);
    }
    solve(0, 0);

    auto m = readln.chomp.to!int;
    foreach (q; readln.split.to!(int[])) {
        writeln(ss[q] ? "yes" : "no");
    }
}