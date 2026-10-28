Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195587;
	b=fyipsKlzKF25ZXh089AFtwxpKcz3uXD0OxU8jKNFxYPe+AzdJtcF2K/BeBfWBzsf0jBi
	 c3Ig3xYjr+DsjtYopND85pnUMGVchoG1HsmC+4NvKkjczAFrnAq9daWs2Nxv+NI6OWYVi
	 RR7am3Zy825EIET1RqF1ulVbf5MIuG1SZk5J6x9pgD4h6t1kzYoSYtWXvfdkKMrqYhN1+
	 LZj/QQ9kmlepfBIsL+KUesKzjVU5I5mst5w+5PUaks2jA59cnoGdMnMxZ51vWx3xG4Xsz
	 TfBbjrYg//EKOeKS6yj3ENaFJ9Hqghh/7wFiwGlfJN0tAlTRAvgCTTJSlnhOd0PL8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195587;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SxymvfAlNS0X8/xbI9/XRQHmV9LZfSmga4dSHsFV4Hk=;
	b=ZpPkASvwxPkkIeacxEZaSRCbDTpwHXSV51HjTTSSnFzNuOyMKJNOPdyzLjWDezren5Ji
	 2T88+LuzFWgNnPHWLJyGP6Iy9o21jKjMy8+YWa49HkqsNsAU12eIlku0sl2/Qxc5VjlQR
	 bOar2TlZMfqNEdyz+nQ5R5AKbNMHVsBeN2uzk3SEcpFk1TotNxhMZAqbFI4nIVtQbCV0I
	 7V2TiWYH7a/pzpDUpjAYSht1ozTBjWieb15CoWXZPkznplCyPjS0N/iBNQqL39jBb/xGD
	 XSuOwYU2CzZwgx9pM9j8s/gkXFEJJ6Zg446g0lRhuM79HR87zR39uVRnlBfWH6YeX9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AjWDTT3c;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875C606A320;
	Wed, 28 Oct 2026 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4875C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AjWDTT3c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793195586; x=1824731586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+0hcYzDXE2GYoXsQ0MP6klFZxsUOFBht4tZhtoGv83o=;
  b=AjWDTT3cAd77LTPUBK9Lgxpr1UsgmakAvb78kRlJDC+QFofEsRm6Vglw
   YIsO3n2legf6TUD5/gcZv2EZGJ14Y8+HOCq8llRtfR38XyT1AHe5LDCqI
   sti7ZHrzkA+wH2pUi/J4rmglx+DWN/tXyK6CpRZ+xCBR94Qqj5LTC2CVk
   24tfsoOhBl+vcaEHm0LymA937cp3XsY25KLp9MovgJF1gvVLTDSsDYzZS
   elCy78OpKmLkolwL/Ons3+0wnJUrPygvQweDPVri1s81pgy+N9PTsog9W
   MpLVPwtBgB9yyTI9wHLlhavJk3o6gKcu2CyEuz1lpG+cuy5V0u6GzefVA
   Q==;
X-CSE-ConnectionGUID: 3/DC+L49QfGjI6HeEqK0fg==
X-CSE-MsgGUID: V6ExW2teTam+90kURm11pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1904406"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1904406"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:53:06 -0700
X-CSE-ConnectionGUID: emGC5Cc7RHmxfp5uMqR2QA==
X-CSE-MsgGUID: l+3uM1XCTVevg1M65njuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6618376"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:53:03 -0700
Date: Wed, 28 Oct 2026 15:52:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
	wim@linux-watchdog.org, linux@roeck-us.net, ulf.hansson@linaro.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 4/4] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
Message-ID: <auH-O0LwqdmgzrQf@ashevche-desk.local>
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
 <20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com>
 <auC7FueGYTiLOpcX@black.igk.intel.com>
 <0602847f-4fef-49b6-a1eb-3240d7c1ecbc@tuxon.dev>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0602847f-4fef-49b6-a1eb-3240d7c1ecbc@tuxon.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 02:45:15PM +0200, claudiu beznea wrote:
> On 10/27/26 16:54, Andy Shevchenko wrote:
> > On Tue, Oct 15, 2024 at 07:47:32PM +0300, Claudiu wrote:

...

> > > Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> > > context'") dropped the pm_runtime_get_sync() and replaced it with
> > > clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
> > > in genpd_runtime_resume() being called from atomic context. But
> > > clk_prepare_enable() doesn't fit for this either (as reported by
> > > Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
> > > wait context warning as it is not written for this).
> > 
> > > Because the watchdog device is marked now as IRQ safe (though this patch)
> > 
> > ...which is complete hack and has to be avoided.
> > 
> > Can it be solved differently?
> 
> Can't tell ATM. This solution was suggested by Ulf.

With all respect to Ulf, this is a bad idea. We need to get rid of
pm_runtime_irq_safe() sooner and avoid adding new users of this hack.

> > (Note, OMAP, for example, got patches in the past
> > and become pm_runtime_irq_safe()-free.)
> 
> I'll look through it.

Thank you!

> > > the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
> > > 1 for devices not registering an IRQ safe PM domain for watchdog (as the
> > > watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
> > > always-on), this being the case for RZ/G3S with old device trees and
> > > the rest of the SoCs that use this driver, we can now drop also the
> > > clk_prepare_enable() calls in restart handler and rely on
> > > pm_runtime_resume_and_get().
> > 
> > > Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
> > > watchdog restart handler.

-- 
With Best Regards,
Andy Shevchenko


