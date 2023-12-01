#!/usr/bin/perl

use strict;
use warnings; 
use Text::CSV_XS;
use Switch;
use Class::Fields;

#@uthor: Hugo Leite
#leader: Alexandre Caetano; Claudio da Silva; Divino Aparecido da Cruz
#Versao: 17
#Data: 25/07/2020
#Data: 30/11/2023 - Artigo Lorraynne & Peixoto
#Include to variants

my $layout = '';
$layout=$ARGV[0];  
my $filename = '';
$filename=$ARGV[1];
my $fileout = '';
$fileout=$ARGV[2]; 
if ($#ARGV != 2 ) {
	print "usage: sipo require three arguments: <layout> <path_origin_file.txt> <path_output_file.csv>\n";
	exit;
}


my $file = $filename or die "Need to get CSV file on the command line\n";
my $csv = Text::CSV_XS->new({
    sep_char => qq|\t|
});
 
 my @fields;
 
 # montando a sequencia das colunas da planilha
 # my $probe_set_id = '';
 # my $call_code_offspring = '';
 my $position = '';
 my $dbSNP = '';
 my $call_base_father = '';
 my $call_base_mother = '';
 my $call_base_offspring = '';
 my $tx_confidence_father = '';
 my $tx_confidence_mother = '';
 my $tx_confidence_offspring = '';
 my $chromosome_id = '';  
 
 # my $vl_signal_A_offspring = '';
 # my $vl_signal_B_offspring = '';
 # my $call_code_mother = '';
 # my $vl_signal_A_mother = '';
 # my $vl_signal_B_mother = '';
 # my $call_code_father = ''; 
 # my $vl_signal_A_father = '';
 # my $vl_signal_B_father = '';

open(my $data, '<:encoding(utf8)', $file) or die "Could not open '$file' $!\n";     
open(my $fh_log, '>>', $fileout);
 
