function [CODE,s] = huffman(p)
%HUFFMAN Builds a variable-length Huffman code for a symbol source.
%   CODE = HUFFMAN(P) returns a Huffman code as binary strings in
%   cell array CODE for input symbol probability vector P. Each word
%   in CODE corresponds to a symbol whose probability is at the
%   corresponding index of P.

% Global variable surviving all recursions of function 'makecode'
global CODE
CODE = cell(length(p), 1);  % Init the global cell array
                           
if length(p) > 1            % When more than one symbol ...
   s = reduce(p);           % Do Huffman source symbol reductions
   makecode(s, []);         % Recursively generate the code
else 
   CODE = {'1'};            % Else, trivial one symbol case!
end;  

function s = reduce(p)
% Create a Huffman source reduction tree in a MATLAB cell structure
% by performing source symbol reductions until there are only two
% reduced symbols remaining

s = cell(length(p), 1);

% Generate a starting tree with symbol nodes 1, 2, 3, ... to
% reference the symbol probabilities.
for i = 1:length(p)
   s{i} = i;
end

while numel(s) > 2
   [p, i] = sort(p);    % Sort the symbol probabilities
   p(2) = p(1) + p(2);  % Merge the 2 lowest probabilities
   p(1) = [];           % and prune the lowest one
  
   s = s(i);            % Reorder tree for new probabilities
   s{2} = {s{1}, s{2}}; % and merge & prune its nodes
   s(1) = [];           % to match the probabilities
end

function makecode(sc, codeword)
% Scan the nodes of a Huffman source reduction tree recursively to
% generate the indicated variable length code words.

% Global variable surviving all recursive calls
global CODE                          

if isa(sc, 'cell')                   % For cell array nodes,
   makecode(sc{1}, [codeword 0]);    % add a 0 if the 1st element
   makecode(sc{2}, [codeword 1]);    % or a 1 if the 2nd
else                                 % For leaf (numeric) nodes,
   CODE{sc} = char('0' + codeword);  % create a char code string
end
