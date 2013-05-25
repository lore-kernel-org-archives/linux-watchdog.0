Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47920 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757763Ab3EYTxk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 15:53:40 -0400
Date: Sat, 25 May 2013 21:53:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog: dw_wdt: Staticize local symbol
Message-ID: <20130525195339.GA13270@spo001.leaseweb.com>
References: <1368513663-23880-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368513663-23880-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> 'dw_wdt_write' is used only in this file. Make it static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/dw_wdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

