Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34206 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbL3PBK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 10:01:10 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp13so44681069obc.1
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Dec 2015 07:01:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151230150200.3d960807@free-electrons.com>
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
	<CADyBb7tsyKgS4=r+KaAE22BgoRhhHJuMv_4R0TaSaLKd7wT34w@mail.gmail.com>
	<20151230150200.3d960807@free-electrons.com>
Date: Wed, 30 Dec 2015 23:01:09 +0800
Message-ID: <CADyBb7vdPb8qV3-qRys2ze7Pvx9QFy09upPN5NBnCFwpNX8qrw@mail.gmail.com>
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

On 30 December 2015 at 22:02, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Wed, 30 Dec 2015 21:30:08 +0800, Fu Wei wrote:
>
>> > Maybe we should enforce that all users of the driver use two Device
>> > Tree compatible strings:
>> >
>> >         compatible = "<vendor>,sbsa-gwdt", "arm,sbsa-gwdt";
>> >
>> > So that the SBSA watchdog driver can implement vendor specific quirks
>> > if needed. Though it is true that the HW has some identification
>> > registers that should allow to differentiate between the implementation.
>>
>> I think the implementation can be different, but all the SBSA watchdog
>> should be able to use the same driver.
>
> Yes, they *should*, but as Guenter said, since the specification is not
> very clear, it is quite likely that some HW implementations will not
> behave exactly like others, so the driver will likely need to have some
> quirks to adapt to those subtle differences between implementations.

As Guenter said, the specification is not very clear. Yes, agree, my
colleagues also have this feeling.
if there are some problems in the spec, maybe we can suggest ARM
engineer improving that

Because the SBSA spec defines the device, I think a "so-called"  SBSA
watchdog can be added more useful features,
but it should follow all the  description in the spec at least, then
the SBSA watchdog driver can be a common driver for all this devices.

For now what we can do is testing the common driver on the different
platform as much as we can. See if the driver can work,
I have tested my driver on:
    (1)ARM Foundation v8 model
    (2)AMD Seattle platform

maybe there are some other platform has this watchdog, If I can test
the driver on them, that would be great.


>
>> > For now, I'm personally fine with a SBSA driver that does not support
>> > the pretimeout. Is anyone working on submitting something like this ?
>>
>> I am working on a new non-pretimeout  SBSA driver.
>
> Ok, great. Can you Cc: me when you send this new version ?
>

yes, NP, will do definitely.  Great thanks for your feedback.

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
