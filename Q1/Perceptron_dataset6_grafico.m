tic;
close all
clear all
clc


%Quantidade de dados
quant_tr=65;
quant_teste=35;
total=100;
epoca=5;
simu=30;
passo=0.1;

load('dataset6.txt')
dataset6=dataset6(1:100,:);


for it_simu=1:simu

        %TREINAMENTO

        sorteio=randperm(total);

            for passo_tr=1:quant_tr

                %Dados Treinamento em MATRIZ
                d_tr(passo_tr,:)=dataset6(sorteio(1,passo_tr),:);

            end

        %Saída desejada
        y_desejado_tr=d_tr(:,3)';
        %Entradas
        x_tr=[-1*ones(1,quant_tr);d_tr(:,1)';d_tr(:,2)'];
        %Épocas e contador converg^necia
        q_epoca_tr=0;
        conv=0;
        %Vetor de classificação
        y_result_tr=zeros(1,quant_tr);
        %Inicialização pesos
        w=random('unif',-0.5,0.5,3,1);


        for ep=1:epoca


                    for it=1:quant_tr

                            conv=conv+1;

                            u=w'*x_tr(:,it);

                            if u<0

                                y_result_tr(1,it)=1;
                                y_result_tr(2,it)=x_tr(2,it);
                                y_result_tr(3,it)=x_tr(3,it);


                            else

                                y_result_tr(1,it)=2;
                                y_result_tr(2,it)=x_tr(2,it);
                                y_result_tr(3,it)=x_tr(3,it);

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
                d_teste(passo_t,:)=dataset6(sorteio_2(1,passo_t),:);

            end

        %Saída desejada
        y_desejado_teste=d_teste(:,3)';
        %Entradas
        x_teste=[-1*ones(1,quant_teste);d_teste(:,1)';d_teste(:,2)'];
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
                                y_result_teste(2,it)=x_teste(2,it);
                                y_result_teste(3,it)=x_teste(3,it);

                            else

                                y_result_teste(1,it)=2;
                                y_result_teste(2,it)=x_teste(2,it);
                                y_result_teste(3,it)=x_teste(3,it);

                            end


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
desvio=std(Ac_total);

tempo=toc;

Ac_all=[Ac_media;desvio;Ac_max;Ac_min;tempo/simu];    

%GRAFICO
for itf=1:quant_tr
    figure(1)
    if y_result_tr(1,itf)==1
    scatter(y_result_tr(2,itf),y_result_tr(3,itf),'.','red');    
    hold on
    else 
    scatter(y_result_tr(2,itf),y_result_tr(3,itf),'.','blue');
    hold on
    end

end


for itf=1:quant_teste

    if y_result_teste(1,itf)==1

    scatter(y_result_teste(2,itf),y_result_teste(3,itf),'^','red');
    hold on
    else    
    scatter(y_result_teste(2,itf),y_result_teste(3,itf),'o','blue');
    hold on
    end
end

%Fronteira
x_F=[-6:6];
Fron=(-w(2,1)*x_F+w(1,1))/w(3,1);

plot(x_F,Fron,'--black','LineWidth',2)
xlabel('x_1','FontSize',14)
ylabel('x_2','FontSize',14)
            