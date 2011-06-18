Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:18083 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab1FRRR7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 13:17:59 -0400
Date: Sat, 18 Jun 2011 19:17:57 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110618171757.GA3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

To reduce copying the same code over and over in each watchdog device driver, Alan Cox and myself constructed a new framework/API that consolidates the common watchdog timer driver functions.
I incorporated the changes/feedback that I received from the first post.

This framework/API consists of the following patches:
part  1: Introduction of the WatchDog Timer Driver Core
part  2: Add the basic ioctl functionality
part  3: Add the WDIOC_KEEPALIVE ioctl
part  4: Add the WDIOC_SETOPTIONS ioctl
part  5: Add the WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT ioctl
part  6: Add the Magic Close feature
part  7: Add the nowayout feature
part  8: Add support for a miscdev parent device
part  9: Add support for extra ioctl calls
part 10: Add the minimum and maximum timeout parameters.

The code will also be added to linux-2.6-watchdog-next.

Kind regards,
Wim.

