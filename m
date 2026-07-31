Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD721F099C;
	Fri, 31 Jul 2026 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475643; cv=none; b=BQrUE5Lr3cBgUVGmMx4MzlEhMVcCAY6sLkEdkKKPpy2TF2Tw7QCgYcrKwNkQBt9or3PmXIql47Nmgz8VsNVPO1RjFBniYUb1j9XP9ZawAwi0DKMB9MXRArOIIC95ihOoChak7ZZ259U6l863KVAtGFLI+C9ZqxscCdugFU00vVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475643; c=relaxed/simple;
	bh=Taq9Emffc0JgQctjUF0f/fjJSkYr1mCfvGtn95VqwtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovkM0ze9hu3sZWdyGdOgvzyNr0Xn5IuY6sDqSVqIiPe0WcpY4/2VLEjMJaSYmV31KWHIIFMKlcN1VKzYwGeAUtlsgkA83ttrB9HU9IjhlM5KFujWadLq5aaF/KOgvLmCzqbxROwkHmveRIBxvAvs0Dub7CK5W8EFrzml0CJdxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B238C2021B4;
	Fri, 31 Jul 2026 07:27:14 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wpfm6-0029vM-23;
	Fri, 31 Jul 2026 07:27:14 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wpfm6-0000000HXxW-1z7w;
	Fri, 31 Jul 2026 07:27:14 +0200
Date: Fri, 31 Jul 2026 07:27:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
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
Message-ID: <amwyMsvA9Q3_1aw1@pengutronix.de>
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
 <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
 <amrgDC0s3rb5Xv4N@pengutronix.de>
 <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Thu, Jul 30, 2026 at 08:02:35AM -0700, Guenter Roeck wrote:
> On 7/29/26 22:24, Oleksij Rempel wrote:
> > Hi Matti,
> > 
> > On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
> > > On 22/07/2026 18:13, Faruque Ansari wrote:
> > > > Watchdog pretimeout resets are not recorded with a dedicated reset
> > > > reason, causing subsequent boots to report PSCR_UNKNOWN and making it
> > > > difficult to distinguish them from other unexpected resets.
> > > > 
> > > > Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
> > > > prevent the panic notifier from overwriting a watchdog pretimeout
> > > > reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
> > > > panic.
> > > > 
> > > > Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> > > > ---
> > > >    drivers/power/reset/pscrr.c           | 7 ++++++-
> > > >    include/linux/power/power_on_reason.h | 1 +
> > > >    include/linux/reboot.h                | 1 +
> > > >    kernel/reboot.c                       | 1 +
> > > >    4 files changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
> > > > index b5906f127e88..5b107c62fe82 100644
> > > > --- a/drivers/power/reset/pscrr.c
> > > > +++ b/drivers/power/reset/pscrr.c
> > > > @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
> > > >    	if (!backend || !backend->ops || !backend->ops->write_reason)
> > > >    		return NOTIFY_OK;
> > > > -	set_psc_reason(PSCR_KERNEL_PANIC);
> > > > +	/*
> > > > +	 * Do not overwrite a previously recorded watchdog pretimeout reason
> > > > +	 * during panic handling.
> > > > +	 */
> > > > +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
> > > > +		set_psc_reason(PSCR_KERNEL_PANIC);
> > > 
> > > Hi Faruque,
> > > 
> > > I like the idea of adding WDG pretimeout resets in pscrr. I am just
> > > wondering what makes WDG reason so special, that it shouldn't be overwritten
> > > while other reasons can be? Can this notifier be called (now or in the
> > > future) so, that there are other reasons getting overwritten? For some
> > > reason I think the PSCRR was designed to be able to store multiple
> > > reasons(?)
> > 
> > It depends on the backed. A simple nvmem cell, would be able to hold
> > only one reason.
> > 
> 
> That makes me wonder: Shouldn't the priority be a back-end decision, not a
> front-end decision ?

Backend provides capabilities, most nvmem cells will be able to store
only one record. Which record matters (first or last) is a
use/investigation case specific policy. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
