set names utf8; 

DROP TABLE IF EXISTS `problem_tag`;
CREATE TABLE `problem_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_parent_id` int(11) DEFAULT NULL,
  `tag_level` int(11) NOT NULL DEFAULT '1',
  `tag_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `tag_desc` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `problem_tag_match`;
CREATE TABLE `problem_tag_match` (
  `match_id` int(11) NOT NULL,
  `problem_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


