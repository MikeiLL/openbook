include(src/include/common.lyi)
\header{
	default_header
	title="Desafinado"
	subtitle="Slightly Out Of Tune"
	composer="Antonio Carlos Jobim"
	copyright="1959 1962, Editora Musical Arapua, Sao Paulo, Brazil"
	style="Jazz"
	piece="Medium Bossa Nova"
	poet="Newton Menonca, Jon Hendricks & Jessie Cavanaugh"

	completion="5"

	dontimport="1"

	uuid="9a39404e-a26f-11df-aa6e-0019d11e5a41"
}

<%doc>
	TODO:
</%doc>

\score {
<<
\chordmode {
	%% see the difference between the next two chords ?!?
	f1:maj7.9 | f1:maj9
}
\drums {
	\time 4/4
		sn16 sn8 sn16 sn8 sn8:32 ~
		sn8 sn8 sn4:32 ~
		sn4 sn8 sn16 sn16
		sn4 r4
}
\new RhythmicStaff {
	\new Voice = "myRhythm" {
	\time 4/4
		c4 e8 f g2
		r4 g g f
		g1
	}
}
\new Voice \with {
	\consists "Pitch_squash_engraver"
} {
	\relative c'' {
		\improvisationOn
		c4 c8 c c4 c8 c
		f4 f8 f f4 f8 f
		g4 g8 g g4 g8 g
		c4 c8 c c4 c8 c
	}
%% this is how to repeat something without showing it in the score...
	\repeat unfold 2 {
		c4 d4
	}
}
>>
	\midi {
		\context {
			\Score
			tempoWholesPerMinute = #(ly:make-moment 130 4)
		}
	}
	\layout {}
}