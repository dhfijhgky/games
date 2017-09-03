; GW2 Harp Script v2.0
; Unfortunately, v1.0 broke beyond repair (as far as I can tell).
; The idea behind this script is to stagger the inputs so they are all read by GW2.
; We do this by putting every single input into an array.
; We constantly check this array and if we find any input, we play the corresponding notes with a sufficient amount of delay (if required at all).

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Initialize the array we'll hold queued inputs in as queue.
; Then loop our play label as quickly as possible.
queue := []
SetTimer, play, 1
return

; Every unique value between 0 and 23 pushed to queue[] corresponds to a different note.
; (The notes at value 7 and 8 are the same and the ones at 15 and 16 are the same. There's 22 total notes, not 24. That's not on me!)
q::queue.Push(0)
w::queue.Push(1)
e::queue.Push(2)
r::queue.Push(3)
t::queue.Push(4)
y::queue.Push(5)
u::queue.Push(6)
i::queue.Push(7)

a::queue.Push(8)
s::queue.Push(9)
d::queue.Push(10)
f::queue.Push(11)
g::queue.Push(12)
h::queue.Push(13)
j::queue.Push(14)
k::queue.Push(15)

z::queue.Push(16)
x::queue.Push(17)
c::queue.Push(18)
v::queue.Push(19)
b::queue.Push(20)
n::queue.Push(21)
m::queue.Push(22)
,::queue.Push(23)

; This lets us loop play() with SetTimer.
play:
	play()
Return

; Checks for all notes flagged to be played.
; Then, plays them staggered so the GW2 client actually catches all the input.
; This is a problem when playing different octaves simultaneously, especially when the same note is being hit.
play() {
	global queue
	len := queue.Length()
	
	if (len > 0) {
		; The smaller this delay is, the more responsive the controls are.
		; If it gets too small however, the staggering effect doesn't work.
		; 50 seems to be a good balance point.
		delay := 50
	
		; Sorting the queued inputs into octaves to minimize button pushes.
		low := []
		mid := []
		high := []
		Loop, %len% {
			val := queue.Remove(1)
			if (val < 8) {
				low.Push(val)
			} else if (val < 16) {
				mid.Push(val)
			} else {
				high.Push(val)
			}
		}
		if (mid.Length() > 0) {
			for k in mid
				note(mid[k])
			Sleep delay
		}
		if (low.Length() > 0) {
			Send {F9}
			for k in low
				note(low[k])
			Send {F10}
			Sleep delay
		}
		if (high.Length() > 0) {
			Send {F10}
			for k in high
				note(high[k])
			Send {F9}
			Sleep delay
		}
	}
}

; This function takes some input that represents a note and maps it to the proper key.
; In this case, F1-8 are bound to the 1-8 skills on the skillbar, respectively.
note(x) {
	y := Mod(x, 8)
	if (y == 0)
		Send {F1}
	else if (y == 1)
		Send {F2}
	else if (y == 2)
		Send {F3}
	else if (y == 3)
		Send {F4}
	else if (y == 4)
		Send {F5}
	else if (y == 5)
		Send {F6}
	else if (y == 6)
		Send {F7}
	else if (y == 7)
		Send {F8}
}

^/::ExitApp