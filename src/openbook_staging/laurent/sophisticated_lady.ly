% Mudela file generated by Denemo version 0.5.9
%http://www.gnu.org/software/denemo/denemo.html

\header{
    title = "Sophisticated Lady"
    subtitle = ""
    composer = "Ellington, Parish \& Mills"
    enteredby = "Silvia Bertoluzza"
    tagline = #tagline
    head = #instrument
}


Staff = \notes \context Voice = $Staff {
    \property Staff.midiInstrument = "acoustic grand"
    \time 4/4
    \key aes \major
    \clef treble
    \partial 4 g'4 |
    \repeat volta 2	{
	f'2 ~ f'8 aes' c'' ees'' |
	ges''4 f'' e'' ees''8 c'' |
	g'2 ~ g'8 f' aes' c'' |
	ees''4 d'' des'' c''8 f'' |
				%5
	f'2 ~ f'8 g' aes' c'' |
	\times 2/3 { ees'' c'' ees'' } c''2 ees''4 |}
    \alternative	{
	{ g'2. ees''4 | ges'1 |}
	{ g'8 f' aes'2. | r1 \bar "||"}
    }
    r8 d'4 b8 ees'4 b8 g' ~ |
    g' e' b'4 fis'8 e''4 ais'8 |
    b'4 f'2. |
    e'8 c'' ees'2. |
				%15
    r8 d'4 b8 ees'4 b8 g' ~ |
    g' e' b'4 fis'8 e''4 ais'8 |
    b'4 f'8 aes' g' ees' c'4 |
    f'8 g' bes' des'' c'' ees'' ges'4 |
    f'2 ~ f'8 aes' c'' ees'' |
				%20
    ges''4 f'' e'' ees''8 c'' |
    g'2 ~ g'8 f' aes' c'' |
    ees''4 d'' des'' c''8 f'' |
    f'2 ~ f'8 g' aes' c'' |
    \times 2/3 { ees'' c'' ees'' } c''2 ees''4 |
				%25
    aes'1 \bar "|."
}

accompaniment = \chords {
    b4:min7
    bes1:min7
    ges4:7 f:7 e:7 ees:7
    aes1:maj 
    aes4:7 g:7 ges:7 f:7 bes1:7
    bes2:min7 ees:7 aes1:maj
    aes2.:7 ces4:min7
    aes1:maj
    a2:min7.5- d:7.9-
    g:maj e:min7 a:min7 d:7 g:7 gis:7-.3-.5-
    a:min7 d:7
    g:maj e:min7
    a:min7 d:7 g:7 c:min7 ees:7 d4:7 ces:min7
    bes1:min7
    ges4:7 f:7 e:7 ees:7 aes1:maj
    aes4:7 g:7 ges:7 f:7 bes1:7
    bes2:min7 ees:7 aes:maj 
}


StaffStaff = \context Staff = StaffStaff <
    \property Staff.automaticMelismata = ##t
    \Staff
>


texta = \lyrics{
    They say in -- to your ear -- ly life ro -- mance came, and in this heart 
    of yours burned a flame, a flame that flick -- ered one day and died a -- way.
    see you now....
    Smok -- ing, drink -- ing, nev -- er think -- ing of to -- mor -- row,
    non -- chal -- ant, 
    Dia -- monds shin -- ing, danc -- ing, din -- ing with some man in a res -- tau -- rant
    Is this all you rea -- lly want? No, 
    soph -- is -- ti -- ca -- ted la -- dy, I know
    you miss the love you lost long a -- go, and 
    when no -- bo -- dy is nigh you cry.
}
textb = \lyrics{
    _ Then with dis -- il -- lu -- sion deep in your eyes you learned that fools in love soon grow wise. 
    The years have changed you some -- how I 
}

Score = \notes <
    \context ChordNames \accompaniment
				%\property ChordNames.ChordName \set #'extra-offset = #70.
    \property ChordNames.SeparatingGroupSpanner \set #'kern = #70
    \addlyrics
    \StaffStaff
    \context Lyrics < \texta \textb >
>
