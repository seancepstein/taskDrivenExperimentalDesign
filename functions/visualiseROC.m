function visualiseROC(results,sampling,scanner)

adc_colour = [255 128 31]/255;
bcnlls_colour = [45 200 187]/255;
snlls_colour = [102 0 204]/255;
close all
figure('units','pixels','outerposition',[0 0 1000 1500])

%Plot ROC
counter = 1;
for i = 1:sampling.number
    for j = 1:scanner.number
        subplot(2,2,counter)
        plot(results.ROC.ADC.wLS.ADC.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.ADC.wLS.ADC.(sampling.name{i}).(scanner.name{j}).y,'Color',adc_colour,'LineWidth',2.5)
        hold on
        
        plot(results.ROC.IVIM.bcNLLS.Dt.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.bcNLLS.Dt.(sampling.name{i}).(scanner.name{j}).y,'Color',bcnlls_colour,'LineWidth',2.5)
        plot(results.ROC.IVIM.bcNLLS.Dp.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.bcNLLS.Dp.(sampling.name{i}).(scanner.name{j}).y,'Color',bcnlls_colour,'LineWidth',2.5,'LineStyle',':')
        plot(results.ROC.IVIM.bcNLLS.f.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.bcNLLS.f.(sampling.name{i}).(scanner.name{j}).y,'Color',bcnlls_colour,'LineWidth',2.5,'LineStyle','--')
        
        plot(results.ROC.IVIM.sNLLS.Dt.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.sNLLS.Dt.(sampling.name{i}).(scanner.name{j}).y,'Color',snlls_colour,'LineWidth',2.5)
        plot(results.ROC.IVIM.sNLLS.Dp.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.sNLLS.Dp.(sampling.name{i}).(scanner.name{j}).y,'Color',snlls_colour,'LineWidth',2.5,'LineStyle',':')
        plot(results.ROC.IVIM.sNLLS.f.(sampling.name{i}).(scanner.name{j}).x,...
            results.ROC.IVIM.sNLLS.f.(sampling.name{i}).(scanner.name{j}).y,'Color',snlls_colour,'LineWidth',2.5,'LineStyle','--')
        grid on
        xlabel('False positive rate','Interpreter','Latex')
        ylabel('True positive rate','Interpreter','Latex')
        axis equal
        xlim([0 1])
        ylim([0 1])
        title(sprintf('%s %s',sampling.name{i},scanner.name{j}))
        if counter == 1
            legend('ADC','bcNLLS Dslow','bcNLLS Dfast','bcNLLS f','Location','southeast','Interpreter','Latex')
        end
        counter = counter+1;
        
    end
end
set(gcf, 'Color', 'w');

end