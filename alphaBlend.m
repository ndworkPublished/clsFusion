
function out = alphaBlend( colorImg, monochromeImg, alpha )
  % out = alphaBlend( colorImg, monochromeImg, alpha )
  %
  % Written by Nicholas Dwork - Copyright 2016
  %
  % This software is offered under the GNU General Public License 3.0.  It
  % is offered without any warranty expressed or implied, including the
  % implied warranties of merchantability or fitness for a particular
  % purpose.

  if nargin < 3
    alpha = 0.5;
  end

  out = alpha * colorImg + (1-alpha) * repmat(monochromeImg,[1 1 3]);
end