while (my $fields = $csv->getline($data)) {
  
  chomp $fields ;
  $fields =~ s/\s*#.*$//;
  
 
  if ($layout == '1') { # To sequence: Offspring x Mother x Father 
       $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];
       
  }elsif($layout == '2') { # To sequence: Offspring x Father x Mother 
       $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];
       
  }elsif ($layout == '3') { # To sequence: Mother x Father x Offspring 
      $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];
       
   } elsif ($layout == '4') { # To sequence: Mother x Offspring x Father
       $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];
       
   } elsif ($layout == '5'){ # To sequence: Father x Offspring x Mother
       $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];  
       
   } else {  # To sequence: Father x Mother x Offspring 
       $position                 = $fields->[1];
       $dbSNP                    = $fields->[2];
       $call_base_father         = $fields->[3];
       $call_base_mother         = $fields->[4]; 
       $call_base_offspring      = $fields->[5];
       $tx_confidence_father     = $fields->[6];
       $tx_confidence_mother     = $fields->[7];
       $tx_confidence_offspring  = $fields->[8];
       $chromosome_id            = $fields->[9];
   }
   
  @fields = ($position, $dbSNP, $call_base_father,        
             $call_base_mother, $call_base_offspring,     
             $tx_confidence_father, $tx_confidence_mother,    
             $tx_confidence_offspring, $chromosome_id);
  
  
   my $strMutacao1 = ",Mutation NB - Paternal or Maternal";   
   my $strMutacao2 = ",Mutation NB - Maternal Origin";
   my $strMutacao3 = ",Mutation NB - Paternal Origin";
   my $strMutacao11 = ",Transition - Purine/Purine";
   my $strMutacao12 = ",Transversion - Purine/Pyrimidine";
   my $strMutacao13 = ",Transition - Pyrimidine/Pyrimidine";
   my $strMutacao21 = ",Unsolved";
   my $variante1 = ",C>A";
   my $variante2 = ",G>T";
   my $variante3 = ",C>G";
   my $variante4 = ",G>C";
   my $variante5 = ",C>T";
   my $variante6 = ",G>A";
   my $variante7 = ",T>A";
   my $variante8 = ",A>T";
   my $variante9 = ",T>C";
   my $variante10 = ",A>G";
   my $variante11 = ",T>G";
   my $variante12 = ",A>C";
   
   my $reg = '';
   $reg = join(',',@fields);
   
   switch ($call_base_mother) {
          case 'AA' {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                    say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }                             
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {                            
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }                     
                     } #if $call_base_father 'AA'
                                          
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            say $fh_log $reg, $strMutacao2, $strMutacao11, $variante12;
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            say $fh_log $reg, $strMutacao2, $strMutacao11, $variante12, $variante10; 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12, $variante8;	 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }	
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante12; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }	 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }	 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }	 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'CC')
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante1, $variante6;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante5, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante10; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }
                         }
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1, $variante7;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3, $variante11; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         } 
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante4; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante12; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante12; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante10, $variante11; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         }                       
                     }#elsif ($call_base_father eq 'TT')                          
                 }  # fim do case AA;
                 
                case ['AC','CA'] {if ($call_base_father eq 'AA') {          
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3,  $strMutacao12, $variante8; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }                  
                     } #if $call_base_father 'AA'
                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }; 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12, $variante4; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8, $variante2; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10, $variante3; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante11; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            } 
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10, $variante11; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante10, $variante3; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante5; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                            } 
                         }
                     }#elsif ($call_base_father eq 'CC')
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante1, $variante6;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante5, $variante2; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                            }
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante11; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                            } 
                         }
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante1, $variante7;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante3, $variante11; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante10, $variante11; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            }  
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10, $variante3; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante3; 
                         }
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante4; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante10, $variante3; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante5; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            }  
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10, $variante8;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante10; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante9; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante9; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante9; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante9; 
                         } 
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            }  
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante5; 
                         }
                     }#elsif ($call_base_father eq 'TT')
                 }  # fim do case AC, CA;
                 
            case ['AG','GA'] {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }                    
                     } #if $call_base_father 'AA'                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4;  
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante3; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5;
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }                       
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            }  
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')                     
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao13, $variante9; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante11; 
                         }   
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                         }
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         } 
                     }#elsif ($call_base_father eq 'CC')                     
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante1;
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                              if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12; 
                         } 
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante4; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }
                         }                      
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2, $variante12; 
                         }  
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2, $variante8; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante9; 
                         }  
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante11; 
                         }   
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                         }
                     }#elsif ($call_base_father eq 'TT')                          
                 }  # fim do case AG, GA;
                 
                 case ['AT','TA'] {if ($call_base_father eq 'AA') {          
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3,  $strMutacao12, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante10; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                         }                   
                     } #if $call_base_father 'AA'
                     
                     elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                         if($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9;  
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            }
                         }                   
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12, $variante3; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5; 
                         }
                     }#elsif ($call_base_father eq 'AC' or 'CA')
                     elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                         }   
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante11; 
                         }  
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                         }
                     }#elsif ($call_base_father eq 'AG' or 'GA')
                     
                     elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                         if ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                            } 
                         } 
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                 
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                            } 
                         }   
                     }#elsif ($call_base_father eq 'AT' or 'TA')
                     elsif ($call_base_father eq 'CC') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante11; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                     
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                         } 
                     }#elsif ($call_base_father eq 'CC')
                     
                     elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante1, $variante3;
                         }                         
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao13, $variante2, $variante5; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante8, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $variante8, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $variante10, $variante11; 
                         }    
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante2, $variante5; 
                         } 
                     }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                     elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1, $variante7;
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3, $variante11; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9, $variante12; 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante9, $variante10; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }  
                     }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                     elsif ($call_base_father eq 'GG') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                         }
                         elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12, $variante2; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante12; 
                         }   
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante9, $variante12; 
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante10, $variante11; 
                         } 
                         elsif($call_base_offspring eq 'TT') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                         }
                     }#elsif ($call_base_father eq 'GG')   
                     elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao13, $variante7, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante4, $variante9; 
                         }
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $variante9, $variante12; 
                         } 
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            }
                         }
                         elsif($call_base_offspring eq 'GG') {
                             say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante10, $variante11; 
                         }
                     }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                     elsif ($call_base_father eq 'TT') {
                         if ($call_base_offspring eq 'AA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7;
                         }
                         elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao13, $variante12, $variante9; 
                         }
                         elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                             say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                         }                         
                         elsif($call_base_offspring eq 'CC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }
                         elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                            } 
                         }  
                         elsif($call_base_offspring eq 'GG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         }                    
                         elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                             if ($tx_confidence_father >  $tx_confidence_mother) {               
                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                            }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                            } 
                         } 
                     }#elsif ($call_base_father eq 'TT')                         
                 }  # fim do case AT, TA;                 
                 case 'CC' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                 }  
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                  
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }         
                             } #if $call_base_father 'AA'
                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante3; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }                  
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante3; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4, $variante12; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2, $variante8; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante1;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante9, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante9, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante10, $variante11; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao21;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao21;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante5; 
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao13, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }                     
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, , $variante6, $variante7;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante3, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 } 
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao13, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'TT')                                  
                 }  # fim do case CC;
                 
                 case ['CG','GC'] {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante1, $variante6;
                                 }elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante2, $variante5; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante10; 
                                 }   
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3,  $strMutacao12, $variante5; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante3; 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante8; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }                    
                             } #if $call_base_father 'AA'
                             
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                 }elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21; 
                                 }  
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante10; 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $variante8;
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante1;
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $variante5; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante8, $variante12;
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante9, , $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante10; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5;
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }
                             }#elsif ($call_base_father eq 'CC')                                 
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3;
                                 }  
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante2; 
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                 }  
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                 } 
                                 elsif($call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                                    } 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante9;
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante9, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante5, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'TT')    
                 }  # fim do case CG, GC;                 
                 case ['CT','TC'] {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante8, $variante12;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3,  $strMutacao12, $variante8, $variante12; 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }                    
                             } #if $call_base_father 'AA'                                 
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante6; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante8; 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1, $variante7;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }  
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2, $variante8; 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1;
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $variante10; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }               
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1,$strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                                 } 
                             }#elsif ($call_base_father eq 'CC')                                 
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2,$strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante1, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante2, $variante5; 
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }               
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }    
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante3; 
                                 }   
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante6, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1,  $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                             }#elsif ($call_base_father eq 'TT')                                     
                 }  # fim do case CT, TC;   
                 case 'GG' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                  
                             } #if $call_base_father 'AA'
                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante4;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante5, $variante10, $variante3; 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                        say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $variante2;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante10, $variante12; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante8, $variante10;
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }    
                                elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                 }
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante5; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }                      
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 } 
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6;
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                     if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }                          
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4;
                                 }  
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 } 
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'TT')                                 
                 }  # fim do case GG;         
                 
                 case ['GT','TG'] {if ($call_base_father eq 'AA') {          
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante6, $variante7;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante4, $variante9;  
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao3,  $strMutacao12, $variante12; 
                                     }   
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                     }                    
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante6, $variante7; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                     }              
                                 } #if $call_base_father 'AA'                                 
                                 elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante6, $variante7;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $variante4; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $variante4, $variante9;  
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante3; 
                                     }                   
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante5, $variante5; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5; 
                                     }
                                 }#elsif ($call_base_father eq 'AC' or 'CA')
                                 elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $variante6;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $variante4; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }  
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                     }
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                     }
                                 }#elsif ($call_base_father eq 'AG' or 'GA')                                 
                                 elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante6, $variante7;
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $variante4, $variante9; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }  
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante8, $variante12; 
                                     } 
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                        } 
                                     } 
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante10; 
                                     }
                                 }#elsif ($call_base_father eq 'AT' or 'TA')
                                 elsif ($call_base_father eq 'CC') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante6, $variante7; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante4, $variante9; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $variante3; 
                                     }                
                                     elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao1, $strMutacao13, $variante5; 
                                     } 
                                 }#elsif ($call_base_father eq 'CC')                                 
                                 elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante6, $variante7; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                                     }    
                                     elsif($call_base_offspring eq 'TT') {
                                         say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5; 
                                     }
                                 }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                                 elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao13, $variante6, $variante7; 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1, $variante7; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                            if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante4; 
                                     }
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                     }
                                 }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                                 elsif ($call_base_father eq 'GG') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                         say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6; 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante4; 
                                     }   
                                     elsif($call_base_offspring eq 'TT') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                     }
                                 }#elsif ($call_base_father eq 'GG')   
                                 elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }
                                     }
                                 }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                                 elsif ($call_base_father eq 'TT') {
                                     if ($call_base_offspring eq 'AA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                        }
                                     }
                                     elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante7; 
                                     }
                                     elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                                        }
                                     }
                                     elsif($call_base_offspring eq 'CC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao13, $strMutacao21;
                                        } 
                                     }
                                     elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao13, $variante9; 
                                     }
                                     elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                        if ($tx_confidence_father >  $tx_confidence_mother) {               
                                                say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                        }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                                say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                        } 
                                     }  
                                     elsif($call_base_offspring eq 'GG') {
                                        say $fh_log $reg, $strMutacao3, $strMutacao12, $variante11; 
                                     }
                                 }#elsif ($call_base_father eq 'TT')                                       
                 }  # fim do case GT, TG;                 
                 case 'TT' {if ($call_base_father eq 'AA') {          
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante12; 
                                 }   
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao11, $variante10; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante8; 
                                 }                      
                             } #if $call_base_father 'AA'                     
                             elsif ($call_base_father eq 'AC' or $call_base_father eq 'CA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }  
                                 }                   
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'AC' or 'CA')
                             elsif ($call_base_father eq 'AG' or $call_base_father eq 'GA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     ay $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante4; 
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }   
                                 elsif($call_base_offspring eq 'TT') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'AG' or 'GA')
                             elsif ($call_base_father eq 'AT' or $call_base_father eq 'TA' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7;
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }    
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                             }#elsif ($call_base_father eq 'AT' or 'TA')
                             elsif ($call_base_father eq 'CC') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                     say $fh_log $reg, $strMutacao1, $strMutacao12, $variante3, $variante11; 
                                 }                    
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante3; 
                                 }    
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao13, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'CC')
                             elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante5, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $variante1; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $variante11; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante5; 
                                 }
                             }#elsif ($call_base_father eq 'CG' or $call_base_father eq 'GC' )  
                             elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao21;
                                    }  
                                 } 
                             }#elsif ($call_base_father eq 'CT' or $call_base_father eq 'TC' )
                             elsif ($call_base_father eq 'GG') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao11, $variante6; 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante9; 
                                 }
                                 elsif($call_base_offspring eq 'GC') {
                                     say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante9; 
                                 }   
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                     say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $variante4; 
                                 } 
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $variante11; 
                                 } 
                                 elsif($call_base_offspring eq 'TT') {
                                    say $fh_log $reg, $strMutacao3, $strMutacao12, $variante2; 
                                 }
                             }#elsif ($call_base_father eq 'GG')   
                             elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante7; 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }  
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao13, $variante9; 
                                 } 
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao12, $strMutacao13, $strMutacao21;
                                    }   
                                 }  
                                 elsif($call_base_offspring eq 'GG') {
                                    say $fh_log $reg, $strMutacao2, $strMutacao12, $variante11; 
                                 }
                             }#elsif ($call_base_father eq 'GT' or $call_base_father eq 'TG' ) 
                             elsif ($call_base_father eq 'TT') {
                                 if ($call_base_offspring eq 'AA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif ($call_base_offspring eq 'AC' or $call_base_offspring eq 'CA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }  
                                 }elsif($call_base_offspring eq 'AG' or $call_base_offspring eq 'GA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'AT' or $call_base_offspring eq 'TA') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao12, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'CG' or $call_base_offspring eq 'GC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao11, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao11, $strMutacao21;
                                    } 
                                 }   
                                 elsif($call_base_offspring eq 'CT' or $call_base_offspring eq 'TC') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao21;
                                    } 
                                 }
                                 elsif($call_base_offspring eq 'GG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao11, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao11, $strMutacao12, $strMutacao21;
                                    } 
                                 }                 
                                 elsif($call_base_offspring eq 'GT' or $call_base_offspring eq 'TG') {
                                    if ($tx_confidence_father >  $tx_confidence_mother) {               
                                            say $fh_log $reg, $strMutacao2, $strMutacao13, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father <  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao3, $strMutacao13, $strMutacao12, $strMutacao21;
                                    }elsif ($tx_confidence_father ==  $tx_confidence_mother) {
                                            say $fh_log $reg, $strMutacao1, $strMutacao13, $strMutacao12, $strMutacao21;
                                    }
                                 }  
                             }#elsif ($call_base_father eq 'TT')                                   
                 }  # fim do case TT;
                 #case '' {say $fh_log $reg, $strMutacao13, $strMutacao14;} # fim do case ''                         
        }  # fim do switch         
   }  # fim do while
	
