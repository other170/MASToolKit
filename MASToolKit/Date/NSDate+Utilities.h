/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

// "_": "-", S: 空格, C: 冒号

typedef NS_ENUM(NSInteger, EXTDateFormat)
{
    EXTDateyyyy,
    EXTDateyyyyNianMMYue,
    EXTDateyyyy_MM_dd,
    EXTDatehh,
    EXTDatemm,
    EXTDatess,
    EXTDatea,
    EXTDateMM,
    EXTDatedd,
    EXTDateyyyy_MM_ddSHHCmm,
    EXTDateyyyy_MM_ddSHHCmmCss,
    EXTDateHHCmm,
    EXTDateyyyyMMddHHmm,
    EXTDateMM_dd,
    EXTDateyyyyNianMMYueddRiSHHCmm,
    EXTDateMMYueddRiSHHCmm,
    EXTDateyyyyMMdd,
    EXTDateyyyyMMddHHmmss,
    EXTDateMM_ddSHHCmm,
    EXTDateyyyy_MM_ddSHH,
    EXTDateyyyyCMMCddSHHCmmCss,
    EXTDateyy_MM_dd,
};


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Utilities)
+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Short string utilities
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

/// 获取指定date的详细信息
@property (readonly) NSInteger br_year;    // 年
@property (readonly) NSInteger br_month;   // 月
@property (readonly) NSInteger br_day;     // 日

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger) distanceInDaysToDate:(NSDate *)anotherDate;

//判断俩个时间的差值
- (NSInteger)checkDateDifferenceWithDate:(NSDate *)date;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

// Formatter
- (NSString *)dateOfStringWithFormat:(EXTDateFormat)format;


//##################################################################################################

//[dateString] 转 [date]
+ (NSDate *)dateFromString:(NSString *)dateString format:(EXTDateFormat)format;
//[时间戳] 转 [dateString]
+ (NSString *)getLocateTime:(unsigned int)timeStamp;

+ (NSString *)getDianLocateTime:(NSString *)timeStamp;

+ (NSString *)getHoursLocateTime:(NSString *)timeStamp;

+ (NSString *)getQuantumLocateTime:(NSString *)timeStamp;

+ (NSString *)getCurrentLocateTime;

+ (NSDate *)getTimeAfterNowWithDay:(NSInteger)day;

+ (NSDate *)getTimeBeforNowWithDay:(NSInteger)day;

+ (NSInteger )numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

// 算法：获取某个月的天数（通过年月求每月天数）
+ (NSUInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month;

@end
