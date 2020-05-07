#!/usr/bin/env python

import sys
import mako.exceptions
import mako.lookup
import mako.template
import os.path
import config.openbook
import io

from scripts import attr


def is_ready(filename):
    for line in io.open(filename, encoding='utf-8'):
        if line == '\tattributes[\'completion\']=\'5\'\n':
            return True
    return False


def main():
    if len(sys.argv) < 6:
        raise ValueError('command line issue', sys.argv)

    input_encoding = 'utf-8'
    output_encoding = 'utf-8'
    p_book = bool(int(sys.argv[1]))
    p_cut = bool(int(sys.argv[2]))
    p_cutnum = int(sys.argv[3])
    p_output = sys.argv[4]
    p_input = sys.argv[5:]
    common = 'include/common.ly.mako'

    '''
    We really need the unlink, even though we have *open a file
    for writing* later on which is supposed to truncate the file to 0
    since we chmod the output to be unwritable which means that the
    *open a file for writing* later would fail...
    '''
    if os.path.isfile(p_output):
        os.unlink(p_output)

    # if there is any error, remove the output to prevent having
    # bad output...
    try:
        mylookup = mako.lookup.TemplateLookup(
            directories=['.'],
            input_encoding=input_encoding,
            output_encoding=output_encoding,
        )
        template = mako.template.Template(
            filename=common,
            lookup=mylookup,
            input_encoding=input_encoding,
            output_encoding=output_encoding,
        )
        gattr = {}
        if p_book:
            filelist = p_input
            filelist = list(filter(is_ready, filelist))
            filelist.sort()
            gattr['files'] = filelist
            gattr['book'] = True
            gattr['toc'] = True
            gattr['midi'] = False
            # put each tune in it's own book part (avoid lilypond performance problems)
            gattr['parts'] = True
        else:
            gattr['files'] = p_input
            gattr['book'] = False
            gattr['toc'] = False
            gattr['midi'] = True
            gattr['parts'] = False
        gattr['inline'] = True
        # put some space after each tune
        gattr['space_after_tune'] = False
        # put a page break after each tune
        gattr['break_after_tune'] = False
        # put a page break after the toc?
        gattr['break_after_toc'] = True
        gattr['lilypond_version'] = config.openbook.lilypond_version
        attributes = attr.Attributes()
        if p_cut:
            template.render(attributes=attributes, gattr=gattr, scratch={})
            attributes.cut(p_cutnum, p_output)
        else:
            file = open(p_output, 'wb')
            file.write(template.render(attributes=attributes, gattr=gattr, scratch={}))
            file.close()
            os.chmod(p_output, 0o0444)
    except Exception as e:
        if os.path.isfile(p_output):
            os.unlink(p_output)
        print(mako.exceptions.text_error_template().render())
        raise e


if __name__ == "__main__":
    main()
