Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.161]:37237 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653AbbEGRp1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 13:45:27 -0400
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>,
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
	"Mark Rutland" <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Thu, 7 May 2015 17:45:13 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B221DD2@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
 <20150506160227.GA28101@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21925B@SW-EX-MBX02.diasemi.com>
 <20150506200631.GA25846@roeck-us.net>
In-Reply-To: <20150506200631.GA25846@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 06 May 2015 21:07 Guenter Roeck wrote:

> > > > The DA9062 watchdog ping (register CONTROL_F) is "windowed" for p=
rotection
> > > > against spurious writes -- i.e. the ping function cannot be calle=
d within a 250ms
> > > > time limit or the PMIC will reset. This windowing protection also=
 extends to altering
> > > > the timeout scale in the CONTROL_D register -- in which case if t=
he timeout
> > > > register is altered and the ping() function is called within the =
250ms limit, the
> > > > PMIC will reset. The delay is there to stop that from happening.
> > > >
> > > > I realised my previous patch was over-sanitised: by putting the t=
ime delay into the
> > > > ping() function I was protecting CONTROL_D in stop() and update_t=
imeout_register(),
> > > > but I was being too over-protective of the ping() function. There=
fore if there was an
> > > > "incorrect trigger signal", the watchdog would not be allowed to =
fail because the
> > > > driver would have filtered out the errors.
> > > >
> > > Hi Steve,
> > >
> > > From your description, it sounds like the protection is only necess=
ary if there
> > > was a previous write to the same register(s).

Hi Guenter,

A clarification from me. It is not the CONTROL_D register that needs prot=
ecting, but when
the CONTROL_D register is altered the function call also performs a CONTR=
OL_F watchdog
ping. Too many pings close together would cause the PMIC reset.

> > > If so, it might make sense to record the time of such writes, and o=
nly add the delay
> > > if necessary, and only for the remainder of the time.

I've tried it several ways, but my previous suggestion of putting the del=
ays in the stop() and=20
update_timeout_register() functions just cause even more lengthy delays.

So, I've followed your suggestion and used a variable delay inside the pi=
ng() function instead:
this seems to cause a lot less delay. A debug message can be used to noti=
fy the user if the
watchdog is trying to be kicked too quickly -- that would be more prefera=
ble than just shutting
the PMIC down and still provide a notification that something wasn't quit=
e right.

> > > Would this be possible ?

I'll run the tests overnight.
I'm going to do something like this:

diff --git a/linux-next/v4.0/drivers/watchdog/da9062_wdt.c b/linux-next/v=
4.0/drivers/watchdog/da9062_wdt.c
index ad80261..d596910 100644
--- a/gp_sparse/linux-next/v4.0/drivers/watchdog/da9062_wdt.c
+++ b/gp_sparse/linux-next/v4.0/drivers/watchdog/da9062_wdt.c

@@ -32,12 +33,37 @@ static const unsigned int wdt_timeout[] =3D { 0, 2, 4=
, 8, 16, 32, 65, 131 };
 #define DA9062_WDT_MIN_TIMEOUT         wdt_timeout[DA9062_TWDSCALE_MIN]
 #define DA9062_WDT_MAX_TIMEOUT         wdt_timeout[DA9062_TWDSCALE_MAX]
 #define DA9062_WDG_DEFAULT_TIMEOUT     wdt_timeout[DA9062_TWDSCALE_MAX-1=
]
+#define DA9062_RESET_PROTECTION_MS     300
=20
 struct da9062_watchdog {
        struct da9062 *hw;
        struct watchdog_device wdtdev;
+       unsigned long j_time_stamp;
 };
=20
+static void da9062_set_window_start(struct da9062_watchdog *wdt)
+{
+       wdt->j_time_stamp =3D jiffies;
+}
+
+static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
+{
+       unsigned long delay =3D msecs_to_jiffies(DA9062_RESET_PROTECTION_=
MS);
+       unsigned long timeout =3D wdt->j_time_stamp + delay;
+       unsigned long now =3D jiffies;
+       unsigned int diff_ms;
+
+       /* if time-limit has not elapsed then wait for remainder */
+       if (time_before(now, timeout)) {
+               diff_ms =3D jiffies_to_msecs(timeout-now);
+               dev_dbg(wdt->hw->dev,
+                       "Delaying watchdog ping by %u msecs\n", diff_ms);
+               mdelay(diff_ms);
+       }
+
+       return;
+}
+
 static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
 {
        unsigned int i;
@@ -50,26 +76,29 @@ static unsigned int da9062_wdt_timeout_to_sel(unsigne=
d int secs)
        return DA9062_TWDSCALE_MAX;
 }
=20
-static int da9062_reset_watchdog_timer(struct da9062 *hw)
+static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
 {
        int ret;
=20
-       ret =3D regmap_update_bits(hw->regmap,
+       da9062_apply_window_protection(wdt);
+
+       ret =3D regmap_update_bits(wdt->hw->regmap,
                           DA9062AA_CONTROL_F,
                           DA9062AA_WATCHDOG_MASK,
                           DA9062AA_WATCHDOG_MASK);
=20
-       mdelay(300);
+       da9062_set_window_start(wdt);
=20
        return ret;
 }

[...]
=20
@@ -216,6 +245,8 @@ static int da9062_wdt_probe(struct platform_device *p=
dev)
                dev_err(wdt->hw->dev,
                        "watchdog registration incomplete (%d)\n", ret);
=20
+       da9062_set_window_start(wdt);
+
        da9062_wdt_ping(&wdt->wdtdev);
        if (ret < 0)
                dev_err(wdt->hw->dev,

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
