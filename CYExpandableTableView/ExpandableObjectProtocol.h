//
//  ExpandableObjectProtocol.h
//  TrackDown
//
//  Created by Gocy on 16/7/22.
//  Copyright © 2016年 Gocy. All rights reserved.
//

#ifndef ExpandableObjectProtocol_h
#define ExpandableObjectProtocol_h


@protocol ExpandableObject <NSObject>


@required
-(NSUInteger)countOfSecondaryObjects;

@optional
/**
 *  Must be implemented if you use default table view cell.
 *
 *  @return return an array of string that describes your secondary object.
 */
-(NSArray *)descriptionForSecondaryObjects;


/**
 *  Must be implemented if you use default header view.
 *
 *  @return return a string that describes your header.
 */
-(NSString *)description;

@property (nonatomic ,readwrite) BOOL opened;

@end

#endif /* ExpandableObjectProtocol_h */
