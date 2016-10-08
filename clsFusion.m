
function fused = clsFusion( color, monochrome, varargin )
  % fused = clsFusion( color, monochrome [, gamma ] )
  %
  % Written by Nicholas Dwork - Copyright 2016
  %
  % This software is offered under the GNU General Public License 3.0.  It
  % is offered without any warranty expressed or implied, including the
  % implied warranties of merchantability or fitness for a particular
  % purpose.


  defaultGamma = 1;
  p = inputParser;
  p.addOptional( 'gamma', defaultGamma );
  p.parse( varargin{:} );
  gamma = p.Results.gamma;

  sColor = size(color);
  nCols = sColor(2);
  nRows = sColor(1);

  sqrtGamma = sqrt(gamma);
  A = [ [ 1 0 0 ]; ...
        [ 0 1 0 ]; ...
        [ 0 0 1 ]; ...
        [ sqrtGamma/3 sqrtGamma/3 sqrtGamma/3 ]; ];
	pinvA = pinv(A);
  bs = [ reshape( color(:,:,1), [1 nCols*nRows] ); ...
         reshape( color(:,:,2), [1 nCols*nRows] ); ...
         reshape( color(:,:,3), [1 nCols*nRows] ); ...
         sqrtGamma * reshape( monochrome(:), [1 nCols*nRows] ); ];
  fs = pinvA * bs;

  fused = zeros( sColor );
  fused(:,:,1) = reshape( fs(1,:), [nRows nCols] );
  fused(:,:,2) = reshape( fs(2,:), [nRows nCols] );
  fused(:,:,3) = reshape( fs(3,:), [nRows nCols] );

  aThird = 1/3;
  maxFused = repmat( max( fused, [], 3 ), [1 1 3] );
  minFused = repmat( min( fused, [], 3), [1 1 3] );

  lambda = 3 * (1-fused);
  minLambda = repmat( min( lambda, [], 3 ), [1 1 3] );  
  fused( maxFused > 1 ) = fused( maxFused > 1 ) + ...
    aThird * minLambda( maxFused > 1 );

  lambda = 3 * (-fused);
  maxLambda = repmat( max( lambda, [], 3), [1 1 3] );
  fused( minFused < 0 ) = fused( minFused < 0 ) + ...
    aThird * maxLambda( minFused < 0 );
end

