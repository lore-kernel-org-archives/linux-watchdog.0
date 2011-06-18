Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61466 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab1FRTJd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:09:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 8/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:09:14 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172637.GI3441@infomag.iguana.be>
In-Reply-To: <20110618172637.GI3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182109.14520.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:26:37 Wim Van Sebroeck wrote:
> 
> watchdog: WatchDog Timer Driver Core - Part 8
>    
> Add support for a parent device so that it can
> be set as the parent of the misc_device.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>

How about folding this patch into the first one? It hardly adds any code 
as much as it replaces some lines with others.

	Arnd
