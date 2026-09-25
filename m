Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21D488227;
	Fri, 25 Sep 2026 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329523; cv=none; b=JMjlUCK8uaRmvRAD6BiwA+W9MzmodRpxxp9o4IJgnybNiyTuxqTCPyc+qst0DutyjM/znY38Z9MNHStDanrRBHK5G+7cpQULbzoqsCN4pKCvhxkyObFGvN4ZjLGgWzzuDEKao3DO+2Sk1+Mda445X4CM3WGwNfRIGauTv1kSORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329523; c=relaxed/simple;
	bh=u03sCXgRX7pcyePoPYi95dX0Tff82Nq1OTABJ1meNc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQNacCrx/RolKWkLHFkeCaeofkkSWmT5J3TMNlkiY4WeagTPmkZ0Gi26GIQJ9FCoihD6g4CCI+5Rc9G0ci4gqNR19c4H3etxbPaWRQDu7zbzHu4dzO5XdhFr35NWy22nT/7PRtbUnE4Uly120W+4xw6rY6cWL/Ve7tuHqsf1p+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1nmoBxH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1nmoBxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790329521; x=1821865521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u03sCXgRX7pcyePoPYi95dX0Tff82Nq1OTABJ1meNc0=;
  b=f1nmoBxH6kK+qiwur8BkUgvRtWP2QTgTaa6cX7eRhpsRVmy1PMwsfV6U
   3ZbahELlgc0V68L3EjGaOT5tU75kXCXuomYRKRQ5pjcz2gEslAVkTHUn1
   wP1SGsfRR5k0FxmwmJuUuRf/SJVVd0ubp7R0tBX6SRgJKQ1yMIDlMmgo/
   721kW4+7dyUHeCKVtBuGOVtVChnDcbYMo5VyAAYuMxIX/3HTuqxZfr5A0
   /lVRnZZFPOxMrCQRsEIdqdGSu80lgnZs1PuAKy3VHNKdOO7ZOhQ64S0b6
   5Pc7sAts5NWVO6YJUkejnYXFdTZl2es0DlkZDi+xaOtzUCDTclS6ngLmg
   Q==;
X-CSE-ConnectionGUID: 7o7ZgGCVRl++1vGNaEIW1w==
X-CSE-MsgGUID: Q/HoOFrGQ2iBfirJ1SFEGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90019980"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90019980"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:45:20 -0700
X-CSE-ConnectionGUID: wdn0TnkBRpSrePz8THZskQ==
X-CSE-MsgGUID: lcRbf3LGT5+3e3PDRzZSIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="277458396"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:45:15 -0700
Date: Fri, 25 Sep 2026 12:45:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 01/11] ACPI: irq: Return -EPROBE_DEFER on missing IRQ
 domain
Message-ID: <arZCqRJHaCp-pgWI@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-1-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-1-2c62125d0085@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 09:48:00AM +0200, Lorenzo Pieralisi wrote:
> acpi_register_gsi() might fail if the IRQ domain a GSI belongs to has
> not been registered yet by the respective interrupt controller driver.
> 
> Return -EPROBE_DEFER in this case so that the mapping can be retried
> later by deferring the probe for the driver that requested the IRQ
> mapping.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>

You may keep the Cc list under the '---' cutter, so this noise won't make
the commit message. The email will be still send to the respective people
and someone can harvest it in the lore archive if needed in the future
(when commit gets accepted).

Note, you may keep that part in your local Git tree (in the commit message)
and handle with `b4 trailers`.

> ---

-- 
With Best Regards,
Andy Shevchenko


