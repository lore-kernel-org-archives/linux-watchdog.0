Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51091 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbbEFQCe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 May 2015 12:02:34 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Yq1mL-001sqz-Nj
	for linux-watchdog@vger.kernel.org; Wed, 06 May 2015 16:02:33 +0000
Date: Wed, 6 May 2015 09:02:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Message-ID: <20150506160227.GA28101@roeck-us.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 06, 2015 at 02:54:37PM +0000, Opensource [Steve Twiss] wrote:
> On 18 April 2015 16:53 Guenter Roeck wrote:
> 
> Hi Guenter,
> 
> Thanks for your comments.
> 
> > On 04/17/2015 07:23 AM, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource@diasemi.com>
> > >
> > > Add watchdog driver support for DA9062
> > >
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > >
> > Hi Steve,
> > 
> > Key question here is if the da9062 is really so much different to the da9062
> > that you can not use the same driver.
> 
> The DA9062 watchdog driver does have some similarities with the DA9063 watchdog 
> base functionality -- however the watchdog component in the DA9062 chip has more
> features yet to be added in software. I do intend to add these other features ...
> however, if "not adding them here" is a problem I can drop the DA9062 watchdog
> driver from this patch-set until I have time to write in the newer changes.
> 
> > I am especially concerned about the added da9062_reset_watchdog_timer(),
> > given the delay it introduces.
> 
> After giving this some thought, I am going to remove this 300ms delay from the
> reset_watchdog_timer() function for my next submission attempt.  However
> I am adding a 300ms delay into the stop() and update_timeout_register() functions
> instead.
> 
> The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
> against spurious writes -- i.e. the ping function cannot be called within a 250ms
> time limit or the PMIC will reset. This windowing protection also extends to altering
> the timeout scale in the CONTROL_D register -- in which case if the timeout
> register is altered and the ping() function is called within the 250ms limit, the
> PMIC will reset. The delay is there to stop that from happening.
> 
> I realised my previous patch was over-sanitised: by putting the time delay into the
> ping() function I was protecting CONTROL_D in stop() and  update_timeout_register(),
> but I was being too over-protective of the ping() function. Therefore if there was an 
> "incorrect trigger signal", the watchdog would not be allowed to fail because the
> driver would have filtered out the errors.
> 
Hi Steve,

>From your description, it sounds like the protection is only necessary if there
was a previous write to the same register(s). If so, it might make sense to
record the time of such writes, and only add the delay if necessary, and only
for the remainder of the time.

Would this be possible ?

Thanks,
Guenter
