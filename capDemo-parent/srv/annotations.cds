annotate EditionsService.Editions with {
	issueNumber @(
		Common.FieldControl: #Mandatory
	);
	issueDate @(
		Common.FieldControl: #Mandatory
	);
	magazine_code @(
		Common: {
			Label: '{i18n>magazine}',
			Text: magazine.name
		},
		ValueList.entity: 'Magazines'
	)
}

annotate EditionsService.Editions with {
	issueNumber @title:'{i18n>issueNumber}';
	issueDate @title:'{i18n>issueDate}';
	magazine_code @title:'{i18n>magazine}';
	mainTopic @title:'{i18n>mainTopic}';
	numberPages @title:'{i18n>numberPages}';
	price @title:'{i18n>price}';
	currency @title:'{i18n>currency}';
	createdBy @title:'{i18n>createdBy}';
	createdAt @title:'{i18n>createdAt}';
	modifiedBy @title:'{i18n>modifiedBy}';
	modifiedAt @title:'{i18n>modifiedAt}';
	editionType @title:'{i18n>type}';
	editionType @assert.enum;
};

@odata.draft.enabled
annotate EditionsService.Editions with @(
    UI: {
        Identification: [ {Value: issueNumber},{Value: magazine_code} ],
        SelectionFields: [ magazine_code, issueNumber, issueDate, mainTopic ],
        LineItem: [
            {Value: magazine.name, Label: '{i18n>magazine}'},
            {Value: issueNumber},
            {Value: issueDate},
            {Value: mainTopic}
        ],
        HeaderInfo: {
            TypeName: '{i18n>Edition}',
            TypeNamePlural: '{i18n>Editions}',
            Title: {Value: mainTopic, Label: '{i18n>mainTopic}'},
            Description: {Value: issueNumber, Label: '{i18n>issueNumber}'},
            ImageUrl: imageUrl
        },
        HeaderFacets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>created}', Target: '@UI.FieldGroup#Created'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>modified}', Target: '@UI.FieldGroup#Modified'}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>articles}', Target: 'articles/@UI.LineItem'}
		],
		FieldGroup#Created: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
			]
		},
		FieldGroup#Modified: {
			Data: [
				{Value: modifiedBy},
				{Value: modifiedAt},
			]
		},
		FieldGroup#Details: {
			Data: [
				{Value: issueDate},
				{Value: numberPages},
				{Value: price},
				{Value: currency_code},
				{$Type: 'UI.DataField', Value: magazine_code }
			]
		}
    }
);

annotate EditionsService.Articles with {
	ID @title:'{i18n>id}';
	header @title:'{i18n>header}';
};

annotate EditionsService.Articles with @(
	UI: {
		HeaderInfo: {
            TypeName: '{i18n>Article}',
            TypeNamePlural: '{i18n>Articles}',
            Title: {Value: header}
        },
		Identification: [ {Value: header} ],
        LineItem: [
            {Value: header}
        ]
	}
);

