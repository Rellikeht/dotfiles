local lexers = vis.lexers
local peaksea={
	bgdark='#1c1c1c',--black
	bglight='#e4e4e4',--white
	annotationdark='#5fff87',--green
	annotationlight='#00875f',--tuerkis
	functiondark='#e8a0e8',--violett
	functionlight='#af5faf',--pink
	normalfontdark='#d0d0d0',--dark grey
	normalfontlight='#000000',--grey
	stringdark='#afd7ff',--light grey
	stringlight='#005f5f',--cyan
	numberdark='#e0c060',--dark yellow
	numberlight='#875f00',--dark yellow little brown
	commentdark='#d0d090',--dark golden dirty
	commentlight='#5f5f00',--light golden dirty
	bgerrordark='#aa0000',--red
	bgerrorlight='#80c0e0',--red
	fglinenumberdark='#b0b0b0',--white
	fglinenumberlight='#6c6c6c',--grey
	constantdark='#80c0e0',--cyan
	constantlight='#000000',
	identifierdark='#d0d0d0',--white
	identifierlight='#000000',
	bgstatusdark='#d7ff00',--dark yellow
	bgstatuslight='#000000',
	bgcursordark='#262626',
	bgcursorlight='#add8e6',--cyan
	fgoperatorlight='#005faf',--blue
	fgdark='#d0d0d0',
	fglight='#1b1b1b',
	embeddedlight='#875f00',
	fgstatusbarlight='#5fffaf'
}
if background==nil
then
    background="dark"
end

if background=="dark"
then
    lexers.STYLE_DEFAULT='fore:'..peaksea.fgdark..', back:'..peaksea.bgdark
    lexers.STYLE_CLASS='fore:'..peaksea.normalfontdark
    lexers.STYLE_COMMENT='fore:'..peaksea.commentdark
    lexers.STYLE_CONSTANT='fore:'..peaksea.constantdark
    lexers.STYLE_DEFINITION='fore:'..peaksea.bgerrordark--TODO
    lexers.STYLE_ERROR='fore:'..peaksea.commentdark..',back:'..peaksea.bgerrordark
    lexers.STYLE_FUNCTION='fore:'..peaksea.functiondark
    lexers.STYLE_KEYWORD = 'fore:'..peaksea.stringdark--if other logical operators
    lexers.STYLE_LABEL = 'fore:'..peaksea.functiondark
    lexers.STYLE_NUMBER = 'fore:'..peaksea.numberdark
	vis.lexers.STYLE_OPERATOR = vis.lexers.STYLE_DEFAULT--for the brackets
    lexers.STYLE_REGEX = 'fore:'..peaksea.bgerrordark
    lexers.STYLE_STRING = 'fore:'..peaksea.stringdark
    lexers.STYLE_PREPROCESSOR = 'fore:'..peaksea.annotationdark--annotations
    lexers.STYLE_TAG = 'fore:'..peaksea.bgerrordark
    lexers.STYLE_TYPE = 'fore:'..peaksea.functiondark
    lexers.STYLE_VARIABLE = 'fore:'..peaksea.functiondark
    lexers.STYLE_WHITESPACE = ''
    lexers.STYLE_EMBEDDED = 'fore:'..peaksea.commentdark
    lexers.STYLE_IDENTIFIER = 'fore:'..peaksea.identifierdark --imports and co

    lexers.STYLE_LINENUMBER='fore:'..peaksea.fglinenumberdark..',back:'..peaksea.bgdark
    lexers.STYLE_LINENUMBER_CURSOR = 'fore:'..peaksea.fglinenumberdark..',back:'..peaksea.bgdark
    lexers.STYLE_CURSOR='fore:'..peaksea.bgdark..',back:'..peaksea.annotationdark
    
    lexers.STYLE_CURSOR_PRIMARY = 'fore:'..peaksea.bgdark..',back:'..peaksea.stringdark--cursor in normal mode
    lexers.STYLE_CURSOR_LINE = 'back:'..peaksea.bgcursordark
	
    lexers.STYLE_COLOR_COLUMN = 'back:'..peaksea.normalfontdark
    lexers.STYLE_SELECTION = 'fore:'..peaksea.bgdark..',back:'..peaksea.stringdark
    lexers.STYLE_STATUS = 'fore:'..peaksea.bgdark..',back:'..peaksea.bgstatusdark
    lexers.STYLE_STATUS_FOCUSED = 'fore:'..peaksea.bgdark..',back:'..peaksea.bgstatusdark
    lexers.STYLE_SEPARATOR = 'back:'..peaksea.bgstatusdark
    lexers.STYLE_INFO = 'fore:'..peaksea.bgerrordark
    lexers.STYLE_EOF = 'fore:'..peaksea.fglinenumberdark..',back:'..peaksea.bgdark
