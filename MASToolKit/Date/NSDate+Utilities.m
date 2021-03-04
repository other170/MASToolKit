/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen
 
 Include GMT and time zone utilities?
*/

#import "NSDate+Utilities.h"

// Thanks, AshFurrow
static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond | kCFCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (Utilities)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) && 
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    /*Allan if (components1.week != components2.week) return NO;*/
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (/*Allan abs*/fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) dateAtEndOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 23; // Thanks Aleksey Kononov
	components.minute = 59;
	components.second = 59;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	/*Allan return components.week;*/
    return components.weekOfYear;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.year;
}





#pragma mark - Formatter

- (NSString *)dateOfStringWithFormat:(EXTDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (format) {
        case EXTDateyyyy:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        case EXTDateyyyyNianMMYue:
            [dateFormatter setDateFormat:@"yyyy年MM月"];
            break;
        case EXTDateyyyy_MM_dd:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case EXTDatehh:
            [dateFormatter setDateFormat:@"hh"];
            break;
        case EXTDatemm:
            [dateFormatter setDateFormat:@"mm"];
            break;
        case EXTDatess:
            [dateFormatter setDateFormat:@"ss"];
            break;
        case EXTDatea:
            [dateFormatter setDateFormat:@"a"];
            break;
        case EXTDateMM:
            [dateFormatter setDateFormat:@"MM"];
            break;
        case EXTDatedd:
            [dateFormatter setDateFormat:@"dd"];
            break;
        case EXTDateyyyy_MM_ddSHHCmm:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case EXTDateyyyy_MM_ddSHHCmmCss:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case EXTDateHHCmm:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case EXTDateyyyyMMddHHmm:
            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            break;
        case EXTDateMM_dd:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case EXTDateMMYueddRiSHHCmm:
            [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
            break;
        case EXTDateyyyyNianMMYueddRiSHHCmm:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            break;
        case EXTDateyyyyMMdd:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
        case EXTDateyyyyMMddHHmmss:
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        case EXTDateMM_ddSHHCmm:
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case EXTDateyyyy_MM_ddSHH:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
            break;
        case EXTDateyy_MM_dd:
            [dateFormatter setDateFormat:@"yy-MM-dd"];
            break;
        default:
            break;
    }
    NSString *timeString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:self]];
    return timeString;
}


+ (NSDate *)dateFromString:(NSString *)dateString format:(EXTDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (format) {
        case EXTDateyyyy:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        case EXTDateyyyyNianMMYue:
            [dateFormatter setDateFormat:@"yyyy年MM月"];
            break;
        case EXTDateyyyy_MM_dd:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case EXTDatehh:
            [dateFormatter setDateFormat:@"hh"];
            break;
        case EXTDatemm:
            [dateFormatter setDateFormat:@"mm"];
            break;
        case EXTDatess:
            [dateFormatter setDateFormat:@"ss"];
            break;
        case EXTDatea:
            [dateFormatter setDateFormat:@"a"];
            break;
        case EXTDateMM:
            [dateFormatter setDateFormat:@"MM"];
            break;
        case EXTDatedd:
            [dateFormatter setDateFormat:@"dd"];
            break;
        case EXTDateyyyy_MM_ddSHHCmm:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case EXTDateyyyy_MM_ddSHHCmmCss:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case EXTDateyyyyCMMCddSHHCmmCss:
            [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
            break;
        case EXTDateyyyyMMddHHmm:
            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            break;
        case EXTDateMM_dd:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case EXTDateyyyyNianMMYueddRiSHHCmm:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        case EXTDateMMYueddRiSHHCmm:
            [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
            break;
        case EXTDateyyyyMMdd:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
        case EXTDateyyyyMMddHHmmss:
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        case EXTDateHHCmm:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case EXTDateyy_MM_dd:
            [dateFormatter setDateFormat:@"yy-MM-dd"];
            break;
        default:
            break;
    }
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//时间戳转时间
+ (NSString *)getLocateTime:(unsigned int)timeStamp {
    double dTimeStamp = (double)timeStamp;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dTimeStamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    return dateStr;
}

//时间戳转日期
+ (NSString *)getDianLocateTime:(NSString *)timeStamp {
    NSTimeInterval interval = [timeStamp longLongValue] / 1000.0;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    return dateStr;
}

//时间戳转时间
+ (NSString *)getHoursLocateTime:(NSString *)timeStamp {
    NSTimeInterval interval = [timeStamp longLongValue] / 1000.0;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm";
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    return dateStr;
}

+ (NSString *)getQuantumLocateTime:(NSString *)timeStamp{
    NSTimeInterval interval = [timeStamp longLongValue] / 1000.0;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm";
    NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
    NSString *quantumStr =  [dateStr substringWithRange:NSMakeRange(11,2)];
    NSString *subString = [dateStr substringToIndex:10];
    NSString *resultString;
    if (quantumStr.integerValue <= 11) {
        resultString = [NSString stringWithFormat:@"%@ 上午",subString];
    }else if(quantumStr.integerValue >=12 && quantumStr.integerValue <= 18){
        resultString = [NSString stringWithFormat:@"%@ 下午",subString];
    }else{
        resultString = [NSString stringWithFormat:@"%@ 晚上",subString];
    }
    return resultString;
}
+ (NSString *)getCurrentLocateTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [format1 stringFromDate:date];
    return dateStr;
}

//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];

    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
 
    return timeSp;
    
}

#pragma mark - 获取日历单例对象
+ (NSCalendar *)calendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        // 创建日历对象：返回当前客户端的逻辑日历(当每次修改系统日历设定，其实例化的对象也会随之改变)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}
#pragma mark - 获取指定日期的年份
- (NSInteger)br_year {
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *components = [[NSDate calendar] components:componentFlags fromDate:self];
    return components.year;
}

#pragma mark - 获取指定日期的月份
- (NSInteger)br_month {
    NSDateComponents *components = [[NSDate calendar] components:componentFlags fromDate:self];
    return components.month;
}

#pragma mark - 获取指定日期的天
- (NSInteger)br_day {
    NSDateComponents *components = [[NSDate calendar] components:componentFlags fromDate:self];
    return components.day;
}

//判断俩个时间的差值
- (NSInteger)checkDateDifferenceWithDate:(NSDate *)date{

    //计算两个中间差值(秒)
    NSTimeInterval time = [self timeIntervalSinceDate:date];
    
    //开始时间和结束时间的中间相差的时间
    NSInteger days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    
    return ABS(days);
}
//  得到当前时间之后N天的日期
+ (NSDate *)getTimeAfterNowWithDay:(NSInteger)day{
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    if(day!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*day ];

    }else{
        theDate = nowDate;
    }
    return theDate;
}
//  得到当前时间之前N天的日期
+ (NSDate *)getTimeBeforNowWithDay:(NSInteger)day{
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    if(day!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*day ];
  
    }else{
        theDate = nowDate;
    }
    return theDate;
}
+ (NSInteger )numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    // 创建一个标准国际时间的日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 可根据需要自己设置时区.
    calendar.timeZone = [NSTimeZone systemTimeZone];
    // 获取两个日期的间隔
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
    return comp.day;
}

#pragma mark - 算法：获取某个月的天数（通过年月求每月天数）
+ (NSUInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month {
    BOOL isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
        {
            return 31;
            break;
        }
        case 4:case 6:case 9:case 11:
        {
            return 30;
            break;
        }
        case 2:
        {
            if (isLeapYear) {
                return 29;
                break;
            } else {
                return 28;
                break;
            }
        }
        default:
            break;
    }
    return 0;
}

@end
