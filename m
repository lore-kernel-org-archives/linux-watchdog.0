Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46996 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761430AbbA1G1G (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Jan 2015 01:27:06 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YGM5Z-0024sh-Df
	for linux-watchdog@vger.kernel.org; Wed, 28 Jan 2015 06:27:02 +0000
Date: Tue, 27 Jan 2015 12:52:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for
 jz47xx watchdog timer
Message-ID: <20150127205229.GA6983@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1422371490-44402-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <11680810.808F8uDyN0@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11680810.808F8uDyN0@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 27, 2015 at 09:16:45PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 January 2015 15:11:29 Zubair Lutfullah Kakakhel wrote:
> > +clocks: phandle to rtcclk
> > +clock-names: must be "rtc"
> > +
> > +Example:
> > +
> > +watchdog: jz47xx-watchdog@0x10002000 {
> > +       compatible = "ingenic,jz4780-watchdog";
> > +       reg = <0x10002000 0x100>;
> > +
> > +       clocks = <&rtclk>;
> > +       clock-names = "rtc";
> > +};
> 
> Why is the name "rtc"? are you sure you are not confusing the output
> name of the clock controller with the input of the watchdog device?
> 
Driver does this (today):

	 drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");

Isn't that the name to use ? Just wondering.

Thanks,
Guenter
