
function out = alphaBlend( colorImg, monochromeImg, alpha )

  if nargin < 3
    alpha = 0.5;
  end

  out = alpha * colorImg + (1-alpha) * repmat(monochromeImg,[1 1 3]);
end