Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59304 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1ALI5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Jan 2011 03:57:48 -0500
Received: by iyj18 with SMTP id 18so296371iyj.19
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Jan 2011 00:57:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110112082416.GE3181@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
	<20110112082416.GE3181@pulham.picochip.com>
Date: Wed, 12 Jan 2011 14:27:47 +0530
Message-ID: <AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
From: viresh kumar <viresh.linux@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Jamie,

On Wed, Jan 12, 2011 at 1:54 PM, Jamie Iles <jamie@jamieiles.com> wrote:
>> I don't know why, but checkpatch used to give few errors which it is
>> not giving now.
>> Like:
>> - Mixing spaces and tabs
>> - Line over 80 columns.
>>
>> There are few places in this patch where i have seen these issues, but
>> checkpatch doesn't
>> report them at all.
>
> Hmm, the only lines over 80 chars are printk lines and I can't see any
> with mixed spaces and tabs...

There are few in file drivers/watchdog/dw_wdt.c
line 40-45, 127, 133, 156, 167, 204, 216, 315, 319.

I can check it easily as i have used following in my vimrc file:
au FileType c match error /\s\+$\|\%>80v.\+\|[ ][ ]\+\|\n\n\n\+\|,[^
]\|^[ ]\+[^\*]\|(\s\+\|\s\+)/
au FileType c highlight error ctermbg=red guibg=red ctermfg=blue guifg=blue
au FileType h match error /\s\+$\|\%>80v.\+\|[ ][ ]\+\|\n\n\n\+\|,[^
]\|^[ ]\+[^\*]\|(\s\+\|\s\+)/
au FileType h highlight error ctermbg=red guibg=red ctermfg=blue guifg=blue

and so these sections are highlighted.

(...)

>> > +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
>> > +       if (IS_ERR(dw_wdt.clk))
>> > +               return -ENODEV;
>> > +
>> > +       ret = clk_enable(dw_wdt.clk);
>>
>> should we call this routine if clk is NULL? Probably we will get error here.
>> But as we discussed earlier, we should support machines who don't support clk
>> framework. So, shouldn't we check clk for NULL here and call this
>> routine only if we have a valid clk pointer, otherwise continue
>> instead of returning error.
>
> I think this is right, it's perfectly valid for a platform to return
> NULL as a clk and you can pass that to clk_enable().
>

I agree on the first part: NULL can be returned from clk_get(), but
passing NULL to clk_enable and clk_get_rate doesn't look fine to me.
As they will always return error in that case and code will return from below
error check. That's why i suggest we should check for NULL before
clk_enable/disable and clk_get_rate.
What do you say?

>> > +       if (ret)
>> > +               goto out_put_clk;
>> > +
>> > +       /*
>> > +        * The timeout period of the watchdog is derived from the input clock
>> > +        * frequency.  For platforms that don't have a clk for the watchdog,
>> > +        * they can specify the WDT clock rate through the clk_rate field of
>> > +        * the struct dw_wdt_platform_data platform data.
>> > +        */
>> > +       if (pdata && pdata->clk_rate > 0)
>> > +               dw_wdt.clk_rate = pdata->clk_rate;
>> > +       else
>> > +               dw_wdt.clk_rate = clk_get_rate(dw_wdt.clk);
>> > +
>>
>> I know it doesn't make sense for a platform to have support for clk framework
>> and pass rate through plat data. But this code will always take
>> pdata->rate, if it is passed.
>> Wouldn't it be better if we reverse the sequence.
>>
>> if (clk)
>>  rate = clk_get_rate(...);
>> else {
>>  pdata = pdev->dev.platform_data;
>>  if (pdata)
>>   rate = pdata->rate;
>> }
>>
>> and then following code
>
> That's what I did first (without the test that clk is not NULL) but
> switched it the other way round so that the platform can override the
> frequency by setting platform_data->clk_rate to nonzero.  That just
> seems a little more flexible and easy for testing but I'm happy to
> switch the order if you feel that's important.
>

Problem will occur if rate is dynamically changed and we are still believing
on platform code's clk_rate.
Would be better if we switch order. i.e. give priority to clk_get_rate over
pdata->rate.

>> > diff --git a/include/linux/platform_data/dw_wdt.h b/include/linux/platform_data/dw_wdt.h
>> > new file mode 100644
>> > index 0000000..0af10ef
>> > --- /dev/null
>> > +++ b/include/linux/platform_data/dw_wdt.h
>>
>> It looks you have created a separate generic folder platform_data.
>> But generally we put these files directly into existing folders.
>> I am not quite sure if that's fine or we should avoid this.
>
> Yes, this was suggested by Greg K-H to stop include/linux getting filled
> with platform data (https://lkml.org/lkml/2011/1/7/323).
>

Oh. That's good.

--
viresh
ST Microelectronics
