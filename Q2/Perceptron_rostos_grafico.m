tic;
close all
clear all
clc


%Quantidade de dados
quant_tr=260;
quant_teste=140;
total=400;
epoca=10;
simu=30;
passo=1;

load('sujeitos.mat')


for it_simu=1:simu

        %TREINAMENTO

        sorteio=randperm(total);

            for passo_tr=1:quant_tr

                %Dados Treinamento em MATRIZ
                d_tr(passo_tr,:)=sujeitos(sorteio(1,passo_tr),:);

            end

        %Saída desejada
        y_desejado_tr=d_tr(:,4097)';
        %Entradas
        x_tr=[-1*ones(1,quant_tr);d_tr(:,1:4096)'];
        %Épocas e contador converg^necia
        q_epoca_tr=0;
        conv=0;
        %Vetor de classificação
        y_result_tr=zeros(1,quant_tr);
        %Inicialização pesos
        w=random('unif',-0.5,0.5,4097,1);


        for ep=1:epoca


                    for it=1:quant_tr

                            conv=conv+1;

                            u=w'*x_tr(:,it);

                            if u<0

                                y_result_tr(1,it)=1;                             


                            else

                                y_result_tr(1,it)=2;                                

                            end

                                %Erro
                                e=y_desejado_tr(1,it)-y_result_tr(1,it);  

                                %Atualização da matriz de pesos w
                                w=w+passo*e*x_tr(:,it)

                                %Análise Convergência
                                W_Conver(:,conv)=w;


                    end


            q_epoca_tr=q_epoca_tr+1;

            if y_result_tr(1,:)==y_desejado_tr(1,:)

                break
            end  


        end  



        %TESTE

        sorteio_2= sorteio(1,(quant_tr+1):end);

            for passo_t=1:quant_teste

                %Dados Treinamento em MATRIZ
                d_teste(passo_t,:)=sujeitos(sorteio_2(1,passo_t),:);

            end

        %Saída desejada
        y_desejado_teste=d_teste(:,4097)';
        %Entradas
        x_teste=[-1*ones(1,quant_teste);d_teste(:,1:4096)'];
        %Épocas 
        q_epoca_teste=0;
        %Vetor de classificação
        y_result_teste=zeros(1,quant_teste);


        for ep=1:epoca


                    for it=1:quant_teste

                            conv=conv+1;

                            u=w'*x_teste(:,it);

                            if u<0

                                y_result_teste(1,it)=1;                                

                            else

                                y_result_teste(1,it)=2;                                

                            end

                                %Erro
                                e=y_desejado_teste(1,it)-y_result_teste(1,it);  

                                %Atualização da matriz de pesos w
                                w=w+passo*e*x_teste(:,it)

                                %Análise Convergência
                                W_Conver(:,conv)=w;


                    end


            q_epoca_teste=q_epoca_teste+1;

            if y_result_teste(1,:)==y_desejado_teste(1,:)

                break
            end  


        end  


        %ANALISE ACURÁCIA
        acerto=0;
        erro=0;

        for it_Ac=1:quant_teste

            if y_result_teste(1,it_Ac)==y_desejado_teste(1,it_Ac)

                acerto=acerto+1;

            else

                erro=erro+1;
            end

        end

        Acuracia=(acerto/quant_teste)*100;
        Ac_total(:,it_simu)=Acuracia;
        

end

%ACURACIA MEDIA
Ac_media=sum(Ac_total,2)/simu;
Ac_max=max(Ac_total);
Ac_min=min(Ac_total);

tempo=toc;

Ac_all=[Ac_media;Ac_max;Ac_min;tempo/simu];

M_confusao=confusionmat(y_desejado_teste,y_result_teste);

figure(1)
imshow(M_confusao);

figure(2)
imshow(imresize((M_confusao./max(max(M_confusao))),8,'nearest'));

           