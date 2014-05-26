Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56556 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751659AbaEZVFp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 17:05:45 -0400
Date: Mon, 26 May 2014 23:05:40 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Yuantian.Tang@freescale.com
Cc: linux-watchdog@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
Message-ID: <20140526210540.GA23641@spo001.leaseweb.com>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tang,

> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> resend to watchdog maintainer
> 
>  arch/powerpc/kernel/setup-common.c | 27 --------------------
>  drivers/watchdog/booke_wdt.c       | 51 ++++++++++++++++++++++++--------------
>  2 files changed, 33 insertions(+), 45 deletions(-)

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

