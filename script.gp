set term wxt enhanced
set samples 1000
unset key

min=36.9
max=39.5

m = -0.283031119979
b = 13.8068736998
A1 = 15.6098159591

x01=37.78
w1=0.05
eta1=0.5

A2=A1/2
x02=37.87
w2=0.03
eta2=0.5


G(x,x0,w)=sqrt( log(2) / pi ) * exp( -log(2)*( (x-x0)/w )**2 ) / w
L(x,x0,w)=1/( pi*w*( 1 + ((x-x0)/w)**2 ) )

f(x)=m*x+b

V(x,x0,w,eta,A)=A*( eta*G(x,x0,w) + (1-eta)*L(x,x0,w) )

#fit [min:max] V(x,x01,w1,eta1,A1)+f(x) 'patt.dat' via x01,w1,eta1,A1,m,b
fit [min:max] V(x,x01,w1,eta1,A1)+V(x,x02,w2,eta2,A2)+f(x) 'patt.dat' via x01,w1,eta1,A1,x02,w2,eta2,A2,m,b

set xrange [min:max]
#plot 'patt.dat', V(x,x0,w,eta,A)+f(x), 'patt.dat' u 1:($2-V($1,x0,w,eta,A)-f($1))
plot 'patt.dat', V(x,x01,w1,eta1,A1)+V(x,x02,w2,eta2,A2)+f(x), 'patt.dat' u 1:($2-V($1,x01,w1,eta1,A1)-V($1,x02,w2,eta2,A2)-f($1))
