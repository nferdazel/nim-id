type
  Event = object
    id: int
    case kind: bool
      of true:
        message: string
      of false:
        code: int

let ok = Event(id: 1, kind: true, message: "ok")
let fail = Event(id: 2, kind: false, code: 500)
echo ok.id, " ", ok.message
echo fail.id, " ", fail.code
