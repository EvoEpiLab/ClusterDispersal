%==========================================================================
% Function: Assembly
% Simulates the assembly of a microbial community via replication and dispersal
% Created by Loïc Marrec
%==========================================================================

function [NAlist, NBlist] = Assembly(Nrep, rA, rB, pA, N0A, N0B, K, c, n)

    % Preallocate result matrices
    NAlist = zeros(1, Nrep);
    NBlist = zeros(1, Nrep);

    for i = 1 : Nrep

        %% Initialization
        NA = N0A;  % Initial number of A microbes
        NB = N0B;  % Initial number of B microbes

        %% Community assembly
        while (NA + NB) < K

            % Compute event rates
            TdivA = rA * (1 - (NA + NB) / K) * NA;    % Replication of A
            TdivB = rB * (1 - (NA + NB) / K) * NB;    % Replication of B
            Tmig  = c  * (1 - (NA + NB) / K);         % Cluster dispersal

            % Total rate
            T = TdivA + TdivB + Tmig;

            % Determine event
            rnd = rand;

            % Replication of A
            if rnd <= TdivA / T
                NA = NA + 1;

            % Replication of B
            elseif rnd <= (TdivA + TdivB) / T
                NB = NB + 1;

            % Cluster dispersal
            else
                % Sample cluster composition
                nA = binornd(n, pA);
                nB = n - nA;

                NA = NA + nA;
                NB = NB + nB;
            end

        end

        %% Save final population sizes
        NAlist(i) = NA;
        NBlist(i) = NB;

    end

end
