Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60763 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab1FRTKm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:10:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 10/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:10:23 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172832.GK3441@infomag.iguana.be>
In-Reply-To: <20110618172832.GK3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182110.23801.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:28:32 Wim Van Sebroeck wrote:
> 
> watchdog: WatchDog Timer Driver Core - Part 10
> 
> Add min_timeout (minimum timeout) and max_timeout
> values so that the framework can check if the new
> timeout value is between the minimum and maximum
> timeout values. If both values are 0, then the
> framework will leave the check for the watchdog
> device driver itself.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
