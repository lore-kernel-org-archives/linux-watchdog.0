Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56813 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753011AbbL3PDz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 10:03:55 -0500
Date: Wed, 30 Dec 2015 16:03:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Al Stone <al.stone@linaro.org>
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151230160352.7ecaff20@free-electrons.com>
In-Reply-To: <CADyBb7vdPb8qV3-qRys2ze7Pvx9QFy09upPN5NBnCFwpNX8qrw@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Wed, 30 Dec 2015 23:01:09 +0800, Fu Wei wrote:

> For now what we can do is testing the common driver on the different
> platform as much as we can. See if the driver can work,
> I have tested my driver on:
>     (1)ARM Foundation v8 model
>     (2)AMD Seattle platform
> 
> maybe there are some other platform has this watchdog, If I can test
> the driver on them, that would be great.

I have another platform with this watchdog, and I'm currently testing
it with your driver. So far, it's not working that well, but I haven't
determined yet if it's a driver problem or a HW problem.

> > Ok, great. Can you Cc: me when you send this new version ?
> 
> yes, NP, will do definitely.  Great thanks for your feedback.

Good, thanks.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
