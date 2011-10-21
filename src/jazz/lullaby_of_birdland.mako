<%page args="part"/>
% if part=='Vars':
<%
	attributes['doChords']=True
	attributes['doVoice']=True
	attributes['doLyrics']=True
	attributes['render']="Fake"

	attributes['title']="Lullaby of birdland"
	attributes['composer']="George Shearing"
	attributes['poet']="George David Weiss"
	attributes['copyright']="1952, 1953, 1954 Adam R. Levy & Father Ent., Inc., New York NY. Copyrights Renewed."
	attributes['style']="Jazz"
	attributes['piece']="Relaxed Swing"

	attributes['structure']="AABA"

	attributes['completion']="5"
	attributes['uuid']="f9668406-a26e-11df-8542-0019d11e5a41"
%>
% endif

% if part=='Doc':
	DONE:
		- filled in meta data from the fake book.
		- added real book epdf.
		- added fake book epdf.
		- added fake book chords.
	TODO:
% endif

% if part=='ChordsFake':
\chordmode {
	\startChords
	\startSong

	\mark "A"
	\startPart
	f2:m6 d:m7.5- | g:7.9- c:7.9- | f:m7 des:maj7 | bes:m7 ees:7 | \myEndLine
	c:m7 f:m7 | bes:m7 ees:7.9- | aes:maj7 des:9 | g:m7.5- c:7 | \myEndLine
	\endPart

	\mark "A"
	\startPart
	f2:m6 d:m7.5- | g:7.9- c:7.9- | f:m7 des:maj7 | bes:m7 ees:9 | \myEndLine
	c:m7 f:m7 | bes:m7 ees:7.9- | aes:maj7 ees:7 | aes1 | \myEndLine
	\endPart

	\mark "B"
	\startPart
	c2:m7.5- f:7.9- | bes1:m7 | bes2:m7 ees:7.9- | aes1:maj7 | \myEndLine
	c2:m7.5- f:7.9- | bes1:m7 | ees:7.9- | aes2:maj7 c:7 | \myEndLine
	\endPart

	\mark "A"
	\startPart
	\repeat volta 2 {
		f2:m6 d:m7.5- | g:7.9- c:7.9- | f:m7 des:maj7 | bes:m7 ees:9 | \myEndLine
		c:m7 f:m7 | bes:m7 ees:7.9- |
	} \alternative {
		{ aes:maj7 des:9 | g:m7.5- c:7 | }
		{ aes1:maj7 | bes2:m7 ees:9 | aes1:maj7 | bes2:m7 a4:maj7 aes:maj7 | }
	} \myEndLine
	\endPart

	\endSong
	\endChords
}
% endif

% if part=='VoiceFake':
\relative c'' {
	%% http://veltzer.net/blog/blog/2010/08/14/musical-tempo-table/
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key f \minor

	%% A part
	c8 c bes aes g f4. | d4 f8 e~ e2 | c4 g'8 f~ f2 | des4 c'8 bes~ bes2 |
	ees8 ees des c bes aes4. | f8 c' bes e,~ e c' bes ees,~ | ees2~ ees8 bes' aes des,~ | des aes' g c,~ c2 |

	%% A part
	c8 c bes aes g f4. | d4 f8 e~ e2 | c4 g'8 f~ f2 | des4 c'8 bes~ bes2 |
	ees8 ees des c bes aes4. | f8 c' bes e,~ e c' bes ees,~ | ees2~ ees8 ees g aes~ | aes1 |

	%% B part

}
% endif

% if part=='LyricsFake':
\lyricmode {
	Lul -- la -- by Of Bird -- land
	that's what I __
	al -- ways hear __
	when you sigh. __
	Nev -- er in my word -- land could there be ways __ to re -- veal __ __ in a phrase __ how I feel! __

	Have you ev -- er heard two tur -- tle doves __
	bill and coo __
	when they love? __
	That's the kind of mag -- ic music we make __ with our lips __ __ when we kiss! __

	And tere's a weep -- y old wil -- low; __
	he real -- ly knows how to cry! __
	That's how I'd cry in my pil -- low __
	if you should tell me fare -- well __ and good -- bye! __

	Lul -- la -- by Of Bird -- land whis -- per low, __
	kiss me sweet __
	and we'll go __
	fly -- in' high in Bird -- land, high in the sky __ up a -- bove __ __ all be -- cause __ we're in love! __

	all be -- cause __ we're in love. __ __
}
% endif
