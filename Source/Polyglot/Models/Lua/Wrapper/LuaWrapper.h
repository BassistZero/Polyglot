//
//  LuaWrapper.h
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

#import "lua.h"
#import "lauxlib.h"
#import "lualib.h"

#import <Foundation/Foundation.h>

#pragma mark - Lua

@interface Lua : NSObject {
    lua_State* luaState;
}

- (void) setup;
- (NSString*_Nullable) getLuaText: (const char*_Nonnull) getLuaText;
- (void) destruct;

@end

#pragma mark - LuaWrapper

@interface LuaWrapper : NSObject

- (NSString*_Nonnull) getLuaText;

@end
