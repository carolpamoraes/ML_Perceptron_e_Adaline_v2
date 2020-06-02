close all
clear all
clc

%Epocas
epoca=200000;
%Inicialização pesos
w=random('unif',-0.5,0.5,2,1);
p=0;


%Quantidade de dados
q_tr=125;
q_teste=125;
total=250;

sorteio=randperm(total);

load('dataset_regre.mat');

%Mistura dos dados

for id=1:total

    dataset_mix(id,:)=dataset_regre(sorteio(1,id),:);

end


for passo=[10^-6]
    
        
    %TREINAMENTO
    x_tr=[ones(1,q_tr);dataset_mix(1:q_tr,2)'];
    y_d_tr=dataset_regre(1:q_tr,1);
    
    conv=0;
    erro=0;

    for ep=1:epoca

            for it=1:q_tr

                conv=conv+1;

                y_tr=w'*x_tr(:,it);

                y_resultado_tr(it,:)=y_tr;

                erro=y_d_tr(it,:)-y_tr;

                w=w+passo*erro*x_tr(:,it);    

                %Análise Convergência dos pesos de w
                W_Conv_tr(:,conv)=w;


            end
             %MSE
             err(:,ep)=immse(y_resultado_tr,y_d_tr);         

    end
    %MSE de todas as épocas
    MSE_tr=err;
    Modelo_linear_tr=w;
    
    
    %TESTE
    x_teste=[ones(1,q_teste);dataset_mix((q_teste+1):total,2)'];
    y_d_teste=dataset_regre((q_teste+1):(q_tr+q_teste),1);
    
    conv=0;
    erro=0;

    for ep=1:epoca

            for it=1:q_teste

                conv=conv+1;

                y_teste=w'*x_teste(:,it);

                y_resultado_teste(it,:)=y_teste;


            end
             %MSE
             err(:,ep)=immse(y_resultado_teste,y_d_teste);         

    end
    %MSE de todas as épocas
    MSE_teste=err;
    Modelo_linear_teste=w;
    
end




figure(1)
scatter(dataset_regre(:,2),dataset_regre(:,1),'.','black');
hold on
x_F=[0:total];
Fron_teste=Modelo_linear_teste(2,1)*x_F+Modelo_linear_teste(1,1);
plot(x_F,Fron_teste,'--','Color',[0.6350 0.0780 0.1840],'LineWidth',2)


figure(2)
eixo=[1:epoca];
plot(eixo,MSE_tr(1,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',2);  
hold on
eixo=[1:epoca];
plot(eixo,MSE_teste(1,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',2);



figure(3)
plot(W_Conv_tr(1,:),'r');
hold on
plot(W_Conv_tr(2,:),'b');
hold off