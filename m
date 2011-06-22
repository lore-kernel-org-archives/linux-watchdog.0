Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:37814 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758537Ab1FVUP3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 16:15:29 -0400
Date: Wed, 22 Jun 2011 22:15:26 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110622201526.GF26745@infomag.iguana.be>
References: <20110618171946.GB3441@infomag.iguana.be> <201106182058.14702.arnd@arndb.de> <20110619204400.d732e8aa.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110619204400.d732e8aa.rdunlap@xenotime.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Randy,

> This info in Documentation/ioctl/ioctl-number.txt does not change, correct?
> 
> 'W'	00-1F	linux/watchdog.h	conflict!

Indeed, the goal is to extract common code out of all watchdog drivers.
So the ioctl calls have stayed the same.

Kind regards,
Wim.

