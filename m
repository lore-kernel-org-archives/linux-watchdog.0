Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mstier.de ([85.214.73.195]:46927 "EHLO mstier.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2AFTrs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Jan 2012 14:47:48 -0500
Message-ID: <4F074DD5.70309@mstier.de>
Date: Fri, 06 Jan 2012 20:39:01 +0100
From: "mark" <mark-dhxman8p@mstier.de>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org
Subject: IT87 WDT: Chip IT8720 revision 8, watchdog reset not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Does someone know about that issue?

See:

https://bugzilla.redhat.com/show_bug.cgi?id=554148

I have the same problem. The watchdog package from debian/ubuntu touches
/dev/watchdog every second (according to strace by writing a 0-byte), 
but the computer still restarts after one minute.

 > dmesg:
 > IT87 WDT: Chip IT8720 revision 8 initialized. timeout=60 sec (nowayout=0
 > testmode=0 exclusive=1 nogameport=0)

Tell me if I can be of any help to fix that issue.

Best regards,
Mark
