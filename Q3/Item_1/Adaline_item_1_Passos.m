close all
clear all
clc

%Epocas
epoca=70000;
%Inicialização pesos
w=random('unif',-0.5,0.5,2,1);
%Variáveis dos erros
S_erro_q=0;
Eqm=zeros(1,epoca);
conv=0;
p=0;


load('dataset_regre.mat');

for passo=[10^-15 10^-20]
    
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

                %Soma Erro quadratico médio
                S_erro_q=S_erro_q+erro^2;
                ERRO(:,conv)=erro;

                %Análise Convergência dos pesos de w
                W_Conv(:,conv)=w;


            end
             err(:,ep)=immse(y_resultado,y_d);         

    end
    
    MSE(p,:)=err;
    Modelo_linear(:,p)=w;
    
end

figure(1)
scatter(dataset_regre(:,2),dataset_regre(:,1),'.','black');
hold on
x_F=[-20:250];

for im=1:6

Fron=Modelo_linear(2,im)*x_F+Modelo_linear(1,im);

    if im==1
     plot(x_F,Fron,'--b','LineWidth',2)
     hold on
    elseif im==2
     plot(x_F,Fron,'--r','LineWidth',2)
     hold on
     elseif im==3
     plot(x_F,Fron,'--yellow','LineWidth',2)
     hold on
     elseif im==4
     plot(x_F,Fron,'--','Color',[0.4660 0.6740 0.1880],'LineWidth',2)
     hold on
     elseif im==5
     plot(x_F,Fron,'--','Color',[0.6350 0.0780 0.1840],'LineWidth',2)
     hold on
     elseif im==6
     plot(x_F,Fron,'--','Color',[0.3010 0.7450 0.9330],'LineWidth',2)
     hold on
    elseif im==7
     plot(x_F,Fron,'--','Color',[0.8500 0.3250 0.0980],'LineWidth',2)
     hold on
    end

end

figure(2)
eixo=[1:length(err)];


for ie=1:1
    
    if ie==1
    scatter(eixo,MSE(ie,:),'.','Color',[0.8500 0.3250 0.0980],'LineWidth',2);  
    hold off
    end
    
end


figure(3)
plot(W_Conv(1,:),'r');
hold on
plot(W_Conv(2,:),'b');
hold off