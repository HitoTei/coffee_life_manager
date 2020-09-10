bool isAsc = true;

int sortCompare(int a, int b) {
  if (isAsc)
    return b - a;
  else
    return a - b;
}
