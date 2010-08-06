Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:61418 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636Ab0HFVdh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:33:37 -0400
Date: Fri, 6 Aug 2010 23:33:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (8/12): implement WDIOC_GETTIMELEFT
Message-ID: <20100806213336.GG31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit b2aad696c01e7d4b997de569ca5168cc24782d63
Author: dann frazier <dannf@hp.com>
Date:   Wed Jun 2 16:23:41 2010 -0600

    watchdog: hpwdt (8/12): implement WDIOC_GETTIMELEFT
    
    Let applications check the amount of time left before the watchdog will fire.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 0029991..554526c 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -450,6 +450,11 @@ static int hpwdt_change_timer(int new_margin)
 	return 0;
 }
 
+static int hpwdt_time_left(void)
+{
+	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
+}
+
 /*
  *	NMI Handler
  */
@@ -591,6 +596,10 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETTIMEOUT:
 		ret = put_user(soft_margin, p);
 		break;
+
+	case WDIOC_GETTIMELEFT:
+		ret = put_user(hpwdt_time_left(), p);
+		break;
 	}
 	return ret;
 }
