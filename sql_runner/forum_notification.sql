SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for forum_notification
-- ----------------------------
DROP TABLE IF EXISTS `forum_notification`;
CREATE TABLE `forum_notification` (
  `notify_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `last_read_time` datetime NOT NULL,
  `thread_id` int(11) NOT NULL,
  PRIMARY KEY (`notify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
