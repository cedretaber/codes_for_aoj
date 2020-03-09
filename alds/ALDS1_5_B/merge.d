import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int cnt;
    int[] ARR;

    void merge(int l, int m, int r) {
        auto n1 = m-l, n2 = r-m;
        int[] L, R;
        L.length = n1+1;
        R.length = n2+1;
        foreach (i; 0..n1) L[i] = ARR[l+i];
        L[n1] = int.max;
        foreach (i; 0..n2) R[i] = ARR[m+i];
        R[n2] = int.max;
        size_t i, j;
        foreach (k; l..r) {
            ++cnt;
            if (L[i] < R[j]) {
                ARR[k++] = L[i++];
            } else {
                ARR[k++] = R[j++];
            }
        }
    }

    void merge_sort(int l, int r) {
        if (l+1 == r) return;

        auto m = (l+r)/2;
        merge_sort(l, m);
        merge_sort(m, r);
        merge(l, m, r);
    }

    auto N = readln.chomp.to!int;
    ARR = readln.split.to!(int[]);
    merge_sort(0, N);

    writeln(ARR.to!(string[]).join(" "));
    writeln(cnt);
}