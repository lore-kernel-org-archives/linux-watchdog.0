Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112862;
	b=YmbuHCnn5SRamCnobq5RvDu2JyaDhsSXwrXdwKWdNjiV+QS6ctvXM4a3qEQMLGi+Mj5Q
	 i6z7hhtlNTkm4iNTgbGAQP9mpfgM92VfUB0CFJdEBoVutkquZyvQk5U/5RDJ8srd4b0h7
	 Ic+5hn7JfHOiFGdmSPJ1XLF50YO7cPTOZHktHNjipZKMCPmjhJwk1o9MngZwhn0dSK4Cq
	 CNpWhay2aXf7V4mlgFDVR7ilTMzA1DInT3hqHwOYtRwbxrnRHgnDhq6y647ujFEizP2eL
	 Lqtu+fnqm1/RxPuwqkH3o+tcJR6VJI045ZjRUBmHfMBGDDnKc3w4p/LzmWEwwbgdU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112862;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=drjGRceIeL5IL0/jScIksKQXB09x2n9Ob+ocw8bnBSQ=;
	b=KOE5QXCPxKrU6gB3H5Wb5peaLGGHGTwzV7rc4nc5nSu5kxVKEbMDs+BApjODw8Pdogsx
	 GRThGl3/unzUh+6bDMsqkPJvX5dhWG13vkArhpbPNUUSQh9kBZLAl1cg0vj9R6y9Z3waj
	 qhHnHmOYjy9RhEa+JF1pxNmu6Zqyoj+kMeYfSbZAoeANX65XKLK/0mXk0efny7KLQ7zwH
	 bwJZfNZcmGnNjUNwnN+LOiZVSnL69PpjUeju1saf1ec+Okaq5Iug3OBUSMYQgCA874XV+
	 61py6v6lvTt4FNJckLB6OhuaAq1thj4CNNeuUvwUtj6QoCnPq2xg/f8t94ImQUKz3gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PDLzOs7E;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFF606A31A;
	Tue, 27 Oct 2026 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBFF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PDLzOs7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793112859; x=1824648859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=564R5L/s9e7QaTQoXzeTsd4/Uu6V7rRK/SgftrA0Be4=;
  b=PDLzOs7EkqzQ/3vH58vm4pjXZOQr4Y2pJNHfpImpxH1bIexI2N/njivH
   ydjo1XdV0zpHwHBXdjK1pUZ3Ch0Gb/AYqwStQNi16Ug5Xri8lW6B1lxuQ
   ktUsE15LpV2vDNE/jHuNcOx4hJTaalOiumCkTVXkmina/ZqK0P6SL7vE9
   K+xFmrIDY9oMgBOTFINPi+Vav3bJ3Ow0yoPZx57G9d7KFeeCeaEElzud3
   lZLPbEgIJPIiUdAr89Bq5BZ326MveK8hj0XGrCMhdY6LC22yGNhw+dO4O
   cOjuhLunk0fS3h7ZvVdPzYvax66QjfdDJN+tVKx17VeCU8b0z4Yx0IqKz
   g==;
X-CSE-ConnectionGUID: OIWSLpF2Qr2X0SyCChTKhA==
X-CSE-MsgGUID: H4HGyc7JQ52RMIX0HYjTHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1700776"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1700776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:54:19 -0700
X-CSE-ConnectionGUID: C4Hm2Yx3Shuq+3RZTBIOUw==
X-CSE-MsgGUID: fHlgwa/0TbO1gh0n183pbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4944208"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 07:54:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D579A99; Tue, 27 Oct 2026 15:54:14 +0100 (CET)
Date: Tue, 27 Oct 2026 15:54:14 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
	wim@linux-watchdog.org, linux@roeck-us.net, ulf.hansson@linaro.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 4/4] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
Message-ID: <auC7FueGYTiLOpcX@black.igk.intel.com>
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
 <20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com>
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
In-Reply-To: <20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 15, 2024 at 07:47:32PM +0300, Claudiu wrote:
> 
> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
> this case, the watchdog device need to be powered on in
> struct watchdog_ops::restart API. This can be done though
> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
> watchdog device though pm_runtime_irq_safe().
> 
> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") pm_runtime_get_sync() was used in watchdog restart handler
> (which is similar to pm_runtime_resume_and_get() except the later one
> handles the runtime resume errors).
> 
> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") dropped the pm_runtime_get_sync() and replaced it with
> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
> in genpd_runtime_resume() being called from atomic context. But
> clk_prepare_enable() doesn't fit for this either (as reported by
> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
> wait context warning as it is not written for this).

> Because the watchdog device is marked now as IRQ safe (though this patch)

...which is complete hack and has to be avoided.

Can it be solved differently? (Note, OMAP, for example, got patches in the past
and become pm_runtime_irq_safe()-free.)

> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
> always-on), this being the case for RZ/G3S with old device trees and
> the rest of the SoCs that use this driver, we can now drop also the
> clk_prepare_enable() calls in restart handler and rely on
> pm_runtime_resume_and_get().

> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
> watchdog restart handler.

-- 
With Best Regards,
Andy Shevchenko


