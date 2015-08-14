include /usr/share/templar/make/Makefile
##############
# PARAMETERS #
##############
# should we show commands executed ?
DO_MKDBG:=0
# should we depend on the wrappers scripts dates ?
DO_WRAPDEPS:=1
# should we depend on the common include file ?
DO_INCDEPS:=1
# should we make the ly files and use them?
DO_LY:=0
# should we make pdfs ?
DO_PDF:=0
# should we make postscript ?
DO_PS:=0
# should we make midi ?
DO_MIDI:=0
# should we make stamp files ?
DO_STAMP:=0
# should we make .wav files ? (don't really want this):
DO_WAV:=0
# should we make mp3 ?
DO_MP3:=0
# should we make ogg ?
DO_OGG:=0
# should we do the full books ?
DO_BOOKS_PDF:=1
# should we reduce the size of the pdf books?
DO_PDFRED_BOOKS:=1
# should we reduce the size of the pdf individual songs?
DO_PDFRED_PIECES:=1
# should we stop on lilypond output?
DO_STOP_OUTPUT:=1
# do you want to validate html?
DO_CHECKHTML:=1
# which books should we do?
NAMES:=openbook israeli drumming rockbook

#############
# CONSTANTS #
#############
# where are the sources located ?
SOURCE_DIR:=src
# where is the output folder ?
OUT_DIR:=out
# what is the web folder ?
WEB_DIR:=../openbook-gh-pages
# which folders to copy for web?
COPY_FOLDERS:=web static
# where is the common file?
COMMON:=src/include/common.makoi
# wrappers
LILYPOND_WRAPPER:=scripts/wrapper_lilypond.py
MAKO_WRAPPER:=scripts/wrapper_mako.py
MAKO_DEPS_WRAPPER:=scripts/mako_deps.py
MIDI2WAV_WRAPPER:=scripts/midi2wav.pl
MIDI2OGG_WRAPPER:=scripts/midi2ogg.pl
MIDI2MP3_WRAPPER:=scripts/midi2mp3.pl
# parameters to pass to the mako wrapper
CONST_BOOK:=1
CONST_SONG:=0
CONST_DONTCUT:=0
CONST_CUT:=1
# arguments to git grep
GITARGS:=--no-pager

########
# code #
########

ifeq ($(DO_WRAPDEPS),1)
	LILYPOND_WRAPPER_DEP:=$(LILYPOND_WRAPPER)
	MAKO_WRAPPER_DEP:=$(MAKO_WRAPPER)
	MAKO_DEPS_WRAPPER_DEP:=$(MAKO_DEPS_WRAPPER)
	MIDI2WAV_WRAPPER_DEP:=$(MIDI2WAV_WRAPPER)
	MIDI2OGG_WRAPPER_DEP:=$(MIDI2OGG_WRAPPER)
	MIDI2MP3_WRAPPER_DEP:=$(MIDI2MP3_WRAPPER)
else
	LILYPOND_WRAPPER_DEP:=
	BOOK_WRAPPER_DEP:=
	MAKO_WRAPPER_DEP:=
	MAKO_DEPS_WRAPPER_DEP:=
	MIDI2WAV_WRAPPER_DEP:=
	MIDI2OGG_WRAPPER_DEP:=
	MIDI2MP3_WRAPPER_DEP:=
endif
ifeq ($(DO_INCDEPS),1)
	MAKO_WRAPPER_DEP:=$(MAKO_WRAPPER_DEP) src/include/common.makoi
endif

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

# this finds the sources via git
SOURCES_ALL:=$(shell git ls-files)
# this find the sources without git...
SOURCES_ALL:=$(subst ./,,$(shell find src -type f -and -name "*.mako" -or -name "*.makoi"))
FILES_MAKO:=$(filter %.mako,$(SOURCES_ALL))
FILES_MAKOI:=$(filter %.makoi,$(SOURCES_ALL))

FILES_JAZZ:=$(shell git ls-files src/openbook)

