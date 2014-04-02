Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1blp0181.outbound.protection.outlook.com ([207.46.163.181]:55330
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756574AbaDBHdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Apr 2014 03:33:12 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Mark Brown <broonie@kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"swarren@nvidia.com" <swarren@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
Date: Wed, 2 Apr 2014 07:33:08 +0000
Message-ID: <52646eae41aa44068a32201ae9c0fff3@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
 <1395800500-22655-3-git-send-email-Li.Xiubo@freescale.com>
 <5338E1E8.4030700@roeck-us.net>
 <28375308b05f4cf4bc7d1559f2524c1b@BY2PR03MB505.namprd03.prod.outlook.com>
 <533A1A4B.2090503@roeck-us.net>
 <1c79a81bbd7b4cc79689cb907e81e893@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140401122454.GS2269@sirena.org.uk>
In-Reply-To: <20140401122454.GS2269@sirena.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Subject: Re: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
> 
> On Tue, Apr 01, 2014 at 02:24:12AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > Yes, I do think so too and there has already regmap-mmio version patch
> > Series about the IMX2 Watchdog driver, but those regmap patches for
> > supporting the 16-bit values are in Mark's tree and the IMX2 Watchdog
> > will depend on them.
> 
> > How to deal with this situation ?
> 
> Well, anything that's already applied went to Linus already so is in
> -rc1.  Anything else we can either do a cross tree merge or I can apply
> the driver.

That's great.

Thanks very much,

BRs
Xiubo
