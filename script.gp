reset
set term pdf enhanced size 15cm,10cm
set samples 1000
set grid
set xlabel '2{/Symbol q}'
set ylabel 'Intensidade'

set fit quiet #Xiu...

#Gaussiana, Lorentziana e Pseudo-Voigt
G(x,x0,w)=sqrt( log(2) / pi ) * exp( -log(2)*( (x-x0)/w )**2 ) / w
L(x,x0,w)=1/( pi*w*( 1 + ((x-x0)/w)**2 ) )
V(x,x0,w,eta,A)=A*( eta*G(x,x0,w) + (1-eta)*L(x,x0,w) )

do for [i=1:32]{ #O valor i vai do grupo de picos inicial ao final
	load 'guesses/group'.i.'.par'

	if (number_of_peaks==2) {
		F(x)=V(x,x01,w1,eta1,A1)+V(x,x02,w2,eta2,A2)

		fit [min:max] F(x)+b 'patt.dat' via A1,A2,b
		fit [min:max] F(x)+b 'patt.dat' via w1,w2
		fit [min:max] F(x)+b 'patt.dat' via eta1,eta2
		fit [min:max] F(x)+b 'patt.dat' via A1,x01,w1,eta1,A2,x02,w2,eta2,b
	} else {
		if (number_of_peaks==4) {
			F(x)=V(x,x01,w1,eta1,A1)+V(x,x02,w2,eta2,A2)+V(x,x03,w3,eta3,A3)+V(x,x04,w4,eta4,A4)

			fit [min:max] F(x)+b 'patt.dat' via A1,A2,A3,A4,b
			fit [min:max] F(x)+b 'patt.dat' via w1,w2,w3,w4
			fit [min:max] F(x)+b 'patt.dat' via eta1,eta2,eta3,eta4
			fit [min:max] F(x)+b 'patt.dat' via A1,x01,w1,eta1,A2,x02,w2,eta2,A3,x03,w3,eta3,A4,x04,w4,eta4,b
		} else {
			F(x)=V(x,x01,w1,eta1,A1)+V(x,x02,w2,eta2,A2)+V(x,x03,w3,eta3,A3)+V(x,x04,w4,eta4,A4)+V(x,x05,w5,eta5,A5)+V(x,x06,w6,eta6,A6)

			fit [min:max] F(x)+b 'patt.dat' via A1,A2,A3,A4,A5,A6,b
			fit [min:max] F(x)+b 'patt.dat' via eta1,eta2,eta3,eta4,eta5,eta6
			fit [min:max] F(x)+b 'patt.dat' via w1,w2,w3,w4,w5,w6
			fit [min:max] F(x)+b 'patt.dat' via A1,x01,w1,eta1,A2,x02,w2,eta2,A3,x03,w3,eta3,A4,x04,w4,eta4,A5,x05,w5,eta5,A6,x06,w6,eta6,b
		}
	}

	update 'guesses/group'.i.'.par' 'results/group'.i.'_results.par'
	
	set output 'results/group'.i.'.pdf'
	set xrange [min:max]
	plot 'patt.dat' ps .5 title 'Pontos experimentais', F(x)+b title 'Fit', 'patt.dat' u 1:($2-F($1)-b) w lines title 'Erro'
	set o
	
	print "Pico ".i." terminado!"
}
