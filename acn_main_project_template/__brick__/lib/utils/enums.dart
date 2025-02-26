enum PolicyType{
  expertus(2),
  agito(1),
  unknown(-1);
  const PolicyType(this.value);
  final int value;
}
enum PdfProposalType{
  proposal(true),
  policy(false);
  const PdfProposalType(this.val);
  final bool val;
}

enum PolicyProposType{
  dask(1,199,"Dask"),
  ferdiKaza(2,260,"Ferdi Kaza"),
  saglik(0,298,"Tamamlayıcı Sağlık");
  const PolicyProposType(this.id,this.productCode,this.title);
  final int id;
  final int productCode;
  final String title;
}
enum ProductionTimeUnitForChange{
  daily(1,"Günlük"),monthly(2,"Aylık"),annual(3,"Yıllık");
  const ProductionTimeUnitForChange(this.id,this.title);
  final int id;
  final String title;
}
enum ProductionTimeUnit{
  monthly(1,"Aylık"),annual(2,"Yıllık(Kümülatif)");
  const ProductionTimeUnit(this.id,this.title);
  final int id;
  final String title;
}
enum ProductionReportType{
  proposal(1,"Poliçe Teklif"),
  policy(2,"Poliçe Adet"),
  premium(3,"Prim Üretimi");
  const ProductionReportType(this.id,this.title);
  final int id;
  final String title;
}
enum QueueProcessType{
  pdf
}
enum PdfQueueProcessString{
  pdfPreparing("dökümanı hazırlanıyor."),
  pdfReady("dökümanı hazır."),
  pdfNull("dökümanı oluşturulamadı");
  const PdfQueueProcessString(this.content);
  final String content;
}
enum InsuranceProductEnumType{
  trafik(310),
  otoSigortalari(344),
  filoKasko(345),
  konut(131),
  zorunluKoltukFerdiKaza(350),
  uzunSureliFerdiKaza(256),
  muhendislik(510),
  nakliyatSorumluluk(401),
  nakliyatEmtiya(402),
  kisiselVeriKoruma(660),
  kisiselKorumaKalkani(650),
  korumaSigortalari(158),
  kasko(344),
  tarim(700),
  fullKonutPaket(133),
  yangin(140),
  buroDukkanYanginPaket(141),
  hukuksalKoruma(158),
  dask(199),
  sorumluluk(270),
  ferdiKaza(260),
  saglik(298);
  const InsuranceProductEnumType(this.productID);
  final int productID;
}

