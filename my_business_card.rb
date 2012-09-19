#!/usr/bin/env ruby
# http://github.com/ErikSchlyter/my_business_card.git
# A script that generates the SVG that is my personal
# business card, complete with info, logo, QR and its
# own source code on the back. Self replication ftw!
require 'rubygems'; require 'rqrcode'; require 'cgi'
t="<?xml version='1.0' standalone='yes'?>
<svg xmlns='http://www.w3.org/2000/svg' version='1.2'
style='font-family:Georgia;font-size:27px;font-weight:100;
'><rect width='1039' height='1394' style='fill:#F8F0E8;'/>
<g style='fill:none;stroke:#D8D0C8; stroke-width:14px;
stroke-linejoin:round;stroke-linecap:round;'>q</g>QS
<g style='font-family:Liberation Mono;font-size:24px;
font-weight:700;'>W</g><g style='font-family:monospace;
font-size:17px' transform='translate(0 1394)
rotate(-90 0 0)'>|</g></svg>"
$i=0;$s='----X+FA[F+EEEX]FAF[+X]A';
$a={'A'=>'-B[FD]++B-','B'=>'-C[FX[GX]--X]GC-','C'=>'-C'<<
   '++C-','D'=>'E[GE]--E','E'=>'XX','F'=>'GG','G'=>'++'};
$a2={'\''=>'"','S'=>''};$m={'+'=>"a+=d",'-'=>"a-=d",'['=>
  "$i+=1;su<<=c(x,y,a,d)", ']'=>"return svg<<'\"/>'<<su",
  'g'=>"x+=Math.cos(a)*22;y+=Math.sin(a)*22;svg<<\""<<
  "L\#{x.to_int} \#{y.to_int}\""};
q=RQRCode::QRCode.new('www.erisc.se',:size=>1,:level=>:m)
q.modules.each_index{|x|q.modules.each_index{|y|$a2['S']<<
"<rect stroke=\"none\" x=\"#{x*5+868}\" y=\"#{y*5+173}\"
width=\"6\" height=\"6\"/>" if q.dark?(y,x)}}
def c(x,y,a,d) svg="<path d=\"M#{x.to_int} #{y.to_int}";
  su=''; while $i<$s.size; eval $m[$s[$i]]||$m['g'];$i+=1;
end; eval $m[']']; end
def e(s,m) r=''; s.each_char{|c|r<<(m[c]||c)}; r; end
def t2(a)"<text x='#{a.pop}' y='#{a.pop}'"<<
  "#{a.pop}>#{a.pop}</text>" end
def te(x,y,z,d) r=''; z.each{|q|r<<t2([q,'',y,x]);y+=d};
  r end; 4.times{$s=e($s,$a);}
$a2['q']=c(440.0, 385.0, -Math::PI/2, Math::PI/6);
$a2['Q']=te(60,80,['Software Developer','Independent '<<
'Consultant','Process Analyst &amp; Strategist'],45)<<
t2(['Erik Schlyter'," style='font-size:125px;"<<
"letter-spacing:2px'",605,57])<<t2(['M.Sc. Computing '<<
'Science and Engineering'," style='fill:#876;'",637,
60])<<t2(["Link\u00F6ping Sweden"," style='fill:#876;'",
637,615]);$a2['W']=t2(['+46(0)70 65 63 892','',80,725])<<
t2(['erik@erisc.se','',115,795])<<t2(['www.erisc.se','',
  150,809]);$a2['|']=te(51,80,CGI::escapeHTML(
  open($0).read).split("\n"),20); puts e(t,$a2)
