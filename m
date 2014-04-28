Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1blp0181.outbound.protection.outlook.com ([207.46.163.181]:37990
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754070AbaD1J1m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Apr 2014 05:27:42 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCHv5 0/2] imx2-wdt: Add regmap-mmio support
Date: Mon, 28 Apr 2014 09:27:33 +0000
Message-ID: <06ce143a167a4945906e241475fd0d86@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396575205-24394-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1396575205-24394-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim Van Sebroeck,

Ping:)



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Friday, April 04, 2014 9:33 AM
> To: wim@iguana.be; linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv5 0/2] imx2-wdt: Add regmap-mmio support
> 
> This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
> in BE mode.
> 
> Changes in V5:
> - Select the REGMAP_MMIO default for IMX2 Watchdog.
> 
> Changes in V4:
> - Add the explanation why uing the regmap APIs.
> 
> Changes in V3:
> - convert to use regmap-mmio API.
> 
> Changes in V2:
> - Add the detail information in the commit comment.
> - 'big-endians' --> 'big-endian'.
> 
> 
> 
> 
> 
> Xiubo Li (2):
>   watchdog: imx2_wdt: Sort the header files alphabetically
>   watchdog: imx2_wdt: convert to use regmap API.
> 
>  drivers/watchdog/Kconfig    |  1 +
>  drivers/watchdog/imx2_wdt.c | 62 +++++++++++++++++++++++++++-----------------
> -
>  2 files changed, 39 insertions(+), 24 deletions(-)
> 
> --
> 1.8.4
> 

