#!/usr/bin/perl
use strict;
use warnings;
use Spreadsheet::XLSX;

my $syntax          = "Syntax: $0 <input.xlsx> [<output.csv>]\n";
my $input_file      = shift or die($syntax);
my $output_file     = shift;
my $excel           = Spreadsheet::XLSX->new($input_file);
my $worksheets_aref = $excel->{Worksheet};
my $loop            = 0;

foreach my $sheet (@$worksheets_aref) {
  $loop++;
  my $min_row    = $sheet->{MinRow} ;
  my $max_row    = $sheet->{MaxRow} || $min_row;
  my $sheet_name = $sheet->{Name} || "Sheet-$loop";
  printf "Sheet: %s, Rows: %s to %s\n", $sheet_name, $min_row, $max_row;
  my $sheet_file = $output_file || "$sheet_name.csv";
  open my $fh, '>', $sheet_file or die qq{Error: Could not open "$sheet_file": $!};

  foreach my $row ($min_row .. $max_row) {
    my $min_col = $sheet->{MinCol};
    my $max_col = $sheet->{MaxCol} || $min_col;
    my @row_data;
    foreach my $col ($min_col .. $max_col) {
      my $cell = $sheet->{Cells}[$row][$col];
      push @row_data, $cell ? $cell->{Val} : '';
    }
    print $fh join(',', map { s/"/""/g; m/,/ ? qq/"$_"/ : $_ } @row_data), "\n";
  }
  close $fh;
  print "Successfully converted $input_file to $sheet_file\n";
  last if $output_file;
}
