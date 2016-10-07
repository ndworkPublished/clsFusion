
function [colorImg,monochromeImg] = loadData( dataDir, datacase )

  switch datacase
    case 1
      colorImg = imread([dataDir,'/mrFlowVelocity.png']);
      monochromeImg = imread([dataDir,'mrFlowAnatomy.png']);
      colorImg = double( colorImg(:,1:320,:) ) / 255.;
      monochromeImg = double( rgb2gray( monochromeImg ) ) / 255.;

    case 2
      colorImg = imread([dataDir,'/tissueCancerBLC.png']);
      monochromeImg = imread([dataDir,'/tissueCancerWLC.png']);
      colorImg = double( colorImg ) / 255.;
      monochromeImg = double( monochromeImg ) / 255.;
  end

end

