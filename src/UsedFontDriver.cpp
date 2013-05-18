/*
 Source File : UsedFontDriver.h
 
 
 Copyright 2013 Gal Kahana HummusJS
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */
#include "UsedFontDriver.h"
#include "PDFUsedFont.h"
#include "UnicodeString.h"
#include <list>

#include FT_GLYPH_H

using namespace v8;

Persistent<Function> UsedFontDriver::constructor;
Persistent<FunctionTemplate> UsedFontDriver::constructor_template;

UsedFontDriver::UsedFontDriver()
{
    UsedFont = NULL;
}

void UsedFontDriver::Init()
{
    // prepare the page interfrace template
    Local<FunctionTemplate> t = FunctionTemplate::New(New);
    constructor_template = Persistent<FunctionTemplate>::New(t);
    constructor_template->SetClassName(String::NewSymbol("PDFUsedFont"));
    constructor_template->InstanceTemplate()->SetInternalFieldCount(1);
    constructor_template->PrototypeTemplate()->Set(String::NewSymbol("calculateTextDimensions"),FunctionTemplate::New(CalculateTextDimensions)->GetFunction());
    
    constructor = Persistent<Function>::New(constructor_template->GetFunction());
}

Handle<Value> UsedFontDriver::NewInstance(const Arguments& args)
{
    HandleScope scope;
    
    const unsigned argc = 0;
    Local<Object> instance = constructor->NewInstance(argc, NULL);
        
    return scope.Close(instance);
}

bool UsedFontDriver::HasInstance(Handle<Value> inObject)
{
    return inObject->IsObject() &&
    constructor_template->HasInstance(inObject->ToObject());
}

Handle<Value> UsedFontDriver::New(const Arguments& args)
{
    HandleScope scope;
    
    UsedFontDriver* usedFont = new UsedFontDriver();
    usedFont->Wrap(args.This());
    return args.This();
}

Handle<Value> UsedFontDriver::CalculateTextDimensions(const Arguments& args)
{
    // completly copied of the freetype toturial.... :)
    // this will calculate the dimensions of a string. it uses mainly the "advance"
    // of the glyphs, which is what the plain text placement of hummus does...so it should be
    // alligned with it. right now there's no kerning calculations, simply because there's no kerning right now.
    HandleScope scope;
    long fontSize;

    if(args.Length() < 1 || args.Length() > 2 ||
       (!args[0]->IsString() && !args[0]->IsArray()) ||
       (args.Length() == 2 && !args[1]->IsNumber()))
    {
		ThrowException(Exception::TypeError(String::New("Wrong arguments, provide a string or array of glyph indexes, and optionally also a font size")));
        return scope.Close(Undefined());
    }
    
    if(args.Length() == 2)
        fontSize = args[1]->ToNumber()->Uint32Value();
    else
        fontSize = 1;
    
    UIntList glyphs;
    
    PDFUsedFont* theFont =  ObjectWrap::Unwrap<UsedFontDriver>(args.This())->UsedFont;
    FreeTypeFaceWrapper* ftWrapper = theFont->GetFreeTypeFont();
    FT_Face ftFont = (*ftWrapper).operator->();
    
    if(args[0]->IsString()) // if string, use freetype wrapper of the used font to get the glyph indexes
    {
        UnicodeString unicode;
        
        unicode.FromUTF8(*String::Utf8Value(args[0]->ToString()));
        ftWrapper->GetGlyphsForUnicodeText(unicode.GetUnicodeList(),glyphs);
    }
    else // array of glyph indexes
    {
        unsigned int arrayLength = args[0]->ToObject()->Get(v8::String::New("length"))->ToNumber()->Uint32Value();
        for(unsigned int i=0; i < arrayLength;++i)
            glyphs.push_back(args[0]->ToObject()->Get(i)->ToNumber()->Uint32Value());
    }
    
    // now calculate the placement bounding box. using the algorithm described in the FreeType turtorial part 2, minus the kerning part, and with no scale

    // first, calculate the pen advancements
    int           pen_x, pen_y;
    std::list<FT_Vector> pos;
    pen_x = 0;   /* start at (0,0) */
    pen_y = 0;
    
    UIntList::iterator it = glyphs.begin();
    for(; it != glyphs.end();++it)
    {
        pos.push_back(FT_Vector());

        pos.back().x = pen_x;
        pos.back().y = pen_y;

        pen_x += ftWrapper->GetGlyphWidth(*it);
    }
    
    // now let's combine with the bbox, so we get the nice bbox for the whole string
    
    FT_BBox  bbox;
    FT_BBox  glyph_bbox;
    bbox.xMin = bbox.yMin =  32000;
    bbox.xMax = bbox.yMax = -32000;
    
    it = glyphs.begin();
    std::list<FT_Vector>::iterator itPos = pos.begin();
    
    for(; it != glyphs.end();++it,++itPos)
    {
        FT_Load_Glyph(ftFont,ftWrapper->GetGlyphIndexInFreeTypeIndexes(*it),FT_LOAD_NO_SCALE);
        FT_Glyph aGlyph;
        FT_Get_Glyph( ftFont->glyph,&aGlyph);
        FT_Glyph_Get_CBox(aGlyph, FT_GLYPH_BBOX_UNSCALED,&glyph_bbox);
        FT_Done_Glyph(aGlyph);
        
        glyph_bbox.xMin = ftWrapper->GetInPDFMeasurements(glyph_bbox.xMin);
        glyph_bbox.xMax = ftWrapper->GetInPDFMeasurements(glyph_bbox.xMax);
        glyph_bbox.yMin = ftWrapper->GetInPDFMeasurements(glyph_bbox.yMin);
        glyph_bbox.yMax = ftWrapper->GetInPDFMeasurements(glyph_bbox.yMax);
        
        glyph_bbox.xMin += itPos->x;
        glyph_bbox.xMax += itPos->x;
        glyph_bbox.yMin += itPos->y;
        glyph_bbox.yMax += itPos->y;
    
        
        if ( glyph_bbox.xMin < bbox.xMin )
            bbox.xMin = glyph_bbox.xMin;
        
        if ( glyph_bbox.yMin < bbox.yMin )
            bbox.yMin = glyph_bbox.yMin;
        
        if ( glyph_bbox.xMax > bbox.xMax )
            bbox.xMax = glyph_bbox.xMax;
        
        if ( glyph_bbox.yMax > bbox.yMax )
            bbox.yMax = glyph_bbox.yMax;
    }
    if ( bbox.xMin > bbox.xMax )
    {
        bbox.xMin = 0;
        bbox.yMin = 0;
        bbox.xMax = 0;
        bbox.yMax = 0;
    }
    
    
    Handle<Object> result = Object::New();
    // file the end object with results
    
    // adapt results to the size, and PDF font size
    
    result->Set(String::New("xMin"),Number::New((double)(bbox.xMin*fontSize)/1000));
    result->Set(String::New("yMin"),Number::New((double)(bbox.yMin*fontSize)/1000));
    result->Set(String::New("xMax"),Number::New((double)(bbox.xMax*fontSize)/1000));
    result->Set(String::New("yMax"),Number::New((double)(bbox.yMax*fontSize)/1000));
    result->Set(String::New("width"),Number::New((double)(bbox.xMax-bbox.xMin)*fontSize/1000));
    result->Set(String::New("height"),Number::New((double)(bbox.yMax-bbox.yMin)*fontSize/1000));
    
    return scope.Close(result);
}

