package com.merrillcorp.integration.util;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
/**
 * 
 * @author bkalali
 *
 */
public class DateUtil {

	public static String convertFromDSOtoAria(String fromDate) {
		if (fromDate != null) {
			DateTimeFormatter dateTimeFormat = DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");
			DateTime dt = DateTime.parse(fromDate, dateTimeFormat);
			return dt.toString("yyyy-MM-dd");
		} else {
			throw new IllegalArgumentException("fromDate cannot be null");
		}

	}
	
	public static String convertFromAriatoOracle(String fromDate) {
		if (fromDate != null) {
			DateTimeFormatter dateTimeFormat = DateTimeFormat.forPattern("yyyy-MM-dd' 'HH:mm:ss");
			DateTime dt = DateTime.parse(fromDate, dateTimeFormat);
			return dt.toString("yyyy-MM-dd");
		} else {
			throw new IllegalArgumentException("fromDate cannot be null");
		}

	}

}
