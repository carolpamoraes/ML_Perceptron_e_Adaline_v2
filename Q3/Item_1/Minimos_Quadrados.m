
close all
clear all
clc


%Quantidade de dados
quant_tr=0;
quant_teste=250;
total=250;

load('dataset_regre.mat');


        %Saída desejada
        y_desejado_teste=[dataset_regre(:,1)];
        %Entradas
        x_teste=[1*ones(quant_teste,1) dataset_regre(:,2)];        
        %Épocas 
        q_epoca_teste=0;
        %Vetor de resultados
        y_result_teste=zeros(1,quant_teste);
        %Inicialização pesos
        w=(x_teste'*x_teste)^-1*x_teste'*y_desejado_teste;


%Recuperação   
scatter(dataset_regre(:,2),dataset_regre(:,1),'.','r');
hold on
    
%Fronteira
x_F=[-20:250];
Fron=w(2,1)*x_F+w(1,1);

plot(x_F,Fron,'--black','LineWidth',2)
xlabel('x','FontSize',14)
ylabel('y','FontSize',14)
hold off

            