Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:52323 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446Ab3GAH2f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Jul 2013 03:28:35 -0400
Date: Mon, 1 Jul 2013 09:32:48 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: "wim@iguana.be" <wim@iguana.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"guenter@roeck-us.net" <guenter@roeck-us.net>,
	"Thumshirn, Johannes Tobias" <Johannes.Thumshirn@men.de>
Subject: Re: [PATCH RESEND v10 2/2] watchdog: Sysfs interface for MEN A21
 watchdog
Message-ID: <20130701073247.GA26252@jtlinux>
References: <20130618151939.GA23296@jtlinux>
 <20130618152119.GA23399@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130618152119.GA23399@jtlinux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

I just wanted to know if you already had time to review the driver?  With
Guenter's help I got rid of some of the quirks still in and he issued his
Reviewed-by. I also imporoved devicetree support and wrote the dts binding
document as Arnd Bergmann suggested. I know you're probably quite busy and 3.10
just came out, but it would be cool to know the current status.

Thanks,
Johannes