FILES_MAKO_DEPS:=$(addsuffix .mako.d,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_LY:=$(addsuffix .ly,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_PDF:=$(addsuffix .pdf,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_PS:=$(addsuffix .ps,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_MIDI:=$(addsuffix .midi,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_STAMP:=$(addsuffix .stamp,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_WAV:=$(addsuffix .wav,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_MP3:=$(addsuffix .mp3,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))
FILES_OGG:=$(addsuffix .ogg,$(addprefix $(OUT_DIR)/,$(basename $(FILES_MAKO))))

ALL_OUT_FILES:=$(shell find src -type f -and -name "*.mako")
ALL_OUT_STAMP:=$(addsuffix .stamp,$(addprefix $(OUT_DIR)/,$(basename $(ALL_OUT_FILES))))

BOOKS:=$(addsuffix .pdf,$(addprefix $(OUT_DIR)/,$(NAMES)))
LYS:=$(addsuffix .ly,$(addprefix $(OUT_DIR)/,$(NAMES)))

ifeq ($(DO_LY),1)
	ALL+=$(FILES_LY)
endif
ifeq ($(DO_PS),1)
	ALL+=$(FILES_PS)
endif
ifeq ($(DO_PDF),1)
	ALL+=$(FILES_PDF)
endif
ifeq ($(DO_MIDI),1)
	ALL+=$(FILES_MIDI)
endif
ifeq ($(DO_STAMP),1)
	ALL+=$(FILES_STAMP)
endif
ifeq ($(DO_WAV),1)
	ALL+=$(FILES_WAV)
endif
ifeq ($(DO_MP3),1)
	ALL+=$(FILES_MP3)
endif
ifeq ($(DO_OGG),1)
	ALL+=$(FILES_OGG)
endif
ifeq ($(DO_BOOKS_PDF),1)
	ALL+=$(BOOKS)
endif
all: $(ALL)

SOURCES_HTML:=web/index.html
HTMLCHECK:=html.stamp
ifeq ($(DO_CHECKHTML),1)
ALL+=$(HTMLCHECK)
all: $(ALL)
endif # DO_CHECKHTML

#########
# rules #
#########
.PHONY: stamp
stamp: $(FILES_STAMP)
	$(info doing [$@])

.PHONY: ly
ly: $(FILES_LY)
	$(info doing [$@])

.PHONY: debug_me
debug_me:
	$(info doing [$@])
	$(info ALL is $(ALL))
	$(info COPY_FOLDERS is $(COPY_FOLDERS))
	$(info SOURCES_ALL is $(SOURCES_ALL))
	$(info SOURCES_HTML is $(SOURCES_HTML))
	$(info FILES_MAKO is $(FILES_MAKO))
	$(info FILES_MAKO_DEPS is $(FILES_MAKO_DEPS))
	$(info FILES_LY is $(FILES_LY))
	$(info FILES_LYI is $(FILES_LYI))
	$(info FILES_PDF is $(FILES_PDF))
	$(info FILES_PS is $(FILES_PS))
	$(info FILES_MIDI is $(FILES_MIDI))
	$(info FILES_STAMP is $(FILES_STAMP))
	$(info FILES_WAV is $(FILES_WAV))
	$(info FILES_MP3 is $(FILES_MP3))
	$(info FILES_OGG is $(FILES_OGG))
	$(info FILES_JAZZ is $(FILES_JAZZ))
	$(info WEB_FOLDER is $(WEB_FOLDER))
	$(info DO_PDFRED_BOOKS is $(DO_PDFRED_BOOKS))
	$(info DO_PDFRED_PIECES is $(DO_PDFRED_PIECES))
	$(info NAMES is $(NAMES))
	$(info BOOKS is $(BOOKS))
	$(info LYS is $(LYS))

.PHONY: todo
todo:
	$(info doing [$@])
	$(Q)-grep TODO $(FILES_LY)

.PHONY: clean_all_png
clean_all_png:
	$(info doing [$@])
	$(Q)-find $(SOURCE_DIR) -name "*.png" -exec rm -f {} \;

.PHONY: install
install: $(ALL) $(ALL_DEP)
	$(info doing [$@])
	$(Q)rm -rf $(WEB_DIR)/*
	$(Q)mkdir $(WEB_DIR)/out
	$(Q)cp $(BOOKS) $(WEB_DIR)/out
	$(Q)for folder in $(COPY_FOLDERS); do cp -r $$folder $(WEB_DIR); done
	$(Q)cp support/redirector.html $(WEB_DIR)/index.html
	cd $(WEB_DIR); git commit -a -m "new version"; git push

# checks

.PHONY: check_ws
check_ws:
	$(info doing [$@])
	$(Q)make_helper wrapper-ok grep -e "[[:space:]]$$" $(FILES_MAKO)
.PHONY: check_naked_mymark
check_naked_mymark:
	$(info doing [$@])
	$(Q)grep "\myMark" $(FILES_MAKO) | make_helper wrapper-ok grep -v \"
.PHONY: check_and
check_and:
	$(info doing [$@])
	$(Q)make_helper wrapper-ok grep "composer=\".* and .*\"" $(FILES_MAKO)
	$(Q)make_helper wrapper-ok grep "poet=\".* and .*\"" $(FILES_MAKO)
.PHONY: check_mark
check_mark:
	$(info doing [$@])
	$(Q)make_helper wrapper-ok grep --files-without-match "\\\\myMark" $(FILES_JAZZ)
.PHONY: check_key
check_key:
	$(info doing [$@])
	$(Q)grep "\\\\key" $(FILES_JAZZ) | grep -v major | make_helper wrapper-ok grep -v minor
.PHONY: check_python
check_python:
	$(info doing [$@])
	$(Q)scripts/check.py
.PHONY: check_hardcoded_names
check_hardcoded_names:
	$(info doing [$@])
	$(Q)make_helper wrapper-ok git $(GITARGS) grep veltzer
.PHONY: check_all
check_all: check_ws check_naked_mymark check_and check_mark check_key check_python check_hardcoded_names

.PHONY: checkhtml
checkhtml: $(HTMLCHECK)
	$(info doing [$@])

# rules

# explain to make that .ps .pdf and .midi are really stamp files (do I need this ?!?)
$(FILES_PS): %.ps: %.stamp $(ALL_DEP)
	$(info doing [$@])

$(FILES_PDF): %.pdf: %.stamp $(ALL_DEP)
	$(info doing [$@])

$(FILES_MIDI): %.midi: %.stamp $(ALL_DEP)
	$(info doing [$@])

# this is the real rule
$(FILES_STAMP): %.stamp: %.ly $(LILYPOND_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(LILYPOND_WRAPPER) $(dir $@)$(basename $(notdir $@)).ps $(dir $@)$(basename $(notdir $@)).pdf $(dir $@)$(basename $(notdir $@)) $< $(DO_PDFRED_PIECES) $(DO_STOP_OUTPUT)
	$(Q)touch $@

$(OUT_DIR)/%.0.pdf: %.mako $(MAKO_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_WRAPPER) $(CONST_SONG) $(CONST_CUT) 0 $@ $<
$(OUT_DIR)/%.1.pdf: %.mako $(MAKO_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_WRAPPER) $(CONST_SONG) $(CONST_CUT) 1 $@ $<
$(OUT_DIR)/%.2.pdf: %.mako $(MAKO_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_WRAPPER) $(CONST_SONG) $(CONST_CUT) 2 $@ $<
$(OUT_DIR)/%.3.pdf: %.mako $(MAKO_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_WRAPPER) $(CONST_SONG) $(CONST_CUT) 3 $@ $<
$(FILES_LY): $(OUT_DIR)/%.ly: %.mako $(MAKO_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_WRAPPER) $(CONST_SONG) $(CONST_DONTCUT) 0 $@ $<
$(FILES_MAKO_DEPS): $(OUT_DIR)/%.mako.d: %.mako $(MAKO_DEPS_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MAKO_DEPS_WRAPPER) $< $@ $(basename $(basename $@)).stamp $(basename $(basename $@)).pdf $(basename $(basename $@)).ps $(basename $(basename $@)).midi
$(FILES_WAV): %.wav: %.midi $(MIDI2WAV_WRAPPER_DEP) $(ALL_DEP)
	$(info doing $@)
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MIDI2WAV_WRAPPER) $< $@
$(FILES_OGG): %.ogg: %.midi $(MIDI2OGG_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MIDI2OGG_WRAPPER) $< $@
$(FILES_MP3): %.mp3: %.midi $(MIDI2MP3_WRAPPER_DEP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)$(MIDI2MP3_WRAPPER) $< $@

define template
TMPL_LY_$(1):=$$(OUT_DIR)/$(1).ly
TMPL_PS_$(1):=$$(OUT_DIR)/$(1).ps
TMPL_PDF_$(1):=$$(OUT_DIR)/$(1).pdf
TMPL_PREREQ_$(1):=$(shell git ls-files src/$(1))
$$(TMPL_PDF_$(1)): $$(TMPL_LY_$(1)) $$(LILYPOND_WRAPPER_DEP) $$(ALL_DEP)
	$$(info doing [$$@])
	$$(Q)$$(LILYPOND_WRAPPER) $$(TMPL_PS_$(1)) $$(TMPL_PDF_$(1)) $$(OUT_DIR) $$< $$(DO_PDFRED_BOOKS) $$(DO_STOP_OUTPUT)
$$(TMPL_LY_$(1)): $$(TMPL_PREREQ_$(1)) $$(MAKO_WRAPPER_DEP) $$(COMMON) $$(ALL_DEP)
	$$(info doing [$$@])
	$$(Q)mkdir -p $$(dir $$@)
	$$(Q)$$(MAKO_WRAPPER) $$(CONST_BOOK) $$(CONST_DONTCUT) 0 $$@ $$(TMPL_PREREQ_$(1))
endef
$(foreach name, $(NAMES), $(eval $(call template,$(name))))

.PHONY: grive
grive: $(BOOKS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)-rm -rf ~/grive/outputs/$(tdefs.project_name)
	$(Q)-mkdir ~/grive/outputs/$(tdefs.project_name)
	$(Q)cp $(BOOKS) ~/grive/outputs/$(tdefs.project_name)
	$(Q)cd ~/grive; grive

.PHONY: dropbox
dropbox: $(BOOKS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)-rm -rf ~/Dropbox/outputs/$(tdefs.project_name)
	$(Q)-mkdir ~/Dropbox/outputs/$(tdefs.project_name)
	$(Q)cp $(BOOKS) ~/Dropbox/outputs/$(tdefs.project_name)

.PHONY: web
web: grive dropbox
	$(info doing [$@])

.PHONY: all_tunes
all_tunes: $(ALL_OUT_STAMP)
	$(info doing [$@])

$(HTMLCHECK): $(SOURCES_HTML) $(ALL_DEP)
	$(info doing [$@])
	$(Q)tidy -errors -q -utf8 $(SOURCES_HTML)
	$(Q)htmlhint $(SOURCES_HTML) > /dev/null
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(HTMLCHECK)
