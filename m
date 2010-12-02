Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:55457 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LBJEN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Dec 2010 04:04:13 -0500
Message-ID: <4CF76109.3060300@ge.com>
Date: Thu, 02 Dec 2010 09:04:09 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: gef_wdt: include fs.h
References: <1291245076-23790-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1291245076-23790-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/10 23:11, Wolfram Sang wrote:
> Do like all the others do. Spotted because another watchdog driver in arch/
> missed it, too, and caused build failures with randconfigs.
> 

Oddly, I sent an almost identical patch yesterday!

https://lkml.org/lkml/2010/12/1/217

Though I've just noticed that I messed up with the subject (rtc instead
of watchdog) and managed to introduce a vi-ism into the commit message.

Happy with either to be applied:

Acked-by: Martyn Welch <martyn.welch@ge.com>

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Martyn Welch <martyn.welch@ge.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/gef_wdt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
> index 9c21d19..f6bd6f1 100644
> --- a/drivers/watchdog/gef_wdt.c
> +++ b/drivers/watchdog/gef_wdt.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/miscdevice.h>
>  #include <linux/watchdog.h>
> +#include <linux/fs.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/io.h>


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square,
Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
