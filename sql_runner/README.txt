�����hustojǨ�ƶ�����

������hustoj�汾�ϵͣ�����Ҫʹ��˽�б����������ƹ�������ִ��
ALTER TABLE `contest` ADD `password` CHAR( 16 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL 

����Ҫʹ����Ƶ�⸽�������ִ�� videopage.sql
����Ҫʹ�����۰���ǿ�����ִ�� forum_notification.sql
����Ҫʹ�������ǩ������ִ�� problemtagsystem.sql

�����Ҫʹ��VirtualJudge����ִ��
CREATE TABLE  `VJ_Solution` (
  `runid` int(11) NOT NULL AUTO_INCREMENT, 		-- runid 1,2,3,4...
  `pid` int(11) NOT NULL DEFAULT '0',			-- problem_id
  `lang` INT UNSIGNED NOT NULL DEFAULT '0',		-- language
  `code` text NOT NULL,							-- source_code
  `user_id` char(20) NOT NULL,					-- user id
  `status` char(20) NOT NULL,					-- status "Pending",etc.
  PRIMARY KEY (`runid`),
  KEY `uid` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;