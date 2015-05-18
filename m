Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34734 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbbERRWm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 13:22:42 -0400
Received: by obfe9 with SMTP id e9so132372601obf.1
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2015 10:22:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150515180105.GB19230@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1431689090-3125-1-git-send-email-fu.wei@linaro.org>
	<5555F5C5.8050806@roeck-us.net>
	<CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
	<20150515180105.GB19230@roeck-us.net>
Date: Tue, 19 May 2015 01:22:41 +0800
Message-ID: <CADyBb7vfS1KOH_hKshAReAvtjbEunF2KzB8RLP4h4HUjX0Afog@mail.gmail.com>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

yes, I think it is OK for me,

Once this patchset is merged, I will try to make a new patchset just
for this integration.

On 16 May 2015 at 02:01, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, May 15, 2015 at 09:49:07PM +0800, Fu Wei wrote:
>> Hi Guenter,
>>
>> Great thanks for your review,
>> feedback inline below :-)
>>
>> On 15 May 2015 at 21:33, Guenter Roeck <linux@roeck-us.net> wrote:
>
> [ ... ]
>
>> >> +       if (wdd->max_pretimeout && wdd->max_timeout < wdd->max_pretimeout)
>> >> {
>> >> +               pr_info("Invalid max timeout, resetting to max
>> >> pretimeout!\n");
>> >> +               wdd->max_timeout = wdd->max_pretimeout;
>> >> +       }
>> >
>> >
>> > I am a bit concerned about the context dependency introduced here. If
>> > someone calls
>> > _init_pretimeout after calling init_timeout, this may result in still
>> > invalid timeout
>> > values.
>>
>> yes, that logic is not very clean, so my thought is :
>> maybe we can integrate watchdog_init_timeout and watchdog_init_pretimeout,
>> if maintainer agree to add pretimeout into framework.
>>
> I think we should just assume that Wim will accept it, and try to find
> the best possible solution (or at least a good one).
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
