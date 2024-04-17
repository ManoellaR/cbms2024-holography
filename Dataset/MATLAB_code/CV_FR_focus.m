%% Fresnel Transform (Convolution) - This method is useful for near distance transform.
% dx, dy  -> pixel pitch of the object
% z       -> the distance of the Fresnel transform 
% lambda  -> wave length 

% returns the real and imaginary part of a hologram


function [realp, imagp] = CV_FR_focus(object, dx, dy, z, lambda)

    % step parameter and dimensions
    k=2*pi/lambda;
    [Nyy Nxx] = size(object); 

    % fills x and y ranges
    x = ones(Nyy,1)*[-Nxx/2:Nxx/2-1]*dx;    
    y = [-Nyy/2:Nyy/2-1]'*ones(1,Nxx)*dy;  
    
    Lx = dx*Nxx;
    Ly = dy*Nyy;
       
    criti = dx*Lx/lambda;
    
    % hologram sampling window
    dfx = 1./Lx;
    dfy = 1./Ly;
    
    % fills u and v derivatives
    u = ones(Nyy,1)*[-Nxx/2:Nxx/2-1]*dfx;    
    v = [-Nyy/2:Nyy/2-1]'*ones(1,Nxx)*dfy;   
    
    % apply the fast Fourier transform
    O = fft2(fftshift(object));
    
    % impulse response H
    if z<=criti
        H = exp(i*k*z).*exp(-i*pi*lambda*z*(u.^2+v.^2));
        H = fftshift(H);
    end

    % revert impulse response
    o = ifftshift(ifft2(O.*H));
    
    % preparing output
    complex = o;
    du = dx;
    dv = dy; 
    
    d = real(o);
    d = d-min(d(:));
    d = d/max(d(:));
    realp = d;

    d = imag(o);
    d = d-min(d(:));
    d = d/max(d(:));
    imagp = d;    
end
