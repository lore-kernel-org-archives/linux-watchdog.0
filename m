Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbbK2LlV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Nov 2015 06:41:21 -0500
Date: Sun, 29 Nov 2015 12:41:11 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151129114111.GB10431@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
 <20151127100254.GR19888@pengutronix.de>
 <20151127104402.GT19888@pengutronix.de>
 <b09608aa29195b41fc114a414d67af0f@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b09608aa29195b41fc114a414d67af0f@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Harald,

On Sun, Nov 29, 2015 at 11:41:22AM +0100, Harald Geyer wrote:
> On 27.11.2015 11:44, Uwe Kleine-König wrote:
> >Hello Harald,
> >
> >On Fri, Nov 27, 2015 at 11:02:54AM +0100, Uwe Kleine-König wrote:
> >>On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> >>> Uwe Kleine-König writes:
> >>> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> >>> > > This device doesn't provide any information about boot status.
> >>> > > As workaround we use a persitent bit to track watchdog activity.
> >>> >
> >>> > Hmm, so you set a bit in a persistent register iff the watchdog is
> >>> > running.  And if that bit is set during probe you assume the
> >>watchdog
> >>> > reset the machine. But this also happens, when the user presses the
> >>> > reset button which makes the detection unreliable.
> >>>
> >>> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> >>> reset button causes the device to power cycle and thus clears the
> >>> persitent bit. So I can't test your case, but surely there are some
> >>paths
> >>> into reset, that don't clear the bit and cause false positives.
> >>
> >>OK, I found a i.MX28 machine in our repository:
> >>
> >>	barebox# mw 0x80056080 0xbabecafe
> >>	barebox# boot
> >>	...
> >>	linux# reboot
> >>	barebox# md 0x80056080+4
> >>	80056080: babecafe
> >>
> >>After a power cycle the value disappears (I didn't check the details, if
> >>there is a battery it might be empty).
> 
> Are there any concerns left on your side? Ie do you want me to do
> any additional tests before sending v4 of this patch with the
> whitespace changes and added URL to the freescale kernel?

I just notice that I failed to do the proper test. I.e. I reset the
machine using "reboot" instead of a reset button. But I'd expect that
doing the latter also keeps the value of the persistant register, which
would make your patch wrong here. I will check that tomorrow when I can
make someone do this test for me. (I'm 600 km from the machine above
away.)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
