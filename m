Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:11869 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab1BWWGu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Feb 2011 17:06:50 -0500
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p1NM6m8Y031188
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:06:48 -0800
Received: from gyh3 (gyh3.prod.google.com [10.243.50.195])
	by hpaq1.eem.corp.google.com with ESMTP id p1NM5rc2001956
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:06:47 -0800
Received: by gyh3 with SMTP id 3so1319876gyh.36
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2011 14:06:47 -0800 (PST)
Message-ID: <4D6584F2.1010109@google.com>
Date: Wed, 23 Feb 2011 14:06:42 -0800
From: Mike Waychison <mikew@google.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 6/10] Generic Watchdog Timer Driver
References: <20110223204350.GA7433@infomag.iguana.be>
In-Reply-To: <20110223204350.GA7433@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/23/11 12:43, Wim Van Sebroeck wrote:
> commit afe3de93859443b575407f39a2e655956c02e088
> Author: Wim Van Sebroeck<wim@iguana.be>
> Date:   Sun Jul 18 10:39:00 2010 +0000
>
>      watchdog: WatchDog Timer Driver Core - Part 6
>
>      Since we don't want that a driver module can be removed
>      while the watchdog timer is still active, we lock the
>      driver module (by incremeting the reference counter).
>      After a clean close of the watchdog driver we unlock the
>      driver module.
>      If /dev/watchdog is closed uncleanly (and the watchdog is
>      still active) then we do not unlock the driver module,
>      but keep it, so that next time /dev/watchdog get's opened
>      we can continue triggering the watchdog.
>
>      Signed-off-by: Alan Cox<alan@lxorguk.ukuu.org.uk>
>      Signed-off-by: Wim Van Sebroeck<wim@iguana.be>
>

*snip*

> diff --git a/drivers/watchdog/core/watchdog_core.c b/drivers/watchdog/core/watchdog_core.c
> index 52bc520..d1a824e 100644
> --- a/drivers/watchdog/core/watchdog_core.c
> +++ b/drivers/watchdog/core/watchdog_core.c
> @@ -60,6 +60,10 @@ int register_watchdogdevice(struct watchdog_device *wdd)
>   	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
>   		return -ENODATA;
>
> +	/* Make sure that the owner of the watchdog operations exists */
> +	if (wdd->ops->owner == NULL)
> +		return -ENODATA;

This check is invalid when the driver is built in.
