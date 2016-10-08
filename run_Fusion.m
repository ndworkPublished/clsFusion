% Written by Nicholas Dwork - Copyright 2016
%
% This software is offered under the GNU General Public License 3.0.  It
% is offered without any warranty expressed or implied, including the
% implied warranties of merchantability or fitness for a particular
% purpose.


function run_Fusion
  close all; clear; rng(1);
  addpath( genpath('.') );

  dataDir = './data/';
  datacase = 1;
  gamma = 5;

  [colorImg,monochromeImg] = loadData( dataDir, datacase );

  tic
  fused = alphaBlend( colorImg, monochromeImg );
  %fused = hsiFusion( colorImg, monochromeImg );
  %fused = wavFusion( colorImg, monochromeImg );
  %fused = hsiWavFusion( colorImg, monochromeImg );
  %fused = clsFusion( colorImg, monochromeImg, 'gamma', gamma );
  timeTaken = toc;
  disp(['Time taken: ', num2str(timeTaken), ' (s)']);

  ergas = calcErgasMetric( colorImg, monochromeImg, fused );
  disp(['ERGAS metric: ', num2str(ergas)]);
  disp([ 'Image size: ', num2str(size(monochromeImg)) ]);

  sizeScale = 2;
  figure; imshow( imresize(uint8(monochromeImg*255), sizeScale, 'nearest') );
  title('monochrome')
  figure; imshow( imresize(uint8(colorImg*255), sizeScale, 'nearest') );
  title('color')
  figure; imshow( imresize(uint8(fused*255), sizeScale, 'nearest') );
  title('fused')

end

