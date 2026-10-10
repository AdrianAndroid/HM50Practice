function doFunc(a: number, n: number): number {
  let term = 0;
  let res = 0;
  for (let i = 0; i < n; i++) {
    term = term * 10 + a;
    res += term;
  }
  return res;
}


