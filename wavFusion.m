
function fused = wavFusion( cImg, mImg )
  % fused = wavFusion( cImg, mImg )
  %
  % Inputs:
  % cImg - color image
  % mImg - monochrome image
  %
  % Written by Nicholas Dwork - Copyright 2016
  %
  % This software is offered under the GNU General Public License 3.0.  It
  % is offered without any warranty expressed or implied, including the
  % implied warranties of merchantability or fitness for a particular
  % purpose.

  split = [1 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0;];

  sImg = size( cImg );
  wtColor = zeros( sImg );
  for i=1:sImg(3)
    wtColor(:,:,i) = wtHaar2( cImg(:,:,i), split );
  end

  wtMono = wtHaar2( mImg, split );
  wtFused = repmat(wtMono, [1 1 3]);

  fused = zeros( sImg );
  activityMono = abs(wtMono);
  activityColor = abs(wtColor);
  for i=1:sImg(3)
    wtFused = wtColor(:,:,i);
    wtFused( activityMono > activityColor(:,:,i) ) = ...
      wtMono( activityMono > activityColor(:,:,i) );
    fused(:,:,i) = iwtHaar2( wtFused, split );
  end

  fused = min( max( fused, 0 ), 1 );
end
