BEGIN {
  str = "abc"; gsub("b+", "FOO", str); print str
  str = "abc"; gsub("x*", "X", str); print str
  str = "abc"; gsub("b*", "X", str); print str
  str = "abc"; gsub("c", "X", str); print str
  str = "abc"; gsub("c+", "X", str); print str
  str = "abc"; gsub("x*$", "X", str); print str
  str = " x "; gsub(/^ | $/,"", str); print str

  gsub(str, "zzz", str); print str
}
