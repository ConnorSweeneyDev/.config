#SingleInstance Force

RunWait("pwsh -NoProfile -Command if ((Get-Process -Name 'komorebi' -ErrorAction SilentlyContinue) -eq $null) { } else { komorebic stop }", , "Hide")
RunWait("pwsh -NoProfile -Command if ((Get-Process -Name 'yasb' -ErrorAction SilentlyContinue) -eq $null) { } else { Stop-Process -Name 'yasb' -Force }", , "Hide")
RunWait("pwsh -Command komorebic start", , "Hide")
RunWait("pwsh -Command yasb", , "Hide")
RunWait("pwsh -Command sudo trc --disable", , "Hide")

Komorebic(cmd) {
  RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

;Assumes 2560x1440 resolution, and that the Yasb power menu button is in the top left
YasbMenu() {
  MouseMove -10000, -10000, 0, "R"
  MouseMove 20, 20, 0, "R"
  MouseClick "Left"
  MouseMove 1260, 700, 0, "R"
}
#a::YasbMenu()

#c::Komorebic("close")
#z::Komorebic("minimize")
#q::Komorebic("toggle-float")
#w::Komorebic("toggle-monocle")

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

#e::Run("explorer")
#t::Run("pwsh -Command wezterm", , "Hide")
#f::Run("pwsh -Command firefox", , "Hide")
#d::Run("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Discord.lnk")
#s::Run("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Steam.lnk")
