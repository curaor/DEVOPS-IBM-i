000100170226  //***************************************************************
000101170226     H COPYRIGHT('(C) Copyright Booth Martin, 2010 All rights reserved.')
000102170226     H option(*nodebugio) dftactgrp(*no) actgrp(*caller)
000103170226     FPOPUPCALD cf   e             workstn
000104170226
000105170226     d StartDate       s               d
000106170226     d wDate           s               d
000107170226      // Use firstdate to figure 1st day-of-month (1900-01-07 is a Sunday).
000108170226     d firstdate       s               d   inz(d'1900-01-07')
000109170226     d day#            s              2s 0
000110170226     d wNdx            s             10i 0
000111170226     d wString         s             10
000112170226     d wMONTHYEAR      s                   like(MONTHYEAR)
000113170226     d CurYear         s              4s 0
000114170226     d CurMonth        s              2s 0
000115170226     d CurDay          s              2
000116170226      // Array of slots on calendar (6 rows of 7 days)
000117170226     d                 ds
000118170226     d wCalendar                     76
000119170226      * Fill the screen's 38 slots from the wCalendaray.
000120170226     d   day01                             overlay(wCalendar)
000121170226     d   day02                             overlay(wCalendar: *next)
000122170226     d   day03                             overlay(wCalendar: *next)
000123170226     d   day04                             overlay(wCalendar: *next)
000124170226     d   day05                             overlay(wCalendar: *next)
000125170226     d   day06                             overlay(wCalendar: *next)
000126170226     d   day07                             overlay(wCalendar: *next)
000127170226     d   day08                             overlay(wCalendar: *next)
000128170226     d   day09                             overlay(wCalendar: *next)
000129170226     d   day10                             overlay(wCalendar: *next)
000130170226     d   day11                             overlay(wCalendar: *next)
000131170226     d   day12                             overlay(wCalendar: *next)
000132170226     d   day13                             overlay(wCalendar: *next)
000133170226     d   day14                             overlay(wCalendar: *next)
000134170226     d   day15                             overlay(wCalendar: *next)
000135170226     d   day16                             overlay(wCalendar: *next)
000136170226     d   day17                             overlay(wCalendar: *next)
000137170226     d   day18                             overlay(wCalendar: *next)
000138170226     d   day19                             overlay(wCalendar: *next)
000139170226     d   day20                             overlay(wCalendar: *next)
000140170226     d   day21                             overlay(wCalendar: *next)
000141170226     d   day22                             overlay(wCalendar: *next)
000142170226     d   day23                             overlay(wCalendar: *next)
000143170226     d   day24                             overlay(wCalendar: *next)
000144170226     d   day25                             overlay(wCalendar: *next)
000145170226     d   day26                             overlay(wCalendar: *next)
000146170226     d   day27                             overlay(wCalendar: *next)
000147170226     d   day28                             overlay(wCalendar: *next)
000148170226     d   day29                             overlay(wCalendar: *next)
000149170226     d   day30                             overlay(wCalendar: *next)
000150170226     d   day31                             overlay(wCalendar: *next)
000151170226     d   day32                             overlay(wCalendar: *next)
000152170226     d   day33                             overlay(wCalendar: *next)
000153170226     d   day34                             overlay(wCalendar: *next)
000154170226     d   day35                             overlay(wCalendar: *next)
000155170226     d   day36                             overlay(wCalendar: *next)
000156170226     d   day37                             overlay(wCalendar: *next)
000157170226     d   day38                             overlay(wCalendar: *next)
000158170226     d Arr                            2    dim(38) overlay(wCalendar)
000159170226      //  Number of days in the month:
000160170226     d pdmds           ds
000161170226     d                                2  0 inz(31)
000162170226     d                                2  0 inz(28)
000163170226     d                                2  0 inz(31)
000164170226     d                                2  0 inz(30)
000165170226     d                                2  0 inz(31)
000166170226     d                                2  0 inz(30)
000167170226     d                                2  0 inz(31)
000168170226     d                                2  0 inz(31)
000169170226     d                                2  0 inz(30)
000170170226     d                                2  0 inz(31)
000171170226     d                                2  0 inz(30)
000172170226     d                                2  0 inz(31)
000173170226     d                                2  0 inz(01)
000174170226     d pdm                            2  0 dim(13) overlay(pdmds)
000175170226     d MonthNames      ds
000176170226     d                                9    inz('January  ')
000177170226     d                                9    inz('February ')
000178170226     d                                9    inz('March    ')
000179170226     d                                9    inz('April    ')
000180170226     d                                9    inz('May      ')
000181170226     d                                9    inz('June     ')
000182170226     d                                9    inz('July     ')
000183170226     d                                9    inz('August   ')
000184170226     d                                9    inz('September')
000185170226     d                                9    inz('October  ')
000186170226     d                                9    inz('November ')
000187170226     d                                9    inz('December ')
000188170226     d  MthNam                        9    dim(12) overlay(MonthNames)
000189170226
000190170226     d SetScreenSize   pr            10i 0 extproc('QsnRtvScrDim')
000191170226     d   NbrRows                     10i 0 options(*omit)
000192170226     d   NbrCols                     10i 0 options(*omit)
000193170226     d   Handle                      10i 0 options(*omit)
000194170226     d   ErrorCode                32767    options(*varsize: *omit)
000195170226     d   NbrColumns    s             10i 0
000196170226
000197170226     d POPUPCALR       pr
000198170226     d  pDate                          d
000199170226     d POPUPCALR       pi
000200170226     d  pDate                          d
000201170226      // ===============================================================
000202170226      // ==         Mainline                                          ==
000203170226      // ===============================================================
000204170226      /free
000205170226       //check current screen size, configure to match
000206170226       SetScreenSize(*omit:NbrColumns:*omit:*omit);
000207170226       if nbrColumns = 132;
000208170226         *in90 = *on;
000209170226       else;
000210170226         *in90 = *off;
000211170226       endif;
000212170226       exsr FillCalendar;
000213170226       dow not *inlr;
000214170226         exfmt fmt001;
000215170226         select;
000216170226         when *inkl or *inkc;   // exit/return
000217170226           exsr ExitPgm;
000218170226           // Go back one year.
000219170226         when CSRFLD = 'PREVYEAR';
000220170226           startdate = startdate - %years(1);
000221170226           exsr FillCalendar;
000222170226           // Go back one month
000223170226         when CSRFLD = 'PREVMONTH';  // Pagedown
000224170226           startdate = startdate - %months(1);
000225170226           exsr FillCalendar;
000226170226           // Go forward one month
000227170226         when CSRFLD = 'NEXTMONTH';  // Pageup
000228170226           startdate = startdate + %months(1);
000229170226           exsr FillCalendar;
000230170226           // Go forward one year.
000231170226         when CSRFLD = 'NEXTYEAR';
000232170226           startdate = startdate + %years(1);
000233170226           exsr FillCalendar;
000234170226           // end of job -  Either a command key or Enter key:
000235170226         other;
000236170226         if %parms = 1 and %subst(CSRFLD: 1: 3) = 'DAY';
000237170226           exsr FillParm;
000238170226           exsr ExitPgm;
000239170226         endif;
000240170226         endsl;
000241170226       enddo;
000242170226       // End of routine:
000243170226       // ===============================================================
000244170226       // ==         Sub Routines                                      ==
000245170226       // ===============================================================
000246170226       //-------------------------------------------------------------------
000247170226       //--  Initializing routine                                       --
000248170226       //-------------------------------------------------------------------
000249170226       begsr *inzsr;
000250170226         if (%parms = 1) and (pdate <> *loval);
000251170226           StartDate = pDate;
000252170226         else;
000253170226           StartDate = %date();
000254170226         endif;
000255170226       endsr;
000256170226       //-------------------------------------------------------------------
000257170226       //--  Exit routine                                                 --
000258170226       //-------------------------------------------------------------------
000259170226       begsr ExitPgm;
000260170226         *inlr = *on;
000261170226         return;
000262170226       endsr;
000263170226       //-------------------------------------------------------------------
000264170226       //--  Fill the calendar fields.                                    --
000265170226       //-------------------------------------------------------------------
000266170226       begsr FillCalendar;
000267170226         // Get fields to fill calendar
000268170226         CurYear  = %subdt(StartDate: *y);
000269170226         CurMonth = %subdt(StartDate: *m);
000270170226         CurDay   = %char(%subdt(StartDate: *d));
000271170226         clear MONTHYEAR;
000272170226         wMONTHYEAR = %trim(mthnam(CurMonth)) + ', ' + %char(CurYear);
000273170226         wNdx = (%size(MONTHYEAR) - %len(%trim(wMONTHYEAR))) / 2;
000274170226         %subst(MONTHYEAR: wNdx) = %trim(wMONTHYEAR);
000275170226         // is this a leap year?
000276170226         if %rem(CurYear: 4) = 0
000277170226               and CurYear <> 2000;
000278170226           pdm(2) = 29;
000279170226         endif;
000280170226         // Fill array with date numbers
000281170226         clear arr;
000282170226         // Find day of the week for first day on the calendar
000283170226         wDate = StartDate - %days(%int(CurDay) - 1);
000284170226         day# = %rem((%diff(wDate: firstdate: *days)): 7) + 1;
000285170226         // Fill the calendar slots with days of the month, beginning @ day#
000286170226         for wNdx = 1 to pdm(CurMonth);
000287170226           evalr Arr(day#) = %char(wNdx);
000288170226           day# += 1;
000289170226         endfor;
000290170226       endsr;
000291170226       //-------------------------------------------------------------------
000292170226       //--  Fill return parm                                         --
000293170226       //-------------------------------------------------------------------
000294170226       begsr FillParm;
000295170226       // Fill return fields
000296170226       wNdx = %int(%subst(%trim(csrfld): 4: 2));
000297170226       if Arr(wNdx) > ' ';
000298170226         wNdx = %int(Arr(wNdx));
000299170226         if wNdx < 10;  // Re-insert leading zero if day is 1st - 9th.
000300170226           CurDay = '0' + %trim(%char(wNdx));
000301170226         else;
000302170226           CurDay = %char(wNdx);
000303170226         endif;
000304170226         wString = %editc(CurYear: 'X') + '-'
000305170226               + %editc(CurMonth: 'X') + '-'
000306170226               + CurDay;
000307170226         pDate = %date(wString: *iso);
000308170226       endif;
000309170226       endsr;
000310170226       //-------------------------------------------------------------------
000311170226       //--  End-of subroutines                                           --
000312170226       //-------------------------------------
