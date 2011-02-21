Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:46298 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752822Ab1BUSgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Feb 2011 13:36:47 -0500
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: wim@iguana.be
Subject: && versus &
Date: Mon, 21 Feb 2011 19:36:43 +0100
Cc: linux-watchdog@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201102211936.44160.toralf.foerster@gmx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

Im wondering about this line in drivers/watchdog/sch311x_wdt.c:

if (sch311x_sio_inb(sio_config_port, 0x30) && 0x01 == 0)

is this intended ?

-- 
MfG/Kind regards
Toralf Förster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

