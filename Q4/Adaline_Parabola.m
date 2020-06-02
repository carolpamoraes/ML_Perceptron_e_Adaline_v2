close all
clear all
clc

%Grau do polinômio
poli=2;
%Epocas
epoca=90000;
%Inicialização pesos
%w=random('unif',-0.5,0.5,poli+1,1);
w=zeros(poli+1,1);
%Variáveis dos erros
S_erro_q=0;
Eqm=zeros(1,epoca);
conv=0;

load('parabola.mat');

passo=10^-10;

x=ones(poli+1,500);

for p=1:poli
    
       
    x(p+1,:)=[parabola(:,2).^poli'];    
      
       
end

y_d=parabola(:,1);

for ep=1:epoca

        for it=1:500
            
            conv=conv+1;

            y=w'*x(:,it);
            
            y_resultado(it,:)=y;
            
            erro=y_d(it,:)-y;

            w=w+passo*erro*x(:,it);    
            
           
            %Análise Convergência dos pesos de w
            W_Conv(:,conv)=w;


        end
         err(:,ep)=immse(y_resultado,y_d);         

end
scatter(parabola(:,2),parabola(:,1),'.','r');
hold on
x_F=[-250:249];
  
    
Fron=w(1,1)+w(2,1)*x_F.^1+w(3,1)*x_F.^2;
%Fron=w(1,1)+w(2,1)*x_F.^1+w(3,1)*x_F.^2+w(4,1)*x_F.^3+w(5,1)*x_F.^4+w(6,1)*x_F.^5;


plot(x_F,Fron,'--black','LineWidth',2)

figure(2)
eixo=[1:length(err)];
scatter(eixo,err,'.','b');


figure(3)
plot(W_Conv(1,:),'r');
hold on
plot(W_Conv(2,:),'b');
hold off