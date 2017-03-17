#!/usr/bin/perl
use strict;
use warnings;
use version;

my $websitefile = $ARGV[0];
if (!$websitefile) {
	print "Usage:\n./jscraper.pl <websitefile>\n\n";
	exit 0;
}

open my $websitedata, '<', $websitefile;
chomp(my @websites = <$websitedata>);
close $websitedata;

sub versioncheck {
	my $v1 = shift;
        my $v2 = shift;
	if ( version->parse($v1) < version->parse($v2) ) {
                return "true";
        }
}

sub jquery {
	my $website = shift;
        my @phantom = `phantomjs lib/jquery.js $website`;
        foreach (@phantom) {
                chomp(my $line = $_);
                if ($line =~ /jQuery (.+)$/) {
                        my $version = $1;
                        print "Found jQuery --> ";
                        if (&versioncheck($version,"1.6.2") eq "true") {
                                print "Version: $version - Warning: Possible XSS - See: http://www.cvedetails.com/cve/CVE-2011-4969/\n\n";
                        } elsif (&versioncheck($version,"1.10.0") eq "true") {
                                print "Version: $version - Warning: Possible XSS - See: http://www.cvedetails.com/cve/CVE-2010-5312/\n\n";
                        } else {
                                print "Version: $version\n\n";
                        }
                }
        }
}

sub angular {
        my $website = shift;
        my @phantom = `phantomjs lib/angular.js $website`;
        foreach (@phantom) {
                chomp(my $line = $_);
                if ($line =~ /jQuery (.+)$/) {
                        my $version = $1;
                        print "Found angular.js --> ";
                        if (&versioncheck($version,"1.6.2") eq "true") {
                                print "Version: $version - Warning: Possible XSS - See: http://www.cvedetails.com/cve/CVE-2011-4969/\n\n";
                        } elsif (&versioncheck($version,"1.10.0") eq "true") {
                                print "Version: $version - Warning: Possible XSS - See: http://www.cvedetails.com/cve/CVE-2010-5312/\n\n";
                        } else {
                                print "Version: $version\n\n";
                        }
                }
        }
}

foreach (@websites) {
	chomp(my $website = $_);
	print "Website: $website\n";
	&jquery($website);
	print "\n";
}
