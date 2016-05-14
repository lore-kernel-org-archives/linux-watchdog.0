Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34812 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932336AbcENSa1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:30:27 -0400
Date: Sat, 14 May 2016 20:30:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Knud Poulsen <knpo@ieee.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3] watchdog: f71808e_wdt: Add F81865 support
Message-ID: <20160514183024.GB21026@spo001.leaseweb.nl>
References: <571DF163.4090907@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571DF163.4090907@ieee.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Knud,

> Adds watchdog enable support for Fintek F81865 Super-IO chip to
> Fintek wdt driver (f71808e_wdt)
> 
> Tested and verified on Lanner LEC-3030 Industrial PC
> 
> Datasheet references:
> http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
> http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
> 
> Signed-off-by: Knud Poulsen <knpo@ieee.org>
> ---
>  drivers/watchdog/f71808e_wdt.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

