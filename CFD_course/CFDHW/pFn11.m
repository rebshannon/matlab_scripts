function p = pFn11(p,b,Nx,Ny,dx,dy)
    maxErr = 1;
    np = 0;
    pCorr = p;
% pressure corrector loop
    while maxErr > 1e-5
        % pCorr = current pressure correction
        % pCorrPrev = last iteration pressure correction
        % loop while the max difference is greater than 1e-5
        pCorrPrev = pCorr;
    
        % Dirichlet BC on left and right
         pCorr(1,:) = 0;
         pCorr(end,:) = 0;
    
        for i = 2:Nx-1
            for j = 2:Ny-1
    
                pCorr(i,j) = (dy^2*(pCorr(i+1,j) + pCorr(i-1,j)) + ...
                    dx^2*(pCorr(i,j+1) + pCorr(i,j-1))) / (2*(dx^2+dy^2))...
                    - dx^2*dy^2 / (2*(dx^2+dy^2)) * b(i,j); 
                    % focing function for step 10, comment out for laplace
            end
        end

%         % Periodic BC
%         i = 1;
%         for j = 2:Ny-1
%                 pCorr(i,j) = (dy^2*(pCorr(i+1,j) + pCorr(end-1,j)) + ...
%                     dx^2*(pCorr(i,j+1) + pCorr(i,j-1))) / (2*(dx^2+dy^2))...
%                     - dx^2*dy^2 / (2*(dx^2+dy^2)) * b(i,j); 
%         end
% 
%         pCorr(end,:) = pCorr(1,:);

        % Neumann BC at top and bottom
        pCorr(:,1) = pCorr(:,2);    
        pCorr(:,end) = pCorr(:,end-1); 
        

        % error function to determine the stop condition
        % convergence when there's less than 1e-5 difference
            % between timesteps
        maxErr = max(abs(pCorr - pCorrPrev),[],'all');
        np = np + 1;
    end

    
    p(:,:) = pCorr;

    end