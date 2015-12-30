Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36057 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbL3Lan (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 06:30:43 -0500
Received: by mail-oi0-f45.google.com with SMTP id o62so195501784oif.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Dec 2015 03:30:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151229173705.1596cf1d@free-electrons.com>
References: <20151228152335.GA18627@roeck-us.net>
	<20151228152710.GA31482@spo001.leaseweb.nl>
	<20151228215709.GA30595@roeck-us.net>
	<20151228225427.GA2018@spo001.leaseweb.nl>
	<5681C2FE.7070100@mentor.com>
	<20151229071732.GA6292@spo001.leaseweb.nl>
	<20151229160411.GB30405@roeck-us.net>
	<20151229173705.1596cf1d@free-electrons.com>
Date: Wed, 30 Dec 2015 19:30:43 +0800
Message-ID: <CADyBb7u_adbR4fmCP0u8+-CjURBz+ruXB0OQrzKPc4dSqZxBHQ@mail.gmail.com>
Subject: Re: Additional patches in my watchdog-next branch
From: Fu Wei <fu.wei@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Al Stone <al.stone@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas,

Thanks for your email.
Add Al Stone in the cc list, he is also working on this.

On 30 December 2015 at 00:37, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Tue, 29 Dec 2015 08:04:11 -0800, Guenter Roeck wrote:
>> Hi Wim,
>>
>> On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
>> [ ... ]
>> >
>> > SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
>> >
>> Absoutely agree.
>
> Sorry to get into the conversation, but I got interested into the SBSA
> watchdog driver recently, and looked at the status of its merge in the
> kernel.

Thanks :-)


>
> I've looked at Fu Wei's v9 from November which I believe is the latest
> version, and then looked at Vladimir's generic pretimeout patch set.

yes, v9 is the latest version for upstream, but the real latest
one(rebased to the latest mainline kernel) is here :

https://git.linaro.org/people/fu.wei/linux.git/shortlog/refs/heads/acpi-topic-sbsa-watchdog_upstream_v10_devel


>
> Vladimir, do you plan to rework the SBSA watchdog driver on top of your
> pretimeout patch series ? Or do Fu Wei intends do it ? Alternatively,

in my latest patchset , I was trying to implement pretimeout in the
watchdog framwork,
I thought the SBSA watchdog driver need this , and that makes sense to
be implemented this time.

But after I discussed with some colleagues,  I have to admit that my
design may has some problem.
we are still discussing about that,  but you know, it is holiday in US
now, so most of my colleagues are in vacation, maybe I will post v10
in the middle of January

> as suggested by Wim and Guenter, submitting an initial version without
> pretimeout support would be a good thing. Are you, or Fu, interested in
> doing this, or should I work at updating Fu's patches in this
> direction ?

I have tested and working on this for a while, If you are OK with my
pretimeout patch, we can work together on this, and upstream this as a
separated patch, or integrated into your patchset.
Please feel free to update my patch, you are welcome to work on this.
I am very happy with that. (Please let me know your update if you can,
we can work together or I can use your update :-)  )

But please note that: it doesn't mean my SBSA watchdog patch need this
function, I haven't decided if I still need this or not.

Thanks :-)

>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



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
