Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44638 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305AbbEUP7y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 11:59:54 -0400
Date: Thu, 21 May 2015 08:59:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fu Wei <fu.wei@linaro.org>
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
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150521155950.GA18300@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
 <555DB4C4.5090606@roeck-us.net>
 <CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>
 <20150521151847.GA16668@roeck-us.net>
 <CADyBb7tPjZrty-B=Lis_zdObxM1_MRcKCinOx3K73=6juxsikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7tPjZrty-B=Lis_zdObxM1_MRcKCinOx3K73=6juxsikw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 21, 2015 at 11:46:53PM +0800, Fu Wei wrote:
> Hi Guenter,
> 
[ ... ]

> >> >> +
> >> >> +       /*
> >> >> +        * Try to determine the frequency from the arch_timer interface
> >> >> +        */
> >> >> +       clk = arch_timer_get_rate();
> >> >
> >> >
> >> > arch_timer_get_rate() does not seem to be exported. Did you try to build
> >> > the driver as module ?
> >>
> >> yes, I have built it as a ko module, that is why I made a patch to
> >> export this interface in the first patch of this patchset
> >>
> >>  but I will confirm it again :-)
> >>
> > Guess I'll give it a try myself. I don't really understand how this
> > can work unless arch_timer_get_rate() is exported in your tree.
> 
> yes, I have exported it , I think it make sense to export it.
> Because other driver maybe need to get system counter info
> 
> Do you agree ? :-)
> 
I don't think it is for me to agree or not. The arm maintainers
will need to be involved. You can not just export such a function
without maintainer Ack.

Having said that, my personal preference would be for the counter
and rate to be exported through the clock subsystem (ie with
clk_get_rate). But that would still not provide the current counter
value, so maybe that isn't even possible.

Thanks,
Guenter
