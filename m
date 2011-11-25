Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:50663 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626Ab1KYXJo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Nov 2011 18:09:44 -0500
Received: from mail625.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 319BF1010766
	for <linux-watchdog@vger.kernel.org>; Sat, 26 Nov 2011 00:07:40 +0100 (CET)
Date: Sat, 26 Nov 2011 00:01:08 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH] watchdog: fix nowayout setting in wm831x_wdt
Message-ID: <4ed01e34.4telR5MuxvRWCyfz%marc.vertes@sigfox.com>
References: <4ed01ce0.pLO/jX2YTtsMsYc8%marc.vertes@sigfox.com>
In-Reply-To: <4ed01ce0.pLO/jX2YTtsMsYc8%marc.vertes@sigfox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Marc Vertes <marc.vertes@sigfox.com> wrote:

>  	if (nowayout)
> -		wm831x_wdt->status |= WDOG_NO_WAY_OUT;
> +		setbit(WDOG_NO_WAY_OUT, &wm831x_wdt->status);
set_bit(...) of course.

Regards,
--
Marc