elseif background=="light"
then
    lexers.STYLE_DEFAULT='fore:'..peaksea.fglight..',back:'..peaksea.bglight
    lexers.STYLE_CLASS='fore:'..peaksea.normalfontlight
    lexers.STYLE_COMMENT='fore:'..peaksea.commentlight
    lexers.STYLE_CONSTANT='fore:'..peaksea.constantlight
    lexers.STYLE_DEFINITION='fore:'..peaksea.bgerrorlight--TODO
    lexers.STYLE_ERROR='fore:'..peaksea.commentlight..',back:'..peaksea.bgerrorlight
    lexers.STYLE_FUNCTION='fore:'..peaksea.functionlight
    lexers.STYLE_KEYWORD = 'fore:'..peaksea.fgoperatorlight..',bold'--if other logical operators
    lexers.STYLE_LABEL = 'fore:'..peaksea.functionlight
    lexers.STYLE_NUMBER = 'fore:'..peaksea.numberlight
	vis.lexers.STYLE_OPERATOR = 'fore:'..peaksea.fgoperatorlight
    lexers.STYLE_REGEX = 'fore:'..peaksea.bgerrorlight
    lexers.STYLE_STRING = 'fore:'..peaksea.stringlight
    lexers.STYLE_PREPROCESSOR = 'fore:'..peaksea.annotationlight--annotations
    lexers.STYLE_TAG = 'fore:'..peaksea.bgerrorlight
    lexers.STYLE_TYPE = 'fore:'..peaksea.functionlight
    lexers.STYLE_VARIABLE = 'fore:'..peaksea.functionlight
    lexers.STYLE_WHITESPACE = ''
    lexers.STYLE_EMBEDDED = 'fore:'..peaksea.embeddedlight
    lexers.STYLE_IDENTIFIER = 'fore:'..peaksea.identifierlight --imports and co

    lexers.STYLE_LINENUMBER='fore:'..peaksea.fglinenumberlight..',back:'..peaksea.bglight
    lexers.STYLE_LINENUMBER_CURSOR = 'fore:'..peaksea.fglinenumberlight..',back:'..peaksea.bglight
    lexers.STYLE_CURSOR='fore:'..peaksea.bglight..',back:'..peaksea.bgdark--bgcursorlight
    
    lexers.STYLE_CURSOR_PRIMARY = 'fore:'..peaksea.bgdark..',back:'..peaksea.bgcursorlight--cursor in normal mode
    lexers.STYLE_CURSOR_LINE = 'back:'..peaksea.bglight
	
    lexers.STYLE_COLOR_COLUMN = 'back:'..peaksea.normalfontlight
    lexers.STYLE_SELECTION = 'fore:'..peaksea.bglight..',back:'..peaksea.bgcursorlight..',bold'
    lexers.STYLE_STATUS = 'fore:'..peaksea.bglight..',back:'..peaksea.bgstatuslight
    lexers.STYLE_STATUS_FOCUSED = 'fore:'..peaksea.fgstatusbarlight..',back:'..peaksea.bgstatuslight
    lexers.STYLE_SEPARATOR = 'back:'..peaksea.bgstatuslight
    lexers.STYLE_INFO = 'fore:'..peaksea.bgerrorlight
    lexers.STYLE_EOF = 'fore:'..peaksea.fglinenumberlight..',back:'..peaksea.bglight
end
