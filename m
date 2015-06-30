Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36490 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbF3Xrc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Jun 2015 19:47:32 -0400
Received: by oift81 with SMTP id t81so19909611oif.3
        for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2015 16:47:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <559199AB.8090106@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1435068994-13526-1-git-send-email-fu.wei@linaro.org>
	<CADyBb7vgfFTmqLMMDOjWxwk3B-he2hTYAGpB3diKf47eB=dc=A@mail.gmail.com>
	<559199AB.8090106@roeck-us.net>
Date: Wed, 1 Jul 2015 07:47:30 +0800
Message-ID: <CADyBb7viOH39r+Qyr+BKZ8cnoZKEKomXLEWLd7Mrw0vttX5Y1A@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Watchdog: introduce ARM SBSA watchdog driver
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
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Great thanks for your time,
I can't tell you how much I appreciate your review! :-)

np, I will improve my patchset, once I get your suggestion. :-)

On 30 June 2015 at 03:16, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/29/2015 09:53 AM, Fu Wei wrote:
>>
>> Hi Guenter,
>>
>> Any suggestion on this v6 patchset, for now , I only got :
>
>
> Problem is that each version of your patchset tends to introduce
> substantially
> new or different functionality, meaning the review has to pretty much start
> from scratch. Right now I just don't have time to do that, so you'll have
> to be a bit patient.
>
> Guenter
>



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
