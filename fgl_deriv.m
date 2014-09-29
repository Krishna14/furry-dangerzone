function Y = fgl_deriv(p, y, h)
%fgl_deriv

%Computes the fractional derivative of order alpha (a) 
%for the function y sampled on a regular grid with 
%spacing h, using the GL Formulation

%Inputs
%p = Fractional Order (Only for this case)
%y = sampled function
%h = period of the sampling lattice

%Output:
%Y = fractional derivative estimate given y

%Author - R R Sreekrishna
%Orgainzation - BITS PILANI
    n  = numel(y);
    J  = 0:(n-1);
    G1 = gamma( J+1 );
    G2 = gamma( p+1-J );
    s  = (-1) .^ J;

    M  = tril( ones(n) );
    R  = toeplitz( y(:)' );
    T  = meshgrid( (gamma(p+1)/(h^p)) * s ./ (G1.*G2) );
    Y  = reshape(sum( R .* M .* T, 2 ), size(y));
   
    
end

