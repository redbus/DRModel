/*
 *  DRModelConstants.h
 *
 *  Created by Daniel Ricciotti on 3/1/10.
 *  Copyright 2010 Daniel Ricciotti. All rights reserved.
 *
 */

// Load Image Timeout (in seconds)
// Specify the timeout period for loading any images from DRModel
#define kImageTimeout 20.0f

// Load data Timeout (in seconds)
// Specify the timeout period for loading data from DRModel
#define kDataTimeout 20.0f

// Identifier used by classes that dont want to specify a queue identifier. Uses default queue pool.
// Note: This also defines the maximum number of pools. 
#define specialPoolDontCare 99

/* Return Values */
typedef enum resultCode {
	resultCodeSuccess,
	resultCodeTimeout,
	resultCodeServerError,
	resultCodeError
} resultCode;

/* Object Types */
typedef enum objectType {
	objectTypeImage,
	objectTypeVideoList
} objectType;

typedef enum activityOption {
	activityOptionLoading,
	activityOptionFinished,
	activityOptionNeedsReload
} activityOption;

/* Cache Options */
typedef enum cacheOption {
	cacheOptionIgnore,
	cacheOptionRead,
	cacheOptionWrite,
	cacheOptionReadAndWrite
} cacheOption;

typedef uint32_t objectID;
typedef uint32_t queueID;
typedef uint32_t poolID;
