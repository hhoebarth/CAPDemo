package de.javamagazin.capDemo.handlers;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.Struct;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.EventContext;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CdsService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;
import com.sap.cloud.sdk.services.blockchain.multichain.model.MultichainResult;
import com.sap.cloud.sdk.services.blockchain.multichain.service.MultichainService;

import cds.gen.de.javamagazin.Authors_;
import cds.gen.editionsservice.Articles;
import cds.gen.editionsservice.DynamicAppLauncher;
import cds.gen.editionsservice.Editions;
import cds.gen.editionsservice.Authors;
import cds.gen.editionsservice.EditionsService_;
import cds.gen.editionsservice.Editions_;
import cds.gen.editionsservice.GetNumberOfEditionsForDynamicTileContext;

@Component
@ServiceName(EditionsService_.CDS_NAME)
public class EditionsService implements EventHandler{
	private static final String MULTICHAIN_STREAM_NAME = "root";
	
	@Autowired
	Messages messages;
	
	@Before(event = CdsService.EVENT_CREATE)
	public void beforeCreateEdition(Editions editions) {
		validateEdition(editions);
	}
	
	@Before(event = CdsService.EVENT_UPSERT)
	public void beforeUpsertEdition(Editions editions) {
		validateEdition(editions);
	}
	
	@On(event = "getNumberOfEditionsForDynamicTile")
	public void getNumberOfEditionsForDynamicTile(GetNumberOfEditionsForDynamicTileContext context) {
		context.setResult(this._getNumberOfEditionsForDynamicTile());
		context.setCompleted();
	}
	
	@After(event = CdsService.EVENT_CREATE, entity = Authors_.CDS_NAME)
	public void afterCreateAuthor(EventContext context) {
		_writeAuthorToBlockchain((Authors) context.get("result"));
	}
	
	public void validateEdition(Editions editions) {
		if(!editions.getIssueNumber().matches("([0-9]{2}).([0-9]{4})"))
			throw new ServiceException(ErrorStatuses.BAD_REQUEST, "de.javamagazin.capDemo.issueNumberWrongFormat", editions.getIssueNumber()).messageTarget(Editions_.class, e -> e.issueNumber());
		
		if(editions.getNumberPages() < 50)
			messages.warn("Number of pages is smaller than 50");
		
		validateArticles(editions.getArticles());
	}
	
	public void validateArticles(List<Articles> articles) {
		for(Articles article:articles)
			validateArticle(article);
	}
	
	public void validateArticle(Articles article) {
		if(article.getEndPage() < article.getStartPage())
			throw new ServiceException(ErrorStatuses.BAD_REQUEST, "End page smaller than start page");
	}
	
	protected DynamicAppLauncher _getNumberOfEditionsForDynamicTile() {
		DynamicAppLauncher launcher = Struct.create(DynamicAppLauncher.class);
		
		launcher.setIcon("sap-icon://product");
		launcher.setInfo("Editions");
		launcher.setNumber(BigDecimal.valueOf(3));
		return launcher;
	}
	
	protected void _writeAuthorToBlockchain(Authors author) {
		MultichainService mcService = MultichainService.create();
		
		// Check if entry already exists by querying the blockchain
		List<MultichainResult> queryResult = mcService.listStreamKeyItems(MULTICHAIN_STREAM_NAME, author.getId(), false, 1, -1, false);
		if(queryResult.size() == 0)
			// Write to blockchain
            mcService.publishJson(MULTICHAIN_STREAM_NAME, Arrays.asList(author.getId()), author, null);
	}
}

