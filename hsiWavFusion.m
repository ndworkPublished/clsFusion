
function fused = hsiWavFusion( cImg, mImg )

  split = [1 0; 0 0;];
  %split = zeros(32);  split(1,1)=1;

  sImg = size( cImg );
  cVec = zeros( 3, prod( sImg(1:2) ) );
  cVec(1,:) = reshape( cImg(:,:,1), [1 prod( sImg(1:2) )] );
  cVec(2,:) = reshape( cImg(:,:,2), [1 prod( sImg(1:2) )] );
  cVec(3,:) = reshape( cImg(:,:,3), [1 prod( sImg(1:2) )] );

  M = [ 1/sqrt(3) 1/sqrt(3) 1/sqrt(3); ...
        1/sqrt(6) 1/sqrt(6) -2/sqrt(6); ...
        1/sqrt(2) -1/sqrt(2) 0; ];
	Mc = M*cVec;

  L = reshape( Mc(1,:), sImg(1:2) );

  wtMono = wtHaar2( mImg, split );
  wtL = wtHaar2( L, split );

  activityMono = abs(wtMono);
  activityL = abs(wtL);
  wtFused = wtL;
  wtFused( activityMono > activityL ) = wtMono( activityMono > activityL );

  fusedL = iwtHaar2( wtFused, split );

  fVecHSI = Mc;
  fVecHSI(1,:) = fusedL(:);
  fusedVec = M \ fVecHSI;
  fused = zeros( sImg );
  fused(:,:,1) = reshape( fusedVec(1,:), sImg(1:2) );
  fused(:,:,2) = reshape( fusedVec(2,:), sImg(1:2) );
  fused(:,:,3) = reshape( fusedVec(3,:), sImg(1:2) );
  
  fused = min( max( fused, 0 ), 1 );
end

