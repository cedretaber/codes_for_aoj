import std.stdio, std.math, std.conv, std.string;

bool is_prime(int n)
{
    auto t = sqrt(n.to!double);

    for (int i = 2; i <= t; ++i) {
        if (n % i == 0) return false;
    }

    return true;
}

void main()
{
    auto N = readln.chomp.to!int;
    int cnt;
    foreach (_; 0..N) {
        if (is_prime(readln.chomp.to!int)) ++cnt;
    }
    writeln(cnt);
}