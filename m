Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B54EE870;
	Tue, 29 Sep 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672996; cv=none; b=QAYbJ8CTTe1mbjTNevwGtkgDxpC8RcXxPsF00AZuF4zjLJpSJYOmQNxZE47qHUbEjNWpNLk+ubaL75cxVIR26MQfRWhAA5+RC5lsWSAbqydMeIHRY6eoP0bTIcOICTEc7p6tNJhxiVKRr93/Z2oKT0UJZ6gioi6eML1Sx+JAtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672996; c=relaxed/simple;
	bh=8mzJMuYnCZhwEUtOPURxgai+um9p342VMKrcalXHD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX8+xVR753czbRH3gZ/92zer73KkNp6KPEijoFnqPDBQ8G0u+BbMA/sPOfmr1YnDGhO9xcUoey8TKA1xwYenFP7cYuv5fxEy1s2saCl+yiFf/eEaFu5Oyv8EAPyaBOdztDb7COADEnqNiFZLXw0clCPWZ+hOiYB5XMQzTxzunes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXcx7SNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXcx7SNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1961F000FF;
	Tue, 29 Sep 2026 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672966;
	bh=8RZPTKPYsJ7ehSZN0cEyUcCpUIIf50m3MLfGHEEySK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXcx7SNtcRZraihmeOkqs1mmi1+GwxckUUL+tQgEGJJa/2Gpv7+0C/2+bZR+gFxT9
	 1Ax5poPavEVLKsO+QEDmVgPM9tjBXnOuNoHXkYvCPFT3UTQ3iI6fYcsW92ZXAx3Ylz
	 gD3mfo5GvbmNaHhDg5TpDUI7D1Y/GvQgRse6iWSYRhy2qtCkMS9iExIxd/YDD/XyEA
	 fBmUC+mjy5X9SszrutIuMG9FlVKs6/j4W01p2aGfdxVI99+P52AzyHTDnsIixrLFDa
	 dUw/189D311DYoR0oC66FcHqy1mDqDastxwjG+F4+CqCGWcGlBJEeVM7oARRP0Ps9A
	 juGHuxyU1me8A==
Date: Tue, 29 Sep 2026 11:09:23 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 08/11] watchdog: sbsa: Handle IRQ probe deferral
Message-ID: <aruAQ0qOGU6W2NhS@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-8-2c62125d0085@kernel.org>
 <20260925075726.B0A6B1F000FF@smtp.kernel.org>
 <d9102e7e-a69a-4ad5-aa38-c2cbd9d98496@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9102e7e-a69a-4ad5-aa38-c2cbd9d98496@roeck-us.net>

On Fri, Sep 25, 2026 at 06:46:31AM -0700, Guenter Roeck wrote:
> On Fri, Sep 25, 2026 at 07:57:26AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] watchdog: sbsa: system reset due to unserviced watchdog on probe defer
> > --
> > 
> > commit 82d6b6d0cf8ddd44758931db5360cd8439795f6f
> > Author: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > 
> > watchdog: sbsa: Handle IRQ probe deferral
> > 
> > This commit handles probe deferral when mapping the IRQ for the SBSA watchdog
> > by returning -EPROBE_DEFER.
> > 
> > > diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> > > index e04d42cc7774d..f4491409caf5d 100644
> > > --- a/drivers/watchdog/sbsa_gwdt.c
> > > +++ b/drivers/watchdog/sbsa_gwdt.c
> > > @@ -352,6 +352,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
> > >  
> > >  	if (action) {
> > >  		irq = platform_get_irq(pdev, 0);
> > > +		if (irq == -EPROBE_DEFER)
> > > +			return dev_err_probe(dev, irq, "failed to get ws0 interrupt\n");
> > 
> > [Severity: High]
> > Does returning here during probe deferral risk an unintended system reset?
> > 
> > If the bootloader leaves the SBSA hardware watchdog running, the driver
> > correctly detects this via status & SBSA_GWDT_WCS_EN and sets
> > WDOG_HW_RUNNING.
> > 
> > Because we abort probe registration here, the core remains unaware of the
> > device and will not ping it.  If the deferral period exceeds the hardware
> > watchdog timeout, won't it expire and trigger a reset?
> > 
> > Previously, if platform_get_irq() returned -EPROBE_DEFER, the driver fell
> > back to single-stage mode (action = 0), and successfully registered the
> > watchdog, allowing the core to immediately start servicing it.
> > 
> Looks like a valid concern to me.

Right. Just to understand the issue (forgive me the stupid question), isn't
there a time window where this can happen then even without IRQ probe deferral
taken into account ?

What's the best course of action then ? Ignore -EPROBE_DEFER and treat it
as failure (basically, dropping this patch ?) ?

Thanks,
Lorenzo

> 
> Guenter
> 
> > >  		if (irq < 0) {
> > >  			action = 0;
> > >  			dev_warn(dev, "unable to get ws0 interrupt.\n");
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=8
> > 
