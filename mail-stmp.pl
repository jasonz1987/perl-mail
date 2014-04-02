#!/usr/bin/perl -w
#
# Desc:perl script for sending mail with mail command
# Author:by Jason.z
# Mail:ccnuzxg@gmail.com
# Date:2014-04-01
# 
# more info : https://metacpan.org/pod/Net::SMTP
use Net::SMTP;
use Authen::SASL;
# the smtp host 
my $mailhost = "mail.***.com"; 
# your email address 
my $mailfrom = '123@***.com';
# the recipient list
my @mailto = ('test1@gmail.com', 'test2@hotmail.com'); 
my $subject = "your email title";
my $text = 'your email body content';

# if you read your email body from file ,use this code
# 
# open(FILE,$text) || die "Can not open list file";
# undef $/;
# $text=<FILE>;

my $smtp = Net::SMTP->new($mailhost,Hello => 'localhost', Timeout => 120, Debug => 1) or die "Could not connect SMTP server:$@";
# anth login, type your user name and password here
$smtp->auth('user','pass') or die "Could not authenticate:$@";

foreach my $mailto (@mailto) 
{
	# Send the From and Recipient for the mail servers that require it
	$smtp->mail($mailfrom);
	$smtp->to($mailto);
	# Start the mail
	$smtp->data();
	# Send the header
	$smtp->datasend("To: $mailto\n");
	$smtp->datasend("From: $mailfrom\n");
	$smtp->datasend("Subject: $subject\n");
	$smtp->datasend("\n");
	# Send the message
	$smtp->datasend("$text\n");
	# Send the termination string
	$smtp->dataend();
}

$smtp->quit;