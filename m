Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59568 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754841Ab3H3STH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Aug 2013 14:19:07 -0400
Date: Fri, 30 Aug 2013 20:19:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	dianders@chromium.org, jg1.han@samsung.com, t.figa@samsung.com,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V4] watchdog: s3c2410_wdt: remove the global variables
Message-ID: <20130830181905.GA27363@spo001.leaseweb.com>
References: <1377597963-27939-1-git-send-email-l.krishna@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377597963-27939-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

> This patch removes the global variables in the driver file and
> group them into a structure.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Note: This patch is rebased on kgene's for-next branch and tested on SMDK5420.
> 
>  Changes since V3:
> 	- As Wim Van Sebroeck suggested removed to_s3c2410_wdt() and used
> 	  watchdog_get_drvdata() instead.
> 
>  Changes since V2:
> 	- Addressed comments given by Tomasz Figa <t.figa@samsung.com>
> 	  https://patchwork.kernel.org/patch/2831032/
> 	- Renamed structure name from s3c2410_watchdog to s3c2410_wdt.
> 
>  Changes since V1:
> 	- changed the patch subject.
> 	- indentation correction in s3c2410_watchdog structure.
> 
>  drivers/watchdog/s3c2410_wdt.c |  222 +++++++++++++++++++++++-----------------
>  1 file changed, 128 insertions(+), 94 deletions(-)
> 

Added to linux-watchdog-next.

Kind regards,
Wim.

