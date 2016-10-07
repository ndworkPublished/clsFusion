
function hsi = rgb2hsi( rgb )

  sImg = size( rgb );

  cVec = zeros( 3, prod( sImg(1:2) ) );
  cVec(1,:) = reshape( cImg(:,:,1), [1 prod( sImg(1:2) )] );
  cVec(2,:) = reshape( cImg(:,:,2), [1 prod( sImg(1:2) )] );
  cVec(3,:) = reshape( cImg(:,:,3), [1 prod( sImg(1:2) )] );

  M = [ 1/sqrt(3) 1/sqrt(3) 1/sqrt(3); ...
        1/sqrt(6) 1/sqrt(6) -2/sqrt(6); ...
        1/sqrt(2) -1/sqrt(2) 0; ];
	Mc = M*cVec;

  hsi(:,:,1) = reshape( atan( Mc(3,:) ./ Mc(2,:) ), sImg(1:2) );
  hsi(:,:,2) = reshape( sqrt( Mc(2,:).^2 + Mc(3,:).^2 ), sImg(1:2) );
  hsi(:,:,3) = reshape( Mc(1,:), sImg(1:2) );
end

