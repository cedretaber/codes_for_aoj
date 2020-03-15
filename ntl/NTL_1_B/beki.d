import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}


void main()
{
    auto nm = readln.split.to!(long[]);
    writeln(pow(nm[0], nm[1]));
}