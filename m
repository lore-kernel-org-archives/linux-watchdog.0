Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:35513 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751889Ab1BUSny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Feb 2011 13:43:54 -0500
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: wim@iguana.be
Subject: || versus |
Date: Mon, 21 Feb 2011 19:43:41 +0100
Cc: linux-watchdog@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201102211943.41597.toralf.foerster@gmx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I found in drivers/watchdog/w83697ug_wdt.c:

 outb_p(c || 0x01, WDT_EFDR); /* set bit 0 to activate GPIO2 */

-- 
MfG/Kind regards
Toralf Förster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

