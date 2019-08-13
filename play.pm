#!C:\Strawberry\perl\bin\perl.exe

# This module is intended to store scripts to automatically generate binding values used for bench queries
use 5.18.0;
use warnings;

# Name: wpaPicker
# Developer: Ryan Burns
# Purpose: Generate you daily wpaPick
# Inputs:
#	None
sub wpaPicker {
    my %playerList = (
        1  => 'Acuna',
        2  => 'Inciarte',
        3  => 'Freeman',
        4  => 'Donaldson',
        5  => 'Duvall',
        6  => 'Riley',
        7  => 'McFlow',
        8  => 'Albies',
        9  => 'Starting Pitcher',
        10 => 'Blevins',
        11 => 'Jackson',
        12 => 'Martin',
        13 => 'Newcomb',
        14 => 'Greene',
        15 => 'Tomlin',
        16 => 'Melancon',
        17 => 'Swarzak',
        18 => 'Opposing Starter',
        19 => 'Culberson',
        20 => 'Joyce',
        21 => 'Camargo',
        0  => 'Opposing Closer'
    );

    my $player = int( rand(22) );

    say $playerList{$player};
    say int( rand(2) )+1;
}

1;
