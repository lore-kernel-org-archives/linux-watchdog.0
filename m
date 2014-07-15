Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:54152
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753241AbaGOCQF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Jul 2014 22:16:05 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
Date: Tue, 15 Jul 2014 02:15:58 +0000
Message-ID: <f79bb471224b4b54bce631818b3a802b@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
 <20140610192619.GD7773@roeck-us.net>
In-Reply-To: <20140610192619.GD7773@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I'd like to know the status of this patch series.

:)

Thanks,

BRs
Xiubo




> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Wednesday, June 11, 2014 3:26 AM
> To: Xiubo Li-B47053
> Cc: wim@iguana.be; linux-watchdog@vger.kernel.org; robh+dt@kernel.org;
> pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk;
> galak@codeaurora.org
> Subject: Re: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
> 
> On Tue, Jun 03, 2014 at 10:45:14AM +0800, Xiubo Li wrote:
> > This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
> > platforms, and will be in different endianness mode in those SoCs:
> >
> >     SoCs       WDT endian mode
> > ------------------------------------
> >     IMX2+           LE
> >     Vybird          LE
> >     LS1             BE
> >     LS2             LE
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
