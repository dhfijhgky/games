; GW2 Harp Script v1.0
; Because the skill system in GW2 only allows you to have 10 skills at a time, octaves are swapped using the last two "skills".
; The remaining 8 are notes on the octave (from C to C).
; Hitting keys in different octaves at the same time is therefore very difficult.
; This script just mapped each possible note to a unique key.
; It worked for a while, then something changed on ArenaNet's side that caused it to skip inputs.
; Circa 2013-2014

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

;Middle octave keys.
;No octave switching required.
a::Send {F1}
s::Send {F2}
d::Send {F3}
f::Send {F4}
g::Send {F5}
h::Send {F6}
j::Send {F7}
k::Send {F8}

;Low octave keys.
;Swap to low octave, play note, swap back to middle octave.
q::Send {F9}{F1}{F10}
w::Send {F9}{F2}{F10}
e::Send {F9}{F3}{F10}
r::Send {F9}{F4}{F10}
t::Send {F9}{F5}{F10}
y::Send {F9}{F6}{F10}
u::Send {F9}{F7}{F10}
i::Send {F9}{F8}{F10}

;High octave keys.
;Same as low octave except to high back to middle.
z::Send {F10}{F1}{F9}
x::Send {F10}{F2}{F9}
c::Send {F10}{F3}{F9}
v::Send {F10}{F4}{F9}
b::Send {F10}{F5}{F9}
n::Send {F10}{F6}{F9}
m::Send {F10}{F7}{F9}
,::Send {F10}{F8}{F9}

^/::ExitApp