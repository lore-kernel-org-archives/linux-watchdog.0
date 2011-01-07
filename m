Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33751 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab1AGQxE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Jan 2011 11:53:04 -0500
Date: Fri, 7 Jan 2011 16:52:50 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Jamie Iles <jamie@jamieiles.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110107165250.GU31708@n2100.arm.linux.org.uk>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com> <AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 07, 2011 at 10:13:50PM +0530, viresh kumar wrote:
> > +
> > +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR_OR_NULL(dw_wdt.clk))
> > +               return -ENODEV;
> 
> should release mem_region and free ioremaped space.
> Also, may be we can continue here in case of error too.
> Some platforms might nor support clock framework. You can enable and
> disable clk's
> if dw_wdt.clk is !NULL

And some platforms have been known to return NULL for clk_get() as they
don't support more than one clock.

arch/arm/mach-aaec2000/core.c:struct clk *clk_get(struct device *dev, const char *id)
arch/arm/mach-aaec2000/core.c-{
arch/arm/mach-aaec2000/core.c-  return dev && strcmp(dev_name(dev), "mb:16") ==
0 ? NULL : ERR_PTR(-ENOENT);
--
arch/arm/mach-at91/at91x40.c:struct clk *clk_get(struct device *dev, const char
*id)
arch/arm/mach-at91/at91x40.c-{
arch/arm/mach-at91/at91x40.c-   return NULL;
--
arch/arm/mach-netx/fb.c:struct clk *clk_get(struct device *dev, const char *id)
arch/arm/mach-netx/fb.c-{
arch/arm/mach-netx/fb.c-        return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);

Please stick to the conventions of the API in the driver.  IS_ERR() values
mean we failed.  Anything else must be considered success.  Don't assume
NULL means we failed.
