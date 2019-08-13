#!C:\Strawberry\perl\bin\perl.exe

# This module is intended to store scripts to automatically generate binding values used for bench queries
#
#Module Version information:
#
#NAME		DATE		VERSION		COMMENT
#Ryan Burns	2019-08-13	1.0			Initial Upload
#
#Module Versioning Conventions:
#	New subquery or change that will break how the subquery works gets a new major version number
#	Any other change increments the minor version number
#
#	New subquery or fundamental change 
use 5.18.0;
use warnings;
use POSIX qw( strftime );
use Time::Seconds 'ONE_DAY';

my @ctrlChars = qw(^ $ * + ? - | [ ] ( ) { } \ );

# Name: msgParse
# Developer: Ryan Burns
# Purpose: Generate the bindings necessary for parsing an HL7 message
# Inputs:
#	1. Segment name (Required) - for example, OBR
#	2. Position (Required) - What position you want, for example 16 if you want the ordering provider from the OBR segment
#	3. Element delimiter (optional) - If the element you are pulling is delimited, what the delimiting character is. For example, OBR 16 is usually delimited by ^
#	   The default is ~ is nothing is given (dummy character since Bench can't handle null bindings)
#	4. Element (optional) - If the element is delimited, which # you want. For example, if OBR 16 is 8675309^BURNS^RYAN and you want BURNS you would set this to 2
sub msgParse {
	my $segment = shift;
	my $position = shift;
	my $elDelim = (shift || "~");
	my $element = (shift || 1);
	my $escapedDelim;
	if (!$segment || !$position){
		say "the first two inputs are required.";
		exit;
	}
	foreach my $s (@ctrlChars) {
		if ($s eq $elDelim) {
			$escapedDelim = '\\'.$elDelim;
		}
	}
	say "$elDelim,$elDelim,$segment\\|,$position," . ( $escapedDelim || $elDelim) . ",$elDelim,$element";
}
# Name: apptRange 
# Developer: Ryan Burns
# Purpose: Generate the bindings necessary for searching appointments by a time range
# Inputs:
#	1. Department Id (Required) - The Id of the department that you are searching appointments for
#	2. Start Time (Optional) - The time you want the search to start in the format YYYY-MM-DD HH24:MI:SS. Defaults to the current time
#	3. End Time (optional) - The time you want the search to end. Defaults to 24h from now
sub apptRange {
	my $epoch =  time;
	my $d1	=	$epoch + ONE_DAY;
	my $dept = shift;
	if (!$dept){
		say "the department input is required";
		exit;
	}	
	my $start = (shift || strftime("%Y-%m-%d %H:%M:%S",localtime($epoch)));
	my $end = (shift || strftime("%Y-%m-%d %H:%M:%S",localtime($d1)));
	say "$start,$end,$dept";
}
 
# Name: dateRange 
# Developer: Ryan Burns
# Purpose: Generate a start and end time binding
# Inputs:
#	1. Start Time (optional) - The time you want the search to start in the format YYYY-MM-DD. Defaults to yesterday
#	2. End Time (optional) - The time you want the search to end. Defaults to the current date
sub dateRange {
    my $epoch =  time;
    my $d1  =   $epoch - ONE_DAY;
    my $start = (shift || strftime("%Y-%m-%d",localtime($d1)));
    my $end = (shift || strftime("%Y-%m-%d",localtime($epoch)));
    say "$start,$end";
}
1;