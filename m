Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33206 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbESBMc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 21:12:32 -0400
Received: by obblk2 with SMTP id lk2so213397obb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2015 18:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150518201445.GA21230@roeck-us.net>
References: <=fu.wei@linaro.org>
	<CADyBb7u=HjZO5CBzZLxw1aWDx0tKdVKBuTrrhrRF9bAQr7pADQ@mail.gmail.com>
	<20150518172329.GA17202@roeck-us.net>
	<2729872.Fp4939suL0@wuerfel>
	<20150518201445.GA21230@roeck-us.net>
Date: Tue, 19 May 2015 09:12:31 +0800
Message-ID: <CADyBb7u1YnVvhNsvGAY7pQjK_SwMthN175XSw_DSY4SmF8XbVg@mail.gmail.com>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd, Guenter,

yes, that is brilliant idea!!
I will try to do so , that solve the compatibility problem , so I
guess we can try this time :-)

On 19 May 2015 at 04:14, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, May 18, 2015 at 10:03:52PM +0200, Arnd Bergmann wrote:
>> On Monday 18 May 2015 10:23:30 Guenter Roeck wrote:
>> > >
>> > > integrate watchdog_init_pretimeout and watchdog_init_timeout will be a
>> > > little hard,
>> > > we may need to change this API to :
>> > >
>> > > watchdog_init_timeouts(struct watchdog_device *wdd, unsigned int timeout_parm,
>> > >                              unsigned int pretimeout_parm, struct device *dev)
>> > >
>> > > then we need to update all the watchdog drivers which use this API,
>> > > maybe we can do this in a individual patchset, after this pretimeout
>> > > patch is merged.
>> > >
>> > > Is that OK  ?   any thought?
>> > >
>> > That is what I would recommend.
>> >
>>
>> The API change is fine, but I don't think you need to change all drivers.
>>
>> Just add a small wrapper function in the header file doing the conversion:
>>
>> static inline int watchdog_init_timeout(struct watchdog_device *wdd,
>>                                 unsigned int timeout_parm, struct device *dev)
>> {
>>       return watchdog_init_timeouts(wdd, timeout_parm, ~0ul, dev);
>> }
>>
>> Then you can update the drivers that actually use the pretimeout to
>> use the new function at some point, and leave all other drivers calling
>> the wrapper function.
>>
> Excellent idea.
>
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
