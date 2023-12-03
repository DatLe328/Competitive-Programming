pair<long long, long long> f(long long n) {
        if (n == 0)
            return {0, 1};
        auto fk = f(n / 2);
        long long a = fk.first * (2 * fk.second - fk.first);
        long long b = fk.first * fk.first + fk.second * fk.second;
        if (n % 2 == 1)
            return {b, a + b};
        else
            return {a, b};
    }
int fib(int n) {    //1 1 2 3 5
      return f(n).first;
}
