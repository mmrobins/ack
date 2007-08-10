#!perl

use warnings;
use strict;

use Test::More tests => 2;
use File::Next ();
delete $ENV{ACK_OPTIONS};

use lib 't';
use Util;

my @full_lyrics = <DATA>;
chomp @full_lyrics;

NORMAL: {
    my @expected = split( /\n/, <<'EOF' );
Painting a picture of you
And I'm looking at you
Looking at me, telling me you love me,
And you're happy to be with me on the 4th of July
If you ain't got no one
To keep you hanging on
And there you were
Like a queen in your nightgown
And I'm singing to you
And I'm lookin' for you
EOF

    my @files = qw( t/text/4th-of-july.txt );
    my @args = qw( you --text );
    my $cmd = "$^X ./ack-standalone @args @files";
    my @results = `$cmd`;
    chomp @results;

    lists_match( \@results, \@expected, q{I'm lookin' for you} );
}

DASH_C: {
    my @expected = @full_lyrics;

    my @files = qw( t/text/4th-of-july.txt );
    my @args = qw( you --text --passthru );
    my $cmd = "$^X ./ack-standalone @args @files";
    my @results = `$cmd`;
    chomp @results;

    lists_match( \@results, \@expected, q{Still lookin' for you, in passthru mode} );
}

__DATA__
Alone with the morning burning red
On the canvas in my head
Painting a picture of you
And me driving across country
In a dusty old RV
Just the road and its majesty
And I'm looking at you
With the world in the rear view

Chorus:
You were pretty as can be, sitting in the front seat
Looking at me, telling me you love me,
And you're happy to be with me on the 4th of July
We sang "Stranglehold" to the stereo
Couldn't take no more of that rock and roll
So we put on a little George Jones and just sang along

Those white lines
Get drawn into the sun
If you ain't got no one
To keep you hanging on
And there you were
Like a queen in your nightgown
Riding shotgun from town to town
Staking a claim on the world we found
And I'm singing to you
You're singing to me
You were out of the blue to a boy like me

Chorus

And I'm lookin' for you
In the silence that we shared

Chorus

    -- "4th of July", Shooter Jennings