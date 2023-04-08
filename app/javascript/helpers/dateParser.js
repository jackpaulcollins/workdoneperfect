/* eslint-disable import/prefer-default-export */
/* eslint-disable no-tabs */
/* eslint-disable max-len */
// fullcallendar will pass date strings in one of the following formats:
//  a single day: "April 7, 2023"
//  a single week: "Apr 2 – 8, 2023"
//  a single week straddling a month: "Mar 26 – Apr 1, 2023"
//  a single week staddling a month & year: "Dec 31, 2023 – Jan 6, 2024"
//  a single month: "April 2023"

// this class is responsible for parsing this string
// and returning

// A.) single date objects (same start/end)
// 	"April 7, 2023" => ["Fri Apr 07 2023 00:00:00 GMT-0700 (Pacific Daylight Time)","Fri Apr 07 2023 00:00:00 GMT-0700 (Pacific Daylight Time"]
// B.) two date objects:
//     1.) "Apr 2 – 8, 2023"	=>
// eslint-disable-next-line no-tabs
// 				["Fri Apr 07 2023 00:00:00 GMT-0700 (Pacific Daylight Time)", "Fri Apr 08 2023 00:00:00 GMT-0700 (Pacific Daylight Time)"]
// 		 1.) "April 2023" =>
// 				["Fri Apr 01 2023 00:00:00 GMT-0700 (Pacific Daylight Time)", "Fri Apr 30 2023 00:00:00 GMT-0700 (Pacific Daylight Time)"]

import { parse, endOfMonth } from 'date-fns';

export class DateParser {
  static EN_DASH = '–';

  static FULL_TO_ABBREV_MONTHS = {
    January: 'Jan',
    February: 'Feb',
    March: 'Mar',
    April: 'Apr',
    May: 'May',
    June: 'Jun',
    July: 'Jul',
    August: 'Aug',
    September: 'Sep',
    October: 'Oct',
    November: 'Nov',
    December: 'Dec',
  };

  static parse(dateString) {
    return this.determineDateTypeAndDelegate(dateString);
  }

  static determineDateTypeAndDelegate(dateString) {
    // the presence of a EN indicates a week
    if (dateString.includes(this.EN_DASH)) {
      return this.handleWeekString(dateString);
    }
    return this.handleDayOrMonthString(dateString);
  }

  static handleWeekString(dateString) {
    const [start, end] = dateString.replace(/,/g, '').split(this.EN_DASH);

    let endDateMonth; let endDateDay; let endDateYear; let startDateMonth; let startDateDay; let
      startDateYear;

    // we can always get the end date year first, so just get the end params now
    const endParts = end.split(' ').map((part) => part.trim()).filter(Boolean);

    // if end has alphabetical characters, we're straddling months
    if (/[a-zA-Z]/.test(end)) {
      [endDateMonth, endDateDay, endDateYear] = endParts;
    } else {
      [endDateDay, endDateYear] = endParts;
    }

    // if start has a year then we're straddling a year
    const startParts = start.split(' ').map((part) => part.trim()).filter(Boolean);
    if (/\d{4}/.test(start)) {
      [startDateMonth, startDateDay, startDateYear] = startParts;
    } else {
      [startDateMonth, startDateDay] = startParts;
    }

    const endDate = endDateMonth === undefined
      ? parse(`${endDateYear} ${startDateMonth} ${endDateDay}`, 'yyyy MMM d', new Date())
      : parse(`${endDateYear} ${endDateMonth} ${endDateDay}`, 'yyyy MMM d', new Date());

    const startDate = startDateYear === undefined
      ? parse(`${endDateYear} ${startDateMonth} ${startDateDay}`, 'yyyy MMM d', new Date())
      : parse(`${startDateYear} ${startDateMonth} ${startDateDay}`, 'yyyy MMM d', new Date());

    return [startDate, endDate];
  }

  static handleDayOrMonthString(dateString) {
    let startDate; let
      endDate;

    const parts = dateString.replace(/,/g, '').split(' ');

    if (parts.length > 2) {
      // for single days, start and end are the same
      startDate = parse(`${parts[2]} ${this.FULL_TO_ABBREV_MONTHS[parts[0]]} ${parts[1]}`, 'yyyy MMM d', new Date());
      endDate = startDate;
    } else {
      startDate = parse(`${parts[1]} ${this.FULL_TO_ABBREV_MONTHS[parts[0]]}`, 'yyyy MMM', new Date());
      endDate = endOfMonth(startDate);
    }

    return [startDate, endDate];
  }
}
