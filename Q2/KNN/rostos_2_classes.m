tic
clc
clear all
close all


%Simulações
simu=30;
Acuracia=0;


for itm=1:simu

        %Teste KNN
        %Inicialização
        k=31;
        n=0;
        m=0;
        p=0;
        q=0;

        Classe_1=zeros(2,3);
        Classe_2=zeros(2,4);
        Classe_3=zeros(2,4);
        Classe_4=zeros(2,4);

        %Quantidade de dados
        quant_training=240;
        quant_teste=160;
        total=400;

        load('sujeitos.mat')


        sorteio=randperm(total);

        for passo_tr=1:quant_training

            %Dados Treinamento em MATRIZ
            d_training(passo_tr,:)=sujeitos(sorteio(1,passo_tr),:);

        end

        %Dados Treinamento
        Teta_training= d_training(:,4097);


        sorteio_2= sorteio(1,(quant_training+1):end);

        for passo_t=1:quant_teste

            %Dados Treinamento em MATRIZ
            d_test(passo_t,:)=sujeitos(sorteio_2(1,passo_t),:);

        end


        %Dados Treinamento
        Teta_t=d_test(:,4097);


        %Contadores de acerto e erro
        acerto=0;
        erro=0;
        resultado=zeros(quant_teste,1);

        for iy=1:quant_teste

            for ix=1:quant_training

                d(:,ix)=norm(d_test(iy,:)-d_training(ix,:));

            end

        cont=zeros(1,40);   

        [l,c]=sort(d);

            for ik=1:k

                a = Teta_training(c(1,ik),1);

                for it_c=1:40

                    if a==it_c

                        cont(1,it_c)=cont(1,it_c)+1;


                    end
                end

            end


                %Quantidade de acertos
                [~,b]=max(cont);
                
                resultado_knn(iy,1)=b;

                if b==Teta_t(iy,1)

                    acerto=acerto+1;

                else 

                    erro=erro+1;        

                end

                resultado(iy,1)=b;

                X = ['Classificação do Sujeito: ',num2str(b)];
                disp(X);



        end


        %Acurácia
        Ac=(acerto/quant_teste)*100;
        X = ['Acurácia: ',num2str(Ac),'%'];
        disp(X);    
        
        
        %somatória das acurácias
        Acuracia=Acuracia+Ac;
        
        Ac_all(1,itm)=Ac;
        
        %Tempo de 1 simulação
        if itm==1
           time=toc;  
        end

end

    
Media=Acuracia/simu;
M = ['Média das Acurácias: ',num2str(Media),'%'];
disp(M);

desvio_M_Ac=std(Ac_all);


M_confusao=confusionmat(Teta_t,resultado_knn);

% figure(1)
% imshow(M_confusao);
% 
% figure(2)
% imshow(imresize((M_confusao./max(max(M_confusao))),8,'nearest'));

Resultados=[Media;desvio_M_Ac;time];



    
    
 