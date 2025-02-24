//Notification channels Android

enum NotificationGroupID {
  commonCategory("common","Genel");
  const NotificationGroupID(this.categoryID, this.categoryName);

  final String categoryID;
  final String categoryName;
}
enum NotificationChannelID {
  general("defaultChannel", "Varsayılan");

  const NotificationChannelID(this.channelID, this.channelName);

  final String channelID;
  final String channelName;
}
