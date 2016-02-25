Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33936 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbcBYQu2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Feb 2016 11:50:28 -0500
Received: by mail-io0-f194.google.com with SMTP id l127so6112720iof.1
        for <linux-watchdog@vger.kernel.org>; Thu, 25 Feb 2016 08:50:27 -0800 (PST)
Subject: Re: [PATCH v3 6/6] arm: lpc32xx: phy3250 remove restart hook
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com, stigge@antcom.de,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net, vz@mleia.com
In-Reply-To: <2913764.6ZXbKHTUYJ@wuerfel>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
	 <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
	 <2913764.6ZXbKHTUYJ@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Feb 2016 11:50:23 -0500
Message-ID: <1456419023.25197.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd,

On Wed, 2016-02-24 at 22:20 +0100, Arnd Bergmann wrote:
> On Wednesday 24 February 2016 12:46:58 Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > Remove the restart hook assignment from phy3250;
> > this functionality is now managed by
> > the pnx4008 watchdog driver.
> > 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Note:
> > This patch was generated with the option "--unified=2" to ensure
> > it can be apply before or after the following git pull request
> > for the LPC32xx platform:
> > - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477137
> > - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477138
> 
> This patch really needs to come before patch 5 in the series, or
> you could combine the two into a single patch.
> 
There is more change coming to the LPC32xx platform that will 
modify "phy3250.c" (LPC32xx irqchip driver).

You can refer to the following link for details:
http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683

I prefer to keep the change for "phy3250.c" in a separate patch.
I will submit a new revision later today to reverse patch order.


Sylvain Lemieux

> 	Arnd


