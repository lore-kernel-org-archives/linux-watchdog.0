Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52259 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1FRTDh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:03:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:03:18 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172301.GE3441@infomag.iguana.be>
In-Reply-To: <20110618172301.GE3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182103.18614.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:23:01 Wim Van Sebroeck wrote:
> 
> watchdog: WatchDog Timer Driver Core - Part 4
> 
> This part add's the WDIOC_SETOPTIONS ioctl functionality
> to the WatchDog Timer Driver Core framework.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
