Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56271 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752026AbbL3OCF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 09:02:05 -0500
Date: Wed, 30 Dec 2015 15:02:00 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151230150200.3d960807@free-electrons.com>
In-Reply-To: <CADyBb7tsyKgS4=r+KaAE22BgoRhhHJuMv_4R0TaSaLKd7wT34w@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Wed, 30 Dec 2015 21:30:08 +0800, Fu Wei wrote:

> > Maybe we should enforce that all users of the driver use two Device
> > Tree compatible strings:
> >
> >         compatible = "<vendor>,sbsa-gwdt", "arm,sbsa-gwdt";
> >
> > So that the SBSA watchdog driver can implement vendor specific quirks
> > if needed. Though it is true that the HW has some identification
> > registers that should allow to differentiate between the implementation.
> 
> I think the implementation can be different, but all the SBSA watchdog
> should be able to use the same driver.

Yes, they *should*, but as Guenter said, since the specification is not
very clear, it is quite likely that some HW implementations will not
behave exactly like others, so the driver will likely need to have some
quirks to adapt to those subtle differences between implementations.

> > For now, I'm personally fine with a SBSA driver that does not support
> > the pretimeout. Is anyone working on submitting something like this ?
> 
> I am working on a new non-pretimeout  SBSA driver.

Ok, great. Can you Cc: me when you send this new version ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
