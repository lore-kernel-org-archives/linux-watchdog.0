Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36062 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbbL3NaJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 08:30:09 -0500
Received: by mail-oi0-f44.google.com with SMTP id o62so196687414oif.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Dec 2015 05:30:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151230104452.0baeef09@free-electrons.com>
References: <20151228152335.GA18627@roeck-us.net>
	<20151228152710.GA31482@spo001.leaseweb.nl>
	<20151228215709.GA30595@roeck-us.net>
	<20151228225427.GA2018@spo001.leaseweb.nl>
	<5681C2FE.7070100@mentor.com>
	<20151229071732.GA6292@spo001.leaseweb.nl>
	<20151229160411.GB30405@roeck-us.net>
	<20151229173705.1596cf1d@free-electrons.com>
	<20151229172848.GA14047@roeck-us.net>
	<20151230104452.0baeef09@free-electrons.com>
Date: Wed, 30 Dec 2015 21:30:08 +0800
Message-ID: <CADyBb7tsyKgS4=r+KaAE22BgoRhhHJuMv_4R0TaSaLKd7wT34w@mail.gmail.com>
Subject: Re: Additional patches in my watchdog-next branch
From: Fu Wei <fu.wei@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas,


On 30 December 2015 at 17:44, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Guenter,
>
> On Tue, 29 Dec 2015 09:28:48 -0800, Guenter Roeck wrote:
>
>> Probem with SBSA and pretimeout is two-fold. First, it adds a quite a bit of
>> complexity to the driver, second, it adds a lot of risk to the driver.
>> Reason is that this is not one specific watchdog, but a watchdog implementation
>> based on a standard which, in my opinion, is less than well thought out
>> and leaves a lot of ambiguity when it comes to implementation details.
>
> I agree that calling the SBSA watchdog specification a "specification"
> is a strong word. At least in the version I have, it's 4-5 pages of
> somewhat random thoughts on what a standardized watchdog could look
> like, but not a very well-defined specification that guarantees that
> all implementations will behave in the same way.

Although the basic function is described well in spec 2.3, but it do
need some improvement, in my opinion.

>
>> The more functionality is used, the higher the risk that some implementation
>> won't work.
>
> Maybe we should enforce that all users of the driver use two Device
> Tree compatible strings:
>
>         compatible = "<vendor>,sbsa-gwdt", "arm,sbsa-gwdt";
>
> So that the SBSA watchdog driver can implement vendor specific quirks
> if needed. Though it is true that the HW has some identification
> registers that should allow to differentiate between the implementation.

I think the implementation can be different, but all the SBSA watchdog
should be able to use the same driver.

>
>> I think we should stick with the basic implemementation and not support
>> pretimeout at all with the SBSA driver. If the maximum timeout is insufficient,
>> there are two options: Use the soft-timeout handled by the watchdog core,
>> which will hopefully make it for 4.6, or live with it.
>
> For now, I'm personally fine with a SBSA driver that does not support
> the pretimeout. Is anyone working on submitting something like this ?

I am working on a new non-pretimeout  SBSA driver.

There are two patchsets :
(1) Timur's v4 patch : http://www.spinics.net/lists/linux-watchdog/msg06567.html
(2) my previous non-pretimeout version : https://lkml.org/lkml/2015/6/10/766

>
> Best regards,
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
