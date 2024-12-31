#SingleInstance Force

RunWait("pwsh -NoProfile -Command if ((Get-Process -Name 'komorebi' -ErrorAction SilentlyContinue) -eq $null) { } else { komorebic stop }", , "Hide")
RunWait("pwsh -Command komorebic start", , "Hide")
Komorebic(cmd) {
  RunWait(format("komorebic.exe {}", cmd), , "Hide")
}
#^!c::Komorebic("close")
#^!z::Komorebic("minimize")
#^!q::Komorebic("toggle-float")
#^!w::Komorebic("toggle-monocle")
#^!1::Komorebic("focus left")
#^!2::Komorebic("focus down")
#^!3::Komorebic("focus up")
#^!4::Komorebic("focus right")
#^!+1::Komorebic("move left")
#^!+2::Komorebic("move down")
#^!+3::Komorebic("move up")
#^!+4::Komorebic("move right")
#^!5::Komorebic("focus-workspace 0")
#^!6::Komorebic("focus-workspace 1")
#^!7::Komorebic("focus-workspace 2")
#^!8::Komorebic("focus-workspace 3")
#^!9::Komorebic("focus-workspace 4")
#^!0::Komorebic("focus-workspace 5")
#^!+5::Komorebic("move-to-workspace 0")
#^!+6::Komorebic("move-to-workspace 1")
#^!+7::Komorebic("move-to-workspace 2")
#^!+8::Komorebic("move-to-workspace 3")
#^!+9::Komorebic("move-to-workspace 4")
#^!+0::Komorebic("move-to-workspace 5")

RunWait("pwsh -NoProfile -Command if ((Get-Process -Name 'yasb' -ErrorAction SilentlyContinue) -eq $null) { } else { yasbc stop }", , "Hide")
RunWait("pwsh -NoProfile -Command yasbc start", , "Hide")
OpenYasbMenu() {
  ButtonOffsetX := 20
  ButtonOffsetY := 20
  MonitorPrimary := MonitorGetPrimary()
  MonitorGet MonitorPrimary, &L, &T, &R, &B
  DllCall("SetCursorPos", "int", (L + ButtonOffsetX), "int", (T + ButtonOffsetY))
  MouseClick "Left"
  DllCall("SetCursorPos", "int", R / 2, "int", B / 2)
}
#^!a::OpenYasbMenu()

RunWait("pwsh -NoProfile -Command sudo trc --disable", , "Hide")
