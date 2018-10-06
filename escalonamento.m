function [R] = escalonamento(m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Escalonamento %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = size(m); %tamanho da matriz s(1): linha, s(2): coluna
for c = 1:s(2)-2
    i=c;
    
    %%%%%%%%%%%%%%%%%%%%% buscando a linha pivô %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(m(i,c)==0) % se o elemento da linha pivô for 0, procura uma linha para troca
        disp(m);
        for i = i+1:s(1)
            if(m(i,c)~=0) %troca de linhas
                temp = m(c,:);
                m(c,:) = m(i,:);
                m(i,:) = temp;
                break;
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%% Operando linhas %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    i=c+1;
    if(m(i,c)~=0) %se o elemento da linha pivô for diferente de zero, realiza escalonamento
        for i = i:s(1)
            if(m(i,c)==0) %se o elemento já for zero, pula a iteração
                continue;
            end
            mp = m(i,c)/m(c,c);
            m(i,:) = m(i,:)-(m(c,:)*(mp)); %operando as linhas linha (atual - (linha pivo * multiplicador))
        end    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculando coeficientes %%%%%%%%%%%%%%%%%%%%%%%

v = zeros((s(2)-1)); %vetor para guardar os resultados
n = s(2); %quantidade de elementos

for i = n-1:-1:1 %alterna as linhas buscados o resultados das expressões por linha 
    temp = 0; %variavel acumuladora
    for j = n-1 :-1:(i+1) %multiplica os coeficientes 
        temp = temp + v(j)*m(i,j);
    end
    v(i) = ((m(i,n)-temp)/m(i,i)); %resultado
end

disp('Matriz escalonada: ');
disp(m);
v = v';
R = v(1,:);