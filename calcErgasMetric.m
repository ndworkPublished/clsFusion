
function ergas = calcErgasMetric( color, monochrome, fused, varargin )

  defaultH = 1;
  defaultL = 1;
  p = inputParser;
  p.addParameter( 'h', defaultH );
  p.addParameter( 'l', defaultL );
  p.parse( varargin{:} );
  h = p.Results.h;
  l = p.Results.l;

  sImg = size( fused );
  nPix = sImg(1)*sImg(2);
  redMSE = norm( color(:,:,1) - fused(:,:,1), 2 ) / nPix;
  greenMSE = norm( color(:,:,2) - fused(:,:,2), 2 ) / nPix;
  blueMSE = norm( color(:,:,3) - fused(:,:,3), 2 ) / nPix;
  monMSE = norm( monochrome - mean(fused,3), 2 ) / nPix;

  tmpRed = color(:,:,1);    meanRed = mean( tmpRed(:) );
  tmpGreen = color(:,:,2);  meanGreen = mean( tmpGreen(:) );
  tmpBlue = color(:,:,3);   meanBlue = mean( tmpBlue(:) );
  meanMon = mean( monochrome(:) );

  ergas = 100*h/l * sqrt( 0.25 * ( ...
    (redMSE/meanRed)^2 + (greenMSE/meanGreen)^2 + (blueMSE/meanBlue)^2 + ...
    (monMSE/meanMon)^2 ) );

end
