Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56560 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1GKVsp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jul 2011 17:48:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 11/11] watchdog: WatchDog Timer Driver Core - Remove llseek
Date: Mon, 11 Jul 2011 23:48:40 +0200
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1310392522-9949-1-git-send-email-wim@iguana.be> <1310392522-9949-11-git-send-email-wim@iguana.be> <20110711213535.GH5811@pengutronix.de>
In-Reply-To: <20110711213535.GH5811@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107112348.40423.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 11 July 2011, Wolfram Sang wrote:
> On Mon, Jul 11, 2011 at 04:24:39PM +0200, Wim Van Sebroeck wrote:
> > No need to set no_llseek any more since it's the default now.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> I'd think we can squash this into patch 1? Arnd?

Yes, certainly if you like.

	Arnd
