FUNCTION NORM_SPEC,flux_array
;+
; NAME
;	NORM_SPEC
; PURPOSE
;	Normalise spectra by finding the median of the 50 outer flux
;	values in the flux array, fitting a straight line through
;	these 2 points and then dividing the flux array by the
;	straight line fit. 
;
; CALLING SEQUENCE:  
; 	norm_flux_array = NORM_SPEC(flux_array)
;
; OUTPUTS 
; 	Normalised flux of flux_array
; REVISION HISTORY:
;	G. M. Seabroke 1/8/11
;-

;Return to the caller of the program unit that called ON_ERROR and stop.
ON_ERROR,2

;n=size of array
n=n_elements(flux_array)
n=long(n)
;blue points to fit
x1=double(25)
;red points to fit
x2=double(n-1-25)

;median is an internal IDL function
;calculate median flux from 1st 51 elements of array (needs to be odd number)
y1=double(median(flux_array[0:50]))
;calculate median flux from last 51 elements of array (needs to be odd number)
y2=double(median(flux_array[(n-1-50):(n-1)]))

;intercept is 1st element in flux_array
a=flux_array[0]

;gradient
b=(y2-y1)/(x2-x1)

print,'A = ',a,', B = ',b

;set up array to put fitted straight line flux in
linfit_flux=dblarr(n)
;calculate fitted straight line flux for each element of new array
for i = 0l,n-1l do begin
   linfit_flux[i]= a + (b*i)
endfor

;normalised flux array=flux array divided by fitted straight line flux array
norm_flux_array=flux_array/linfit_flux
return,norm_flux_array

END
