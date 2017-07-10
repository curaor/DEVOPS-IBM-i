000001170710      *  devops test
000100170225     H option(*nodebugio) dftactgrp(*no) actgrp(*new)
000200170225     FDATEMATHD cf   e             workstn
000300170225
000400170707      *  ASCII art panel for heading. (Use a Figlet generator.)
000500170225     D FIGLET          ds
000600170225     D*Figar                         60    dim(6) ctdata perrcd(1)
000700170225      * Constants
000800170225     D  cTRQ           c                   x'30'
000900170225      // Work fields
001000170225     D wTestDate       s               d   inz(d'2010-01-04')
001100170225     D wNdx            s             10i 0
001200170225     D wS1Exit         s               n
001300170225
001400170225     D GetCalendar     pr                  extpgm('POPUPCALR')
001500170225     D  pDate                          d
001600170225
001700170225      /FREE
001800170225        //====================================================================*
001900170708        // MAIN CALCULATION                                                  *
002000170225        //====================================================================*
002100170225         // Loop until exit.
002200170225         wS1Exit = *off;
002300170225         dow wS1Exit = *off;
002400170225           //   Display screen.
002500170225           exsr S1Fill;
002600170225           exfmt FMT01;
002700170225           //   Perform keypress.
002800170225           select;
002900170225             //     F3=Exit.
003000170225           when *inkc = *on;
003100170225             wS1Exit = *on;
003200170225           when *inkd or FLD = 'DATEF4';
003300170225             GetCalendar(DAT);
003400170225           other;  // everything else; process the enter key
003500170225             exsr S1KeyEnter;
003600170225           endsl;
003700170225         enddo;
003800170225         exsr ExitPgm;
003900170225         //====================================================================*
004000170225         // MAINLINE-END                                                       *
004100170225         //====================================================================*
004200170225         //-------------------------------*  Sub-Routine  *
004300170225         // *inzsr()                      *---------------*
004400170225         // Initialize variables, set constants.          *
004500170225         //-----------------------------------------------*
004600170225       begsr *inzsr;
004700170225         DAT = %date();
004800170225         // change color in heading
004900170225       endsr;
005000170225         //-------------------------------*  Sub-Routine  *
005100170225         // ExitPgm()                     *---------------*
005200170225         // Exit program.                                 *
005300170225         //-----------------------------------------------*
005400170225         begsr ExitPgm;
005500170225           *inlr = *on;
005600170225           return;
005700170225         endsr;
005800170225         //--------------------------------------------------------------------*
005900170225         // Screen 1 procedures.        Screen1                                *
006000170225         //--------------------------------------------------------------------*
006100170225         //-------------------------------*  Sub-Routine  *
006200170225         // S1Fill()                      *---------------*
006300170225         // Screen - Fill screen.                         *
006400170225         //-----------------------------------------------*
006500170225         begsr S1Fill;
006600170225           exsr GetDayOfWeek;
006700170225           exsr GetJulianDate;
006800170225           exsr GetEndOfMonth;
006900170225           exsr GetLastFriday;
007000170225           exsr GetNextTuesday;
007100170225           exsr AddDaysToDate;
007200170225           exsr SetCYYMMDDDate;
007300170225           TIMEUSA = (%char(%time(): *usa));
007400170225           DATEUSA = %char(%date(): *mdy);
007500170225         endsr;
007600170225         //-------------------------------*  Sub-Routine  *
007700170225         // S1KeyEnter()                  *---------------*
007800170225         // Enter key                                     *
007900170225         //-----------------------------------------------*
008000170225         begsr S1KeyEnter;
008100170225           exsr S1Validate;
008200170225           if *in90 = *off;  // If no errors then proceed.
008300170225             exsr S1Process;
008400170225           endif;
008500170225         endsr;
008600170225         //-------------------------------*  Sub-Routine  *
008700170225         // S1Validate()                  *---------------*
008800170225         // Screen - Validate entry fields.               *
008900170225         //-----------------------------------------------*
009000170225         begsr S1Validate;
009100170225           *in90 = *off;
009200170225         endsr;
009300170225         //-------------------------------*  Sub-Routine  *
009400170225         // S1Process()                   *---------------*
009500170225         // Process screen 1                              *
009600170225         //-----------------------------------------------*
009700170225         begsr S1Process;
009800170225         endsr;
009900170225         //-------------------------------*  Sub-Routine  *
010000170225         // GetDayOfWeek()                *---------------*
010100170225         // Get the day of the week                       *
010200170225         //-----------------------------------------------*
010300170225         begsr GetDayOfWeek;
010400170225            wNdx = %diff(DAT: wTestDate: *days);
010500170225            wNdx = %rem(wNdx: 7);
010600170225            select;
010700170225            when wNdx = 0;
010800170225              DOWEEK = 'Monday';
010900170225            when wNdx = 1;
011000170225              DOWEEK = 'Tuesday';
011100170225            when wNdx = 2;
011200170225              DOWEEK = 'Wednesday';
011300170225            when wNdx = 3;
011400170225              DOWEEK = 'Thursday';
011500170225            when wNdx = 4;
011600170225              DOWEEK = 'Friday';
011700170225            when wNdx = 5;
011800170225              DOWEEK = 'Saturday';
011900170225            when wNdx = 6;
012000170225              DOWEEK = 'Sunday';
012100170225            endsl;
012200170225         endsr;
012300170225        //-------------------------------*  Sub-Routine  *
012400170225        // GetJulianDate()               *---------------*
012500170225        // Get the Julian date                           *
012600170225        //-----------------------------------------------*
012700170225         begsr GetJulianDate;
012800170225           JDAY = DAT;
012900170225         endsr;
013000170225        //-------------------------------*  Sub-Routine  *
013100170225        // GetEndOfMonth()               *---------------*
013200170225        // Get the end of this month                     *
013300170225        //-----------------------------------------------*
013400170225        begsr GetEndOfMonth;
013500170225          EOM = DAT + %months(1);
013600170225          EOM = EOM - %days(%subdt(EOM: *days));
013700170225        endsr;
013800170225        //-------------------------------*  Sub-Routine  *
013900170225        // GetLastFriday()               *---------------*
014000170225        // Get a day in the past (next Friday, for demo.)*
014100170225        //-----------------------------------------------*
014200170225        begsr GetLastFriday;
014300170225          wNdx = %diff(DAT: wTestDate: *days);
014400170225          wNdx = %rem(wNdx: 7);
014500170225          wNdx = 3 + wNdx;
014600170225          LASTFRI = DAT - %days(wNdx);
014700170225        endsr;
014800170225        //-------------------------------*  Sub-Routine  *
014900170225        // GetNextTueday()               *---------------*
015000170225        // Get some day in the future (Tuesday as a demo)*
015100170225        //-----------------------------------------------*
015200170225        begsr GetNextTuesday;
015300170225          wNdx = %diff(DAT: wTestDate: *days);
015400170225          wNdx = %rem(wNdx: 7);
015500170225          if wNdx = 0;
015600170225            wNdx = 7;
015700170225          endif;
015800170225          wNdx = (8 - wNdx);
015900170225          NEXTTUE = DAT + %days(wNdx);
016000170225        endsr;
016100170225        //-------------------------------*  Sub-Routine  *
016200170225        // AddDaysToDate()               *---------------*
016300170225        // Add/subtract days from a date                 *
016400170225        //-----------------------------------------------*
016500170225        begsr AddDaysToDate;
016600170225          ADDSUB = DAT + %days(ADDDAYS);
016700170225        endsr;
016800170225        //-------------------------------*  Sub-Routine  *
016900170225        // SetCYYMMDDDate()              *---------------*
017000170225        // Deal with C datess                            *
017100170225        //-----------------------------------------------*
017200170225        begsr SetCYYMMDDDate;
017300170225          CDAY = %char(DAT: *CYMD0);
017400170225          REGDATE = %char(%date(CDAY: *CYMD0));
017500170225        endsr;
017600170225      /END-FREE
