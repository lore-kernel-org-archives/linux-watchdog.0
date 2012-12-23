Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56897 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2LWUcl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 23 Dec 2012 15:32:41 -0500
Date: Sun, 23 Dec 2012 20:32:40 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] watchdog: omap_wdt: eliminate unused variable and a
 compiler warning
In-Reply-To: <1356293017-29443-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <alpine.DEB.2.00.1212232032260.8937@utopia.booyaka.com>
References: <1356293017-29443-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, 23 Dec 2012, Aaro Koskinen wrote:

> We forgot to delete this in the commit 4f4753d9 (watchdog: omap_wdt:
> convert to devm_ functions), and as a result the following compilation
> warning was introduced:
> 
> drivers/watchdog/omap_wdt.c: In function 'omap_wdt_remove':
> drivers/watchdog/omap_wdt.c:299:19: warning: unused variable 'res' [-Wunused-variable]
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
