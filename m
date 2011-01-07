Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49881 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab1AGRRo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Jan 2011 12:17:44 -0500
Received: by iyi12 with SMTP id 12so15958497iyi.19
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Jan 2011 09:17:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110107170808.GG2844@pulham.picochip.com>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
	<AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com>
	<20110107170808.GG2844@pulham.picochip.com>
Date: Fri, 7 Jan 2011 22:47:43 +0530
Message-ID: <AANLkTikrZj5yXi+PXViNyW_5NVLTH+x2E8SfAZd3sis6@mail.gmail.com>
Subject: Re: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
From: viresh kumar <viresh.linux@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 7, 2011 at 10:38 PM, Jamie Iles <jamie@jamieiles.com> wrote:
>> > +static int dw_wdt_open(struct inode *inode, struct file *filp)
>> > +{
>> > +       /* Make sure we don't get unloaded. */
>> > +       __module_get(THIS_MODULE);
>> > +
>> > +       spin_lock(&dw_wdt.lock);
>> > +       if (!dw_wdt_is_enabled()) {
>> > +               /*
>> > +                * The watchdog is not currently enabled. Set the timeout to
>> > +                * the maximum and then start it.
>> > +                */
>> > +               dw_wdt_set_top(DW_WDT_MAX_TOP);
>>
>> shouldn't we check return value here??
>
> No, dw_wdt_set_top() can't fail, it just returns the timeout period that
> it set in seconds.  We use this when the user changes the timeout period
> as we may not be able to select the exact timeout period they chose, but
> here we just select the maximum timeout.

Sorry, I missed that.

>> > +static int __devinit dw_wdt_drv_probe(struct platform_device *pdev)
>> > +{
>> > +       int ret;
>> > +       struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > +
>> > +       if (!mem)
>> > +               return -EINVAL;
>> > +
>> > +       if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
>> > +                                    "iomem"))
>> > +               return -ENOMEM;
>> > +
>> > +       dw_wdt.regs = devm_ioremap(&pdev->dev, mem->start,
>> > +                                            resource_size(mem));
>> > +       if (!dw_wdt.regs)
>> > +               return -ENOMEM;
>>
>> should release mem_region in case of error.
>>
>> > +
>> > +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
>> > +       if (IS_ERR_OR_NULL(dw_wdt.clk))
>> > +               return -ENODEV;
>>
>> should release mem_region and free ioremaped space.
>
> We're using devres for the ioremap and region request so that takes care
> of the cleanup for us.  This also means we don't need to iounmap and
> release in the release method.

ok

>
>> Also, may be we can continue here in case of error too.
>> Some platforms might nor support clock framework. You can enable and
>> disable clk's if dw_wdt.clk is !NULL
>
> The DesignWare watchdog has 16 timeout periods and these are derived
> from the clock frequency input to the WDT.  If we don't have a clk then
> we don't know how long the timeout periods.  The only alternative would
> be to have a 'struct dw_wdt_platform_data' that includes the input clock
> frequency which we use if we can't get a clk and get the rate.

That will be fine.

--
viresh
