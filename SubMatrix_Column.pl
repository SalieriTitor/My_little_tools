if(!@ARGV){
	print "to get the matrix by column\n";
	print "Usage: perl script list matrix >output\n";
	die;
}
open(TRAIT,$ARGV[0]);
while(<TRAIT>){
	chomp;
	@a=split(/\t/);
	if ($a[0] ne ""){
		$list{$a[0]} = $a[0];
	}
}
open(MATRIX,$ARGV[1]);
$header=<MATRIX>;
chomp $header;
@a=split(/\t/,$header);
print "$a[0]";
for ($i=1;$i<@a;$i++){
	if(defined($list{$a[$i]})){
		$col{$i} = $i;
		print "\t$a[$i]";
	}
}
print "\n";
while(<MATRIX>){
	chomp;
	@a=split(/\t/);
	print "$a[0]";
	for ($i=1;$i<@a;$i++){
		if(defined($col{$i})){
			print "\t$a[$i]";
		}
	}
	print "\n";
}
