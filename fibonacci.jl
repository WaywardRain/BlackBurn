using Base.Test
include("perfutil.jl")
rfib(n) = n < 2 ? n : rfib(n-1) + rfib(n-2)
@test   rfib(30) == 832040
@timeit rfib(30) "rfib30" "Recursive fibonacci"
helper(current, next, n) = n==0 ? current : helper(next, next+current, n-1)
tfib(n) = helper(BigInt(0), BigInt(1), n)
@test   tfib(30) == 832040
@timeit tfib(30)   "tfib30" "Tail-recursive fibonacci"
@timeit tfib(1000) "tfib1k" "Tail-recursive fibonacci"
function mfib(n)
   F = BigInt[1 1; 1 0]
   Fn = F ^ n
   Fn[2, 1]
end
@test   mfib(30) == 832040
@timeit mfib(30)       "mfib30" "Matrix fibonacci"
@timeit mfib(1000)     "mfib1k" "Matrix fibonacci"
@timeit mfib(1000_000) "mfib1M" "Matrix fibonacci"
@timeit mfib(1048_576) "mfibP2" "Matrix fibonacci"   # 2^20
