Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44429 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424959AbeCBOXZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 2 Mar 2018 09:23:25 -0500
Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdW-_MgFSh5aKGiMVyvc2-nvJXCPGCgQOCGfg9yqA708qw@mail.gmail.com>
 <TY1PR06MB08951A6D879D77BD5A854388C0C50@TY1PR06MB0895.apcprd06.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <84fa5868-67ac-75d3-9e97-3614b4d18dc9@roeck-us.net>
Date: Fri, 2 Mar 2018 06:23:21 -0800
MIME-Version: 1.0
In-Reply-To: <TY1PR06MB08951A6D879D77BD5A854388C0C50@TY1PR06MB0895.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2018 02:45 AM, Fabrizio Castro wrote:
> Dear All,
> 
> perhaps someone from this email thread could explain to me what's the actual
> (general) expectation from a system perspective (at resume) from the watchdog,
> because I can see pitfalls whether 1) we simply start the watchdog at resume or
> 2) we pick up from where we left.
> 
> If we have a system that goes to sleep quite a bit, option 1) may cause the watchdog
> to never fire, even though user space is not explicitly pinging the watchdog. As Geert
> has pointed out, going to sleep and waking up adds a delay, therefore with option 2)
> you may miss the opportunity to ping the watchdog and therefore the system may
> restart even when it shouldn't. However, with option 2) user space can make
> arrangements to compensate for the delay, and when user space compensates for
> that it means the system is probably sane. With option 1) instead we are basically
> pinging the watchdog without explicitly doing so from user space, which I don't think
> is what we want here, but I may be wrong.
> 
> Could someone please shed some light here?
> 
If the system goes to sleep so often that the watchdog never triggers just because of
that, it must either be in pretty good shape, in which case the watchdog doesn't need
to fire, or it is in bad shape, and the repeated stopping/restarting of the watchdog
would ultimately cause the system to die with the watchdog stopped anyway.

Overall, just the fact that the watchdog has to be stopped during suspend is a weak spot.
Bad luck if the system hangs after the watchdog was stopped. Since suspend is a critical
operation )in the sense that if anything goes wrong, that is the time for it), that is
a _real_ weak spot. If anything, we should be concerned about that, not about the exact
timing of watchdog pings.

Sure, you can leave it to user space to adjust for the resume time. Let's hope that the
watchdog daemon does that, and that it gets to run fast enough to actually do it.
I do wonder though how it would know. Are processes informed about a resume event ?

Personally I rather play it safe, meaning I rather give the watchdog a bit of additional
slack during resume. Having said that, as mentioned before, I am willing to accept
the patch as is, in the assumption that the authors know what they are doing.

Guenter

> Thanks,
> Fab
> 
> 
>> Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
>>
>> Hi Fabrizio,
>>
>> On Thu, Mar 1, 2018 at 7:17 PM, Fabrizio Castro
>> <fabrizio.castro@bp.renesas.com> wrote:
>>> On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
>>> on R-Car Gen3 we power the IP down during suspend.
>>>
>>> This commit adds suspend/resume support, so that the watchdog counting
>>> "pauses" during suspend on all of the SoCs compatible with this driver
>>> and on those we are now adding support for (R-Car Gen2 and RZ/G1).
>>>
>>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>>> ---
>>> v6->v7:
>>> * backup and restore register RWTCNT instead of using rwdt_get_timeleft and
>>>    rwdt_set_timeleft
>>
>> Thanks for the update (v6 and v7)!
>>
>>>
>>>   drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
>>> index 831ef83..024d54e 100644
>>> --- a/drivers/watchdog/renesas_wdt.c
>>> +++ b/drivers/watchdog/renesas_wdt.c
>>> @@ -49,6 +49,7 @@ struct rwdt_priv {
>>>          void __iomem *base;
>>>          struct watchdog_device wdev;
>>>          unsigned long clk_rate;
>>> +       u16 time_left;
>>>          u8 cks;
>>>   };
>>>
>>> @@ -203,6 +204,30 @@ static int rwdt_remove(struct platform_device *pdev)
>>>          return 0;
>>>   }
>>>
>>> +static int __maybe_unused rwdt_suspend(struct device *dev)
>>> +{
>>> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +       if (watchdog_active(&priv->wdev)) {
>>> +               priv->time_left = readw(priv->base + RWTCNT);
>>> +               rwdt_stop(&priv->wdev);
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>> +static int __maybe_unused rwdt_resume(struct device *dev)
>>> +{
>>> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +       if (watchdog_active(&priv->wdev)) {
>>> +               rwdt_start(&priv->wdev);
>>> +               rwdt_write(priv, priv->time_left, RWTCNT);
>>
>> Upon given it more thought, I'm a bit worried about restoring the
>> original time left.
>> In my experiments, it may take a few seconds before userspace fully resumes.
>> If time_left was a small value, the system may reboot before userspace has
>> a chance to send its next ping.
>> This was with NFS root, so heavily impacted by the delays introduced by the
>> PHY link getting up again.
>>
>> So just using rwdt_stop()/rwdt_start() may be the safest option.
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                  -- Linus Torvalds
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{���\�� �{ay�
ʇڙ�,j��f���h���z�
�w���
���j:+v���w�j�m��������zZ+�����ݢj"��!tml=
> 

