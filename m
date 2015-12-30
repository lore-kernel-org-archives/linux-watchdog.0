Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35966 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbbL3LoJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 06:44:09 -0500
Received: by mail-oi0-f44.google.com with SMTP id o62so195623782oif.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Dec 2015 03:44:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151229172848.GA14047@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
	<20151228152710.GA31482@spo001.leaseweb.nl>
	<20151228215709.GA30595@roeck-us.net>
	<20151228225427.GA2018@spo001.leaseweb.nl>
	<5681C2FE.7070100@mentor.com>
	<20151229071732.GA6292@spo001.leaseweb.nl>
	<20151229160411.GB30405@roeck-us.net>
	<20151229173705.1596cf1d@free-electrons.com>
	<20151229172848.GA14047@roeck-us.net>
Date: Wed, 30 Dec 2015 19:44:08 +0800
Message-ID: <CADyBb7tK9vOqjdx+Nv70bgoyjVcRy=SB1TCwj8s-HCfSPuOqhA@mail.gmail.com>
Subject: Re: Additional patches in my watchdog-next branch
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Al Stone <al.stone@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,



On 30 December 2015 at 01:28, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Dec 29, 2015 at 05:37:05PM +0100, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Tue, 29 Dec 2015 08:04:11 -0800, Guenter Roeck wrote:
>> > Hi Wim,
>> >
>> > On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
>> > [ ... ]
>> > >
>> > > SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
>> > >
>> > Absoutely agree.
>>
>> Sorry to get into the conversation, but I got interested into the SBSA
>> watchdog driver recently, and looked at the status of its merge in the
>> kernel.
>>
>> I've looked at Fu Wei's v9 from November which I believe is the latest
>> version, and then looked at Vladimir's generic pretimeout patch set.
>>
>> Vladimir, do you plan to rework the SBSA watchdog driver on top of your
>> pretimeout patch series ? Or do Fu Wei intends do it ? Alternatively,
>> as suggested by Wim and Guenter, submitting an initial version without
>> pretimeout support would be a good thing. Are you, or Fu, interested in
>> doing this, or should I work at updating Fu's patches in this
>> direction ?
>>
> Probem with SBSA and pretimeout is two-fold. First, it adds a quite a bit of
> complexity to the driver, second, it adds a lot of risk to the driver.
> Reason is that this is not one specific watchdog, but a watchdog implementation
> based on a standard which, in my opinion, is less than well thought out
> and leaves a lot of ambiguity when it comes to implementation details.
> The more functionality is used, the higher the risk that some implementation
> won't work.

After discussing with my colleagues, I agree with you now.
So I am updating  my patchset now, will post ASAP.

Great thanks for your and Timur's review :-)  To be honest, now , I am
very appreciate that :-)

>
> I think we should stick with the basic implemementation and not support
> pretimeout at all with the SBSA driver. If the maximum timeout is insufficient,
> there are two options: Use the soft-timeout handled by the watchdog core,
> which will hopefully make it for 4.6, or live with it.

yes, I am tending to give up pretimeout in my driver, but I am still
thinking about that, please give me some time.

for the maximum timeout:
it is easy to solve the first stage,  but for the second stage , it is
impossible to extend the  maximum timeout  without writing the WCV in
IRQ handler.
So I am thinking that maybe I will give up to  extend the  maximum
timeout of  the second stage

>
> As for pretimeout itself, we will have multiple proposals to consider,
> as well as integration order. At this point I would prefer to get the other
> infrastructure changes in first, and then pick an implementation which
> doesn't add too much complexity. Current proposals are, from my
> perspective, either too heavy-weigt or too light-weight. I think we should
> try to find a middle ground.

For pretimeout itself,  could you provide some suggestion on my patch,
see if we can working on mine. or if you have better solution, I am
happy to try

Thank you very much!

>
> Thanks,
> Guenter



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
