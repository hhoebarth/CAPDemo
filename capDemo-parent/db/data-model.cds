namespace de.javamagazin;
using { Country, Currency, cuid, managed, sap.common.CodeList } from '@sap/cds/common';

define type EditionType: String(1) enum {
	ordinary = 'O';
	special = 'S';
}

type imageUrls: array of String;

define entity Magazines: CodeList {
  key code: String(3);
}

entity Editions: cuid, managed {
	issueNumber: String(10) not null;
 	magazine: Association to Magazines on magazine.code = magazine_code;
	magazine_code: String(3) not null default 'JM';
	issueDate: Date;
	mainTopic: String;
	numberPages: Integer;
	price: Decimal(10,2);
	currency: Currency default 'EUR';
	articles: Composition of many Articles on articles.edition = $self;
	virtual editionType: EditionType;
	imageUrl: String;
}

entity Articles: cuid, managed {
	header: String;
	description: String;
	edition: Association to Editions not null;
	authors: Association to many Articles2Authors on authors.article = $self;
	keyword1: String(50);
	keyWord2: String(50);
	startPage: Integer;
	endPage: Integer;
}

@cds.autoexpose
entity Articles2Authors {
	key article: Association to Articles;
	key author: Association to Authors;
}

entity Authors: cuid, managed {
	firstName: String;
	lastName: String;
	email: String;
	country: Country;
	articles: Association to many Articles2Authors on articles.author = $self;
}