Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:35128 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342Ab0L3V4U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Dec 2010 16:56:20 -0500
Date: Thu, 30 Dec 2010 22:56:18 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Imre Kaloz <kaloz@openwrt.org>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Cliff Holden <Cliff.Holden@Atheros.com>,
	Kathy Giori <Kathy.Giori@Atheros.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/16] watchdog: add driver for the Atheros
	AR71XX/AR724X/AR913X SoCs
Message-ID: <20101230215618.GW3783@infomag.iguana.be>
References: <1293560437-7967-1-git-send-email-juhosg@openwrt.org> <1293560437-7967-7-git-send-email-juhosg@openwrt.org> <20101230102506.GA6521@infomag.iguana.be> <4D1CB8A7.6010409@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D1CB8A7.6010409@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Gabor,

> I have tested that, it works fine. I would have to resend the patch with your
> changes?

No need to sent it again :-)

> > PS: is there a reason why you don't add a module-parameter for wdt_timeout?
> 
> I have no specific reason, simply i did not need that so far. However I can add
> that in a separate patch, or I can integrate that into the current one if you
> prefer.

I prefer that you integrate it in the current one.

Thanks,
Wim.

