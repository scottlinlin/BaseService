//
//  ModelsDefine.h
//
//  Created by apple on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BEGIN_DEFINE_GLOBALMODEL() \
    @interface GlobalModels : NSObject \
    +(GlobalModels*) getGlobalModelsInstance; \

#define END_DEFINE_GLOBALMODEL() \
    @end \

#define BEGIN_DECLARE_GLOBALMODEL() \
    @implementation GlobalModels \
    +(GlobalModels*) getGlobalModelsInstance \
    { \
        static GlobalModels* g_defaultGlobalModels = nil; \
        if( g_defaultGlobalModels == nil ) \
        { \
            g_defaultGlobalModels = [[GlobalModels alloc] init]; \
        } \
        return g_defaultGlobalModels; \
    } \

#define END_DECLARE_GLOBALMODEL() \
    @end \


#define DEFINE_NEW_GLOBALMODEL(modelName)	\
    @property(nonatomic, strong, readonly, getter=getP##modelName) modelName* p##modelName; \

#define DECLARE_NEW_GLOBALMODEL(modelName) \
    @synthesize p##modelName = _p##modelName; \
    -(modelName*) getP##modelName \
    { \
        if( _p##modelName == nil ) {_p##modelName = [[modelName alloc] init];} \
        return _p##modelName; \
    } \

#define ADDOBSERVER(modelName, observer) [[GlobalModels getGlobalModelsInstance].p##modelName addObserver:observer];
#define REMOVEOBSERVER(modelName, observer) [[GlobalModels getGlobalModelsInstance].p##modelName removeObserver:observer];
#define GETMODEL(modelName) ([GlobalModels getGlobalModelsInstance].p##modelName)