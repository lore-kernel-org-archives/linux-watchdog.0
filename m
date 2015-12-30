Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36128 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbL3PGo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 10:06:44 -0500
Received: by mail-ob0-f181.google.com with SMTP id ba1so179227290obb.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Dec 2015 07:06:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151230160352.7ecaff20@free-electrons.com>
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
	<CADyBb7vdPb8qV3-qRys2ze7Pvx9QFy09upPN5NBnCFwpNX8qrw@mail.gmail.com>
	<20151230160352.7ecaff20@free-electrons.com>
Date: Wed, 30 Dec 2015 23:06:43 +0800
Message-ID: <CADyBb7vpDkcvkb8+g06FCqfVVdH5_ZFC747RRFeoKk-nf+bg4g@mail.gmail.com>
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


On 30 December 2015 at 23:03, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Wed, 30 Dec 2015 23:01:09 +0800, Fu Wei wrote:
>
>> For now what we can do is testing the common driver on the different
>> platform as much as we can. See if the driver can work,
>> I have tested my driver on:
>>     (1)ARM Foundation v8 model
>>     (2)AMD Seattle platform
>>
>> maybe there are some other platform has this watchdog, If I can test
>> the driver on them, that would be great.
>
> I have another platform with this watchdog, and I'm currently testing
> it with your driver. So far, it's not working that well, but I haven't
> determined yet if it's a driver problem or a HW problem.

If you can share some info to me, I am glad to help, see if we can
figure out the problem together.

>
>> > Ok, great. Can you Cc: me when you send this new version ?
>>
>> yes, NP, will do definitely.  Great thanks for your feedback.
>
> Good, thanks.
>

 You are welcome! :-)

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
