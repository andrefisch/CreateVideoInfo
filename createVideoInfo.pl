# VIDEOS MUST BE IN FOLLOWING FORMAT:
# 25 L2 Dolniceanu ROU v Yakimenko RUS
#!/usr/bin/perl

use strict;
#use warnings;

my $path = "";
$path = shift;
print "$path/vidlist.txt\n";

open DICT, "< C:/Users/anfis/OneDrive/Documents/CreateVideoInfo/sabre.txt" or die;
open COUNTRIES, "< C:/Users/anfis/OneDrive/Documents/CreateVideoInfo/countries.txt" or die;
open VIDLIST, "< $path/vidlist.txt" or die;
open INFO, "> $path/info2.txt" or die;


print "What city does this tournament take place in?: ";
# 1 : set city tournament is in
my $city = <>;	    	#argument is passed in when script starts
print "What is the name of the tournament?: ";
# 2 : set name of tournament
my $tournament = <>;	#input this when running the script
print "What type of tournament is this?: ";
# 3 : set type of tournament (Grand Prix, World Cup, etc)
my $type = <>;	    	#input this when running the script
print "What age group is this?: ";
# 4 : set type of tournament
my $category = <>;		#input this when running the script
print "What gender is fencing?: ";
# 5 : age group
my $gender = <>;	    	#input this when running the script
print "What weapon is fencing?: ";
# 6 : set type of tournament
my $weapon = <>;		#input this when running the script

my $country = "";	    #from countries dictionary using city
my $round = "";		    #from list of files in directory
my $right_fencer = ""; 	#from fencers dictionary using fencers last name
my $left_fencer = ""; 	#from fencers dictionary using fencers last name

chomp($type);
chomp($city);
chomp($tournament);
chomp($gender);
chomp($category);
chomp($weapon);

print "\n";

my $line;

#import the fencers in dictionary form
my %fencers;
while ($line=<DICT>) {
	chomp($line);
	(my $word1,my $word2) = split /;/, $line;
	$fencers{$word1} = $word2;
}

#import the tournaments in dictionary form
my %tournaments;
while ($line=<COUNTRIES>) {
	chomp($line);
	(my $word1,my $word2) = split /,/, $line;
	$tournaments{$word1} = $word2;
}

# 4 : set country
$country = $tournaments{$city};
chomp($country);

print "\n\n$country\n\n\n";

#import the video list as an array
#only import .avi videos
my @vidlist;
my $line_num = 0;
while ($line=<VIDLIST>) {
	if (($line =~ /\.(wmv|avi|mp4)$/) == 1)
	{
		#only add to this array and increment the line number if
		#it is an avi file
		$vidlist[$line_num] = $line;
		$line_num++;
	}
}

print "===========================\n";
print "$line_num videos in this folder.\n";

#now put the data from the vidlist into the info string
my $size = @vidlist;
my @words;
for (my $i = 0; $i < $size; $i++)
{
	#split the string
	@words = split(" ", $vidlist[$i]);

	#5 : set round number : $round = part 1
	$round = $words[1];

	#6 : set_fencer on left : $left_fencer = part 5
	$left_fencer = $fencers{$words[2]};
    chomp($left_fencer);
    #$left_fencer = chomp ($left_fencer);
	print "$left_fencer\n";


	#7 : set fencer on right : $right_fencer = part 2
	$right_fencer = $fencers{$words[5]};
    chomp($right_fencer);
    #$right_fencer = chomp ($right_fencer);
	print "$right_fencer\n";

	#other information is irrelevant so we print now
	# Title info for the videos
	#but first we need to separate the .avi from the fencers country
	my $last = "";
	if (($words[6] =~ /\./) == 1)
	{
		print "Matched: <$&>\n";
		$last = $`;
	}
	elsif (($words[8] =~ /Partial/) == 1 )
	{
		$last = $words[7];
	}
	else
	{
		$last = $words[7];
	}

	# Title info for the videos
	my $title = "$city Worlds SMS 2015 - $round - $words[2] $words[3] v $words[5] $last\n\n";

	# Video info for the videos
    my $info = "If you like what I do here, don't forget to subscribe! You can also help support my videos on Patreon and follow my Instagram account for daily content!\n\nhttps://www.patreon.com/CyrusofChaos\nhttps://www.instagram.com/cyrusofchaos/\n\nThis is a bout in the round of $round at the $category $gender\'s $weapon $tournament in $city, $country. $left_fencer is on the left and $right_fencer is on the right.\n\nAlso please enjoy a discount on all Radical Fencing merchandise thanks to my new partnership with them! Click the link or apply the code 'cyrus10' at checkout!\n\nhttps://radicalfencing.com/discount/cyrus10\n\n\n\n";
    #my $info = "If you like what I do here, don't forget to subscribe! You can also help support my videos on Patreon and follow my Instagram account for daily content!\n\nhttps://www.patreon.com/CyrusofChaos\nhttps://www.instagram.com/cyrusofchaos/\n\nThis is a bout in the round of $round at the $tournament, a $category $gender\'s $weapon $type in $city, $country. $left_fencer is on the left and $right_fencer is on the right.\n\nI got this video from a stream on this channel:\n\nhttps://www.youtube.com/channel/UCRKcRBFMZyzW8Ko7qhI908Q\n\nAlso please enjoy a discount on all Radical Fencing merchandise thanks to my new partnership with them! Click the link or apply the code 'cyrus10' at checkout!\n\nhttps://radicalfencing.com/discount/cyrus10\n\n\n\n";

	print INFO "$title";
	print INFO "$info";

	print "$title\n";
}

print "Just another Perl hacker...\n";


















































