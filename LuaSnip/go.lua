local struct = s(
  { trig = "ss" },
  fmta(
    [[
        type <> struct {<>
        }
      ]],
    {
      i(1),
      i(0),
    }
  )
)

local func = s(
  { trig = "ff" },
  fmta([[
    func <>(<>) <> {
      var out <>
      <>

      return out
    }
  ]], {
    i(1),
    i(2),
    i(3),
    rep(3),
    i(4),
  })
)

local method = s(
  { trig = "mm" },
  fmta([[
    func (this *<>) <>(<>) <> {
      var out <>
      <>

      return out
    }
  ]], {
    i(1),
    i(2),
    i(3),
    i(4),
    rep(4),
    i(5),
  })
)

local interface = s(
  { trig = "ii" },
  fmta(
    [[
      type <> interface {
        <>
      }
      ]],
    {
      i(1),
      i(2),
    }
  )
)

return {
  struct,
  func,
  interface,
  method,
}
