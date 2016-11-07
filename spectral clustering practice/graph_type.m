%% creating three kinds of graphs
%% type 1 : epsilon neighborhood graphs
e1 = 4; e2 = 4; e3 = 4;
W1 = A1 < e1;
W2 = A2 < e2;
W3 = A3 < e3;
D1 = diag(sum(W1,2));
D2 = diag(sum(W2,2));
D3 = diag(sum(W3,2));
L1 = D1 - W1;
L2 = D2 - W2;
L3 = D3 - W3;
%% type 2 : mutual k nearest neighbor graphs
k = 2;
W = A;
for i = 1 : size(W,1)
    W(W == 0) = inf;
    [s,id] = sort(W(i,:));
    W(i,:) = 0;
    W(i,id(1:k)) = s(1:k);
end
for i = 1 : size(W,1)
    for j = 1 : i
        if(W(i,j) ~= W(j,i))
            W(i,j) = 0;
            W(j,i) = 0;
        end
    end
end

%% type 3 : gaussian graph
W1 = A1;
W2 = A2;
W3 = A3;
W1(W1 == 0) = inf;
W2(W2 == 0) = inf;
W3(W3 == 0) = inf;
W1 = exp(-W1.^2/5);
W2 = exp(-W2.^2/5);
W3 = exp(-W3.^2/5);
D1 = diag(sum(W1,2));
D2 = diag(sum(W2,2));
D3 = diag(sum(W3,2));
L1 = D1 - W1;
L2 = D2 - W2;
L3 = D3 - W3;