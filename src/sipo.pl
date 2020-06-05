#!/usr/bin/perl

use strict;
use warnings; 
use Text::CSV_XS;
use Switch;
use Class::Fields;

#@utor: Hugo Leite
#Versao: 13
#Data: 25/05/2020

my $layout = '';
$layout=$ARGV[0];  
my $filename = '';
$filename=$ARGV[1];
my $fileout = '';
$fileout=$ARGV[2]; 
if ($#ARGV != 2 ) {
	print "usage: sipo require three arguments: layout path_origin_file.txt path_output_file.csv\n";
	exit;
}


my $file = $filename or die "Need to get CSV file on the command line\n";
my $csv = Text::CSV_XS->new({
    sep_char => qq|\t|
});
 
 my @fields;
 
 my $probe_set_id = '';
 my $call_code_offspring = '';
 my $tx_confidence_offspring = '';
 my $vl_signal_A_offspring = '';
 my $vl_signal_B_offspring = '';
 my $call_base_offspring = '';
 my $call_code_mother = '';
 my $tx_confidence_mother = '';
 my $vl_signal_A_mother = '';
 my $vl_signal_B_mother = '';
 my $call_base_mother = '';
 my $call_code_father = '';
 my $tx_confidence_father = '';
 my $vl_signal_A_father = '';
 my $vl_signal_B_father = '';
 my $call_base_father = '';
 my $dbSNP = '';
 my $chromosome_id = '';
 my $position = '';


open(my $data, '<:encoding(utf8)', $file) or die "Could not open '$file' $!\n";     
open(my $fh_log, '>>', $fileout);
 
