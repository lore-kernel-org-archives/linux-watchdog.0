Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53055 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1FRTB7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:01:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 3/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:01:40 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172136.GD3441@infomag.iguana.be>
In-Reply-To: <20110618172136.GD3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182101.40334.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:21:36 Wim Van Sebroeck wrote:
> watchdog: WatchDog Timer Driver Core - Part 3
> 
> This part add's the WDIOC_KEEPALIVE ioctl functionality to the
> WatchDog Timer Driver Core framework. Please note that the
> WDIOF_KEEPALIVEPING bit has to be set in the watchdog_info
> options field.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
