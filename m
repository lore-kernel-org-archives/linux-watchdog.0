Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34818 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753579AbcENScD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:32:03 -0400
Date: Sat, 14 May 2016 20:32:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Knud Poulsen <knpo@ieee.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: f71808e_wdt: Fix WDTMOUT_STS register read
Message-ID: <20160514183200.GD21026@spo001.leaseweb.nl>
References: <571F0E40.6080205@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571F0E40.6080205@ieee.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Knud,

> 
> Tested and verified on Lanner LEC-3030 Industrial PC (with F81865)
> 
> Datasheet verified for
>  F71808, F71858, F71862, F71869, F71869A, F71882, F71889, F81865
> 
> Datasheet references:
> F71808A:
>  http://www.electronicsdatasheets.com/download/534cf560e34e2406135f4658.pdf?format=pdf
> F71858:
>  http://www.electronicsdatasheets.com/download/534cf55fe34e2406135f4635.pdf?format=pdf
> F71862:
>  http://www.hardwaresecrets.com/datasheets/F71862_V027P.pdf
> F71869:
>  http://www.clubedohardware.com.br/datasheets/366451_F71869.pdf
> F71869A:
>  http://www.chipset-ic.com/datasheet/F71869AD.pdf
> F71882:
>  http://www.digchip.com/datasheets/parts/datasheet/931/F71882-pdf.php
> F71889:
>  http://pdf1.alldatasheet.com/datasheet-pdf/view/406312/FINTEK/F71889.html
> F81865:
>  http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
>  http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
> 
> Signed-off-by: Knud Poulsen <knpo@ieee.org>
> ---
>  drivers/watchdog/f71808e_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