while (my $fields = $csv->getline($data)) {
  
  chomp $fields ;
  $fields =~ s/\s*#.*$//;
  
 
  if ($layout == '1') { # To sequence: Offspring x Mother x Father 
       $probe_set_id             = $fields->[0];  
       $call_code_offspring      = $fields->[1];
       $tx_confidence_offspring  = $fields->[2];
       $vl_signal_A_offspring    = $fields->[3];
       $vl_signal_B_offspring    = $fields->[4];
       $call_base_offspring      = $fields->[5];    
       $call_code_mother         = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $vl_signal_A_mother       = $fields->[8];
       $vl_signal_B_mother       = $fields->[9];
       $call_base_mother         = $fields->[10];  
       $call_code_father         = $fields->[11];
       $tx_confidence_father     = $fields->[12];
       $vl_signal_A_father       = $fields->[13];
       $vl_signal_B_father       = $fields->[14];
       $call_base_father         = $fields->[15];
       $dbSNP                    = $fields->[16];
       $chromosome_id            = $fields->[17];
       $position                 = $fields->[18];
  }elsif($layout == '2') { # To sequence: Offspring x Father x Mother 
       $probe_set_id             = $fields->[0];  
       $call_code_offspring      = $fields->[1];
       $tx_confidence_offspring  = $fields->[2];
       $vl_signal_A_offspring    = $fields->[3];
       $vl_signal_B_offspring    = $fields->[4];
       $call_base_offspring      = $fields->[5];    
       $call_code_father         = $fields->[6];
       $tx_confidence_father     = $fields->[7];
       $vl_signal_A_father       = $fields->[8];
       $vl_signal_B_father       = $fields->[9];
       $call_base_father         = $fields->[10];
       $call_code_mother         = $fields->[11];
       $tx_confidence_mother     = $fields->[12];
       $vl_signal_A_mother       = $fields->[13];
       $vl_signal_B_mother       = $fields->[14];
       $call_base_mother         = $fields->[15];       
       $dbSNP                    = $fields->[16];
       $chromosome_id            = $fields->[17];
       $position                 = $fields->[18];
  }elsif ($layout == '3') { # To sequence: Mother x Father x Offspring 
      $probe_set_id             = $fields->[0];        
      $call_code_mother         = $fields->[1];
      $tx_confidence_mother     = $fields->[2];
      $vl_signal_A_mother       = $fields->[3];
      $vl_signal_B_mother       = $fields->[4];
      $call_base_mother         = $fields->[5];  
      $call_code_father         = $fields->[6];
      $tx_confidence_father     = $fields->[7];
      $vl_signal_A_father       = $fields->[8];
      $vl_signal_B_father       = $fields->[9];
      $call_base_father         = $fields->[10];
      $call_code_offspring      = $fields->[11];
      $tx_confidence_offspring  = $fields->[12];
      $vl_signal_A_offspring    = $fields->[13];
      $vl_signal_B_offspring    = $fields->[14];
      $call_base_offspring      = $fields->[15];   
      $dbSNP                    = $fields->[16];
      $chromosome_id            = $fields->[17];
      $position                 = $fields->[18];
   } elsif ($layout == '4') { # To sequence: Mother x Offspring x Father
      $probe_set_id             = $fields->[0];        
      $call_code_mother         = $fields->[1];
      $tx_confidence_mother     = $fields->[2];
      $vl_signal_A_mother       = $fields->[3];
      $vl_signal_B_mother       = $fields->[4];
      $call_base_mother         = $fields->[5];  
      $call_code_offspring      = $fields->[6];
      $tx_confidence_offspring  = $fields->[7];
      $vl_signal_A_offspring    = $fields->[8];
      $vl_signal_B_offspring    = $fields->[9];
      $call_base_offspring      = $fields->[10];
      $call_code_father         = $fields->[11];
      $tx_confidence_father     = $fields->[12];
      $vl_signal_A_father       = $fields->[13];
      $vl_signal_B_father       = $fields->[14];
      $call_base_father         = $fields->[15];  
      $dbSNP                    = $fields->[16];
      $chromosome_id            = $fields->[17];
      $position                 = $fields->[18];
   } elsif ($layout == '5'){ # To sequence: Father x Offspring x Mother
      $probe_set_id             = $fields->[0];  
      $call_code_father         = $fields->[1];
      $tx_confidence_father     = $fields->[2];
      $vl_signal_A_father       = $fields->[3];
      $vl_signal_B_father       = $fields->[4];
      $call_base_father         = $fields->[5];
      $call_code_offspring      = $fields->[6];
      $tx_confidence_offspring  = $fields->[7];
      $vl_signal_A_offspring    = $fields->[8];
      $vl_signal_B_offspring    = $fields->[9];
      $call_base_offspring      = $fields->[10]; 
      $call_code_mother         = $fields->[11];
      $tx_confidence_mother     = $fields->[12];
      $vl_signal_A_mother       = $fields->[13];
      $vl_signal_B_mother       = $fields->[14];
      $call_base_mother         = $fields->[15];         
      $dbSNP                    = $fields->[16];
      $chromosome_id            = $fields->[17];
      $position                 = $fields->[18];  
   } else {  # To sequence: Father x Mother x Offspring 
      $probe_set_id             = $fields->[0];
      $call_code_father         = $fields->[1];
      $tx_confidence_father     = $fields->[2];
      $vl_signal_A_father       = $fields->[3];
      $vl_signal_B_father       = $fields->[4];
      $call_base_father         = $fields->[5];  
      $call_code_mother         = $fields->[6];
      $tx_confidence_mother     = $fields->[7];
      $vl_signal_A_mother       = $fields->[8];
      $vl_signal_B_mother       = $fields->[9];
      $call_base_mother         = $fields->[10]; 
      $call_code_offspring      = $fields->[11];
      $tx_confidence_offspring  = $fields->[12];
      $vl_signal_A_offspring    = $fields->[13];
      $vl_signal_B_offspring    = $fields->[14];
      $call_base_offspring      = $fields->[15]; 
      $dbSNP                    = $fields->[16];  
      $chromosome_id            = $fields->[17];
      $position                 = $fields->[18];
   }
   
  @fields = ($probe_set_id,$call_code_father,$tx_confidence_father,
                   $vl_signal_A_father,$vl_signal_B_father,$call_base_father,
                   $call_code_mother,$tx_confidence_mother,
                   $vl_signal_A_mother,$vl_signal_B_mother,$call_base_mother,
                   $call_code_offspring,$tx_confidence_offspring,
                   $vl_signal_A_offspring,$vl_signal_B_offspring,$call_base_offspring,                                      
                   $dbSNP,$chromosome_id,$position
               );
  
  
   my $strMutacao5 = ",Mutacao Base Nitrogenada - Origem Materna ou Paterna";
   my $strMutacao6 = ",Mutacao Base Nitrogenada - Origem Materna e Paterna";
   my $strMutacao7 = ",Mutacao Base Nitrogenada - Origem Materna";
   my $strMutacao8 = ",Mutacao Base Nitrogenada - Origem Paterna";
   my $strMutacao9 = ",Transicao - Purina/Purina";
   my $strMutacao10 = ",Transversao - Purina/Pirimidina";
   my $strMutacao15 = ",Transicao - Pirimidina/Pirimidina";
   
   my $reg = '';
   $reg = join(',',@fields);
   
   switch ($call_base_mother) {
          case 'AA' {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                    say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }                             
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {                            
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9;
                            }
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }                     
                     } #if $call_base_father 'AA'
                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            say $fh_log $reg, $strMutacao7, $strMutacao10;	 
                         }    
                         elsif($call_base_offspring eq 'TC') {
                            say $fh_log $reg, $strMutacao7, $strMutacao10;	
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }	
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }	 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }	 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }	 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'CC')
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }
                         }
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }                       
                     }#elsif ($call_base_father eq 'TT')                          
                 }  # fim do case AA;
                 
                case ['AC','CA'] {if ($call_base_father eq 'AA') {          
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8,  $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }                  
                     } #if $call_base_father 'AA'
                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }; 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            } 
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                            } 
                         }
                     }#elsif ($call_base_father eq 'CC')
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                            }
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                            } 
                         }
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            }  
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            }  
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            }  
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq '' or $call_base_offspring eq 'NoCall') {
                             #say $fh_log $reg, $strMutacao13, $strMutacao14; 
                         }
                     }#elsif ($call_base_father eq 'TT')
                 }  # fim do case AC, CA;
                 
            case ['AG','GA'] {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }                    
                     } #if $call_base_father 'AA'                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10;  
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }                       
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')                     
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao15; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                         }   
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         } 
                     }#elsif ($call_base_father eq 'CC')                     
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                              if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9; 
                         }   
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'TT')                          
                 }  # fim do case AG, GA;
                 
                 case ['AT','TA'] {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8,  $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }                   
                     } #if $call_base_father 'AA'
                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            }
                         }                   
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }   
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                         }  
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                            } 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                 
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9;
                            } 
                         }   
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         } 
                     }#elsif ($call_base_father eq 'CC')
                     
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }                         
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                         } 
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }  
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                         } 
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao15;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9; 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            }
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao15; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao8, $strMutacao10; 
                         }                         
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                            } 
                         }  
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'TT')                         
                 }  # fim do case AT, TA;                 
                 case 'CC' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }  
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }                  
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    }
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }
                                 }         
                             } #if $call_base_father 'AA'
                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }                  
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao15;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao15;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 } 
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                             }#elsif ($call_base_father eq 'TT')                                  
                 }  # fim do case CC;
                 
                 case ['CG','GC'] {if ($call_base_father eq 'AA') {          
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }   
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8,  $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }                      
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }  
                                     }                    
                                 } #if $call_base_father 'AA'
                                 
                                 elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }    
                                     elsif($call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }                      
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                 }#elsif ($call_base_father eq 'AC' or 'CA')
                                 elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }                   
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        } 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                 }#elsif ($call_base_father eq 'AG' or 'GA')
                                 
                                 elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     } 
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                 }#elsif ($call_base_father eq 'AT' or 'TA')
                                 elsif ($call_base_father eq 'CC') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }                    
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15;
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        }
                                     }
                                 }#elsif ($call_base_father eq 'CC')                                 
                                 elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }                      
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        }
                                     } 
                                 }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                                 elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10;
                                     }  
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     } 
                                 }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                                 elsif ($call_base_father eq 'GG') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     } 
                                     elsif($call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                                        } 
                                     }                      
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                                        } 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                 }#elsif ($call_base_father eq 'GG')   
                                 elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10 
                                     }
                                 }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                                 elsif ($call_base_father eq 'TT') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                 }#elsif ($call_base_father eq 'TT')    
                 }  # fim do case CG, GC;                 
                 case ['CT','TC'] {if ($call_base_father eq 'AA') {          
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10;
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8,  $strMutacao10; 
                                     } 
                                     elsif($call_base_offspring eq 'GG') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }                    
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }                    
                                 } #if $call_base_father 'AA'                                 
                                 elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10;
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }                    
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                 }#elsif ($call_base_father eq 'AC' or 'CA')
                                 elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10;
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }  
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }  
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'AG' or 'GA')
                                 
                                 elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10;
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }               
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }    
                                 }#elsif ($call_base_father eq 'AT' or 'TA')
                                 elsif ($call_base_father eq 'CC') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5,$strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }                   
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                     } 
                                 }#elsif ($call_base_father eq 'CC')                                 
                                 elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7,$strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     } 
                                 }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                                 elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }               
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }    
                                 }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                                 elsif ($call_base_father eq 'GG') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }  
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }   
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'GG')   
                                 elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                         say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                                 elsif ($call_base_father eq 'TT') {
                                     if ($call_base_offspring eq 'AA') {
                                         if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5,  $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }                
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     }    
                                 }#elsif ($call_base_father eq 'TT')                                     
                 }  # fim do case CT, TC;   
                 case 'GG' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }                  
                             } #if $call_base_father 'AA'
                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9;
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }                          
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }  
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 } 
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                             }#elsif ($call_base_father eq 'TT')                                 
                 }  # fim do case GG;         
                 
                 case ['GT','TG'] {if ($call_base_father eq 'AA') {          
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;  
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao8,  $strMutacao10; 
                                     }   
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }                    
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }              
                                 } #if $call_base_father 'AA'                                 
                                 elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;  
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }                   
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                 }#elsif ($call_base_father eq 'AC' or 'CA')
                                 elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        }  
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }    
                                     elsif($call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'AG' or 'GA')                                 
                                 elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        }  
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10;
                                        } 
                                     } 
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'AT' or 'TA')
                                 elsif ($call_base_father eq 'CC') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }                
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao6, $strMutacao15; 
                                     } 
                                 }#elsif ($call_base_father eq 'CC')                                 
                                 elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                     }
                                 }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                                 elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                                 elsif ($call_base_father eq 'GG') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }   
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'GG')   
                                 elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        }
                                     }
                                 }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                                 elsif ($call_base_father eq 'TT') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao10;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao15;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao8, $strMutacao15;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                     }
                                 }#elsif ($call_base_father eq 'TT')                                       
                 }  # fim do case GT, TG;                 
                 case 'TT' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }   
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }                
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }                      
                             } #if $call_base_father 'AA'                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }  
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     ay $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }   
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao6, $strMutacao10; 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao15; 
                                 }
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                 }
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10;
                                    }  
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao9; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                 }   
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15; 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao8, $strMutacao10; 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao15; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao10, $strMutacao15;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao10, $strMutacao15;
                                    }   
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao7, $strMutacao10; 
                                 }
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    }  
                                 }elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    } 
                                 }   
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao9, $strMutacao10;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao9, $strMutacao10;
                                    } 
                                 }                 
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao7, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao8, $strMutacao15, $strMutacao9;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao5, $strMutacao15, $strMutacao9;
                                    }
                                 }  
                             }#elsif ($call_base_father eq 'TT')                                   
                 }  # fim do case TT;
                 #case '' {say $fh_log $reg, $strMutacao13, $strMutacao14;} # fim do case ''                         
        }  # fim do switch         
   }  # fim do while
	