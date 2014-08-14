#!/usr/bin/awk -f 

# usage: ./subadj.awk -v s=+10 -v ms=-350 foo.srt > foo-synced.srt

BEGIN { 
    OFS = ""
    add_sec = s
    add_msec = ms
} 

function Adj (ts, add_sec, add_msec) {							
    h = 0 + substr(ts, 1, 2); 
    m = 0 + substr(ts, 4, 2); 
    s = 0 + substr(ts, 7, 2);		
    ms = 0 + substr(ts, 10, 3);
    s += add_sec;
    ms += add_msec;
    while (ms >= 1000) { ms -= 1000; s++; }	
    while (ms < 0) { ms += 1000; s--; }	
    while (s >= 60) { s -= 60; m++; }	
    while (s < 0) { s += 60; m--; }	
    while (m >= 60) { m -= 60; h++; }	
    while (m < 0) { m += 60; h--; }	
    return (sprintf ("%.2d:%.2d:%.2d,%.3d", h, m, s, ms));	
}	
! /-->/ { print; next; }	
{ print Adj($1, add_sec, add_msec), $2, Adj( $3, add_sec, add_msec); }	
