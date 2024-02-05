//
//  LuaWrapper.m
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

#include "LuaWrapper.h"
#import <Foundation/Foundation.h>

LUAMOD_API int luaopen_os (lua_State *L) {
    return 1;
}

#pragma mark - Lua

@implementation Lua

- (void) setup {
    luaState = luaL_newstate();
    luaL_openlibs(luaState);
}

- (NSString*) getLuaText: (const char *) getLuaText {
    luaL_loadstring(luaState, getLuaText);
    /*LUA_NUMBER result = */lua_pcall(luaState, 0, 1, 0);

    const char* strResult = lua_tostring(luaState, -1);
    lua_pop(luaState, 1);

    NSString* resultString = [NSString stringWithCString: strResult encoding: NSASCIIStringEncoding];

    return resultString;
}

- (void) destruct {
    lua_close(luaState);
}

@end

#pragma mark - LuaWrapper

@implementation LuaWrapper

-(NSString *) getLuaText {
    NSURL* filename = NSBundle.mainBundle.resourceURL;
    filename = [filename URLByAppendingPathComponent: @"getLuaText.lua"];

    Lua* lua = [[Lua alloc] init];
    [lua setup];

    NSString* luaScript = [NSString stringWithContentsOfURL: filename encoding: NSASCIIStringEncoding error: Nil];
    char* ptrScript = strdup([luaScript cStringUsingEncoding: NSASCIIStringEncoding]);
    NSString* result = [lua getLuaText: ptrScript];

    free(ptrScript);
    [lua destruct];

    return result;
}

@end
