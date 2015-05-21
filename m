Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35290 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbbEUQMW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 12:12:22 -0400
Received: by obcus9 with SMTP id us9so63860506obc.2
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 09:12:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150521155950.GA18300@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DB4C4.5090606@roeck-us.net>
	<CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>
	<20150521151847.GA16668@roeck-us.net>
	<CADyBb7tPjZrty-B=Lis_zdObxM1_MRcKCinOx3K73=6juxsikw@mail.gmail.com>
	<20150521155950.GA18300@roeck-us.net>
Date: Fri, 22 May 2015 00:12:21 +0800
Message-ID: <CADyBb7vwGcdxeOE+QEzgmF5=2dsk83F4WyfJvp2ccZ12w1qYHQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
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
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,



On 21 May 2015 at 23:59, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 21, 2015 at 11:46:53PM +0800, Fu Wei wrote:
>> Hi Guenter,
>>
> [ ... ]
>
>> >> >> +
>> >> >> +       /*
>> >> >> +        * Try to determine the frequency from the arch_timer interface
>> >> >> +        */
>> >> >> +       clk = arch_timer_get_rate();
>> >> >
>> >> >
>> >> > arch_timer_get_rate() does not seem to be exported. Did you try to build
>> >> > the driver as module ?
>> >>
>> >> yes, I have built it as a ko module, that is why I made a patch to
>> >> export this interface in the first patch of this patchset
>> >>
>> >>  but I will confirm it again :-)
>> >>
>> > Guess I'll give it a try myself. I don't really understand how this
>> > can work unless arch_timer_get_rate() is exported in your tree.
>>
>> yes, I have exported it , I think it make sense to export it.
>> Because other driver maybe need to get system counter info
>>
>> Do you agree ? :-)
>>
> I don't think it is for me to agree or not. The arm maintainers
> will need to be involved. You can not just export such a function
> without maintainer Ack.

yes, I have added Mark Rutland in the CC list when I sent this
patchset . He added the "arch_timer_get_rate();" in the arch timer
driver.
See if he can provide some suggestion. :-)

maybe I should add some more arm arch timer maintainers to get more
help on this :-)

>
> Having said that, my personal preference would be for the counter
> and rate to be exported through the clock subsystem (ie with
> clk_get_rate). But that would still not provide the current counter
> value, so maybe that isn't even possible.

I will try to make a patch for this, If the arm maintainers don't like
exporting "arch_timer_get_rate();"

But your thought is good,  the clk_get_rate is the best way to do for now

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
