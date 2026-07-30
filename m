Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22535F60F;
	Thu, 30 Jul 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389075; cv=none; b=EFZtqp03hW+FrjrdrCus0pFCjzfgzxDuDrhoMvySkLdIDILyoUdFFVgPJSVXGgWA+4woJ2Gwgmw38jcSu9kTugv9co25iDPwAw9aHOrnKLO0blwBwFCD3ZKnwvrseOp8Tn2FTQxgPsSN+w2KGYl/Q+FuTnb41jOoiE6d9Gb4hmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389075; c=relaxed/simple;
	bh=1DMuGx8VV1yF9PYUAM0K7yn25rsOtJAy0VjBYUuI1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4nbWdk+ZnwmILQxMlfYXdNdcdJ2otoTd+nDHZVn515Lo5OBanbgpB2YRlyEg3E3oiIlh0ZU2C5Qo7t9Vbo5snoUBH8/pS2PaaRCHmAICzdoJt3NCuqfaNsXTByEdXFEyl/MfQ5hHKF5gLEMAdYT0NAmo5EyEpCsydAqMD3e2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 73CC8202B53;
	Thu, 30 Jul 2026 07:24:28 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wpJFs-001zo8-1D;
	Thu, 30 Jul 2026 07:24:28 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wpJFs-0000000EyYP-0yzJ;
	Thu, 30 Jul 2026 07:24:28 +0200
Date: Thu, 30 Jul 2026 07:24:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
	kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	avaneesh.dwivedi@oss.qualcomm.com,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
Message-ID: <amrgDC0s3rb5Xv4N@pengutronix.de>
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
 <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Matti,

On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
> On 22/07/2026 18:13, Faruque Ansari wrote:
> > Watchdog pretimeout resets are not recorded with a dedicated reset
> > reason, causing subsequent boots to report PSCR_UNKNOWN and making it
> > difficult to distinguish them from other unexpected resets.
> > 
> > Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
> > prevent the panic notifier from overwriting a watchdog pretimeout
> > reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
> > panic.
> > 
> > Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> > ---
> >   drivers/power/reset/pscrr.c           | 7 ++++++-
> >   include/linux/power/power_on_reason.h | 1 +
> >   include/linux/reboot.h                | 1 +
> >   kernel/reboot.c                       | 1 +
> >   4 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
> > index b5906f127e88..5b107c62fe82 100644
> > --- a/drivers/power/reset/pscrr.c
> > +++ b/drivers/power/reset/pscrr.c
> > @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
> >   	if (!backend || !backend->ops || !backend->ops->write_reason)
> >   		return NOTIFY_OK;
> > -	set_psc_reason(PSCR_KERNEL_PANIC);
> > +	/*
> > +	 * Do not overwrite a previously recorded watchdog pretimeout reason
> > +	 * during panic handling.
> > +	 */
> > +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
> > +		set_psc_reason(PSCR_KERNEL_PANIC);
> 
> Hi Faruque,
> 
> I like the idea of adding WDG pretimeout resets in pscrr. I am just
> wondering what makes WDG reason so special, that it shouldn't be overwritten
> while other reasons can be? Can this notifier be called (now or in the
> future) so, that there are other reasons getting overwritten? For some
> reason I think the PSCRR was designed to be able to store multiple
> reasons(?)

It depends on the backed. A simple nvmem cell, would be able to hold
only one reason.

> Could you just add one more instead of overwriting existing - or
> should the check be more generic (to ensure the reason is only set if there
> is nothing to overwrite).

So, depending on the backed, we will have different policies. For
example, with one slot storage, we need to decided what to store:
first one or the last one.

In most cases, the initial one is most interesting. But, if we are
debugging system reset/reboot behavior, the last one.

> 
> If I am just completely lost (which happens), could you then improve the
> comment a bit to explain why WDG timeout is special and shouldn't be
> overwritten. The checking code itself is quite self-explatonary ;)

Good question. I included this patch to my refactoring, but didn't had
strong opinion haw to handle it. I guess, after introducing record
policy, this issue will be partially addressed:

https://github.com/olerem/linux-2.6/blob/v7.2/topic/pscr/Documentation/ABI/testing/sysfs-kernel-pscrr#L95

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
