//
//  macors.h
//  ProjectBaseFrame
//
//  Created by Josh.Shron on 10/21/15.
//  Copyright © 2015 josh.shron. All rights reserved.
//

#ifndef macors_h
#define macors_h

#define projectObjc ([ProjectHelper shareHelper])
#define iosVersion(_version) ([[[UIDevice currentDevice] systemVersion] doubleValue] > _version)

#endif /* macors_h */
