close all
clear all
clc

%Epocas
epoca=40000;
%Inicialização pesos
w=random('unif',-0.5,0.5,2,1);
%Variáveis
conv=0;
p=0;


load('dataset_regre.mat');

for passo=[10^-6]
    
    p=p+1;
    
    x=[ones(1,250);dataset_regre(:,2)'];
    y_d=dataset_regre(:,1);

    for ep=1:epoca

            for it=1:250

                conv=conv+1;

                y=w'*x(:,it);

                y_resultado(it,:)=y;

                erro=y_d(it,:)-y;

                w=w+passo*erro*x(:,it);    

                %Análise Convergência dos pesos de w
                W_Conv(:,conv)=w;


            end
             %MSE
             err(:,ep)=immse(y_resultado,y_d);         

    end
    %MSE de todas as épocas
    MSE(p,:)=err;
    Modelo_linear(:,p)=w;
    
end

figure(1)
scatter(dataset_regre(:,2),dataset_regre(:,1),'.','black');
hold on
x_F=[-20:250];
Fron=Modelo_linear(2,1)*x_F+Modelo_linear(1,1);
plot(x_F,Fron,'--','Color',[0.3010 0.7450 0.9330],'LineWidth',2)


figure(2)
eixo=[1:epoca];
plot(eixo,MSE(1,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',2);  



figure(3)
plot(W_Conv(1,:),'r');
hold on
plot(W_Conv(2,:),'b');
hold off