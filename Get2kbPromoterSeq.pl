#usage : perl Get2kbPromoterSeq.pl genomeSeq.fa geneBedFile >output.fa
#format of geneBedFile : chr  start end geneId  someInfo  strand
#written by Barrel Titor, 2022.2.7
#primary ver, ver 0.330215
open (FASTA,$ARGV[0]);
$header = <FASTA>;
chomp $header;
$header =~ />(.*) dna/;      #should be changed according to the genomeSeq fasta ID.
$seqname = $1;
while(<FASTA>){
  chomp;
  if($_=~/>(.*) dna/){       #should be changed according to the genomeSeq fasta ID.
    $seqname = $1;
  }else{
    $seq{$seqname} .= $_;
  }
}
my %promoter;
open(BED,$ARGV[1]);
while(<BED>){
  chomp;
  @a = split(/\t/,$_);
  if ($a[5] eq '+'){
    $start = $a[1]-2000;
    $promoter{$a[3]} = substr($seq{$a[0]},$start,2000);
  }elsif($a[5] eq '-'){
    $start = $a[2];
    $promoter{$a[3]} = substr($seq{$a[0]},$start,2000);
    $promoter{$a[3]} = reverse($promoter{$a[3]});
    $promoter{$a[3]} =~ s/ATGC/TACG/g;
  }
}
for $keys(sort keys %promoter){
  print ">$keys\n$promoter{$keys}\n";
}
