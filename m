Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565924;
	b=k+RM8rwpgQxsJDIbISDxF9W4AOVw/Qwrglw1ip99aRdcZ6CYHIXWYSyEbBYZvReqqMXK
	 bwIirW0zPH3g9Ae2RPY694wL+stGp93lgHvgjX8eVvD/4Cvhgd4YTd3gCyKV+nRGtVlqJ
	 SaCsMBsTKj9oxVfkxjYxuCx9KlhPaJEdKVCEsUh8RLjPWXPvClqcUfu+49o3M25bBNzby
	 cS3+/CZU5bKhe9oWEv9dK6p0YvhRB+hoLfwhBLnMTvUyVRrsgU3Ri7V5ybOBPbyDmghHO
	 jjtpfbGS4fAu71q1WxS6dFXp+alsVBPHablDecqEYqcF3JZT/49lpnPJw55rfmm7/bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565924;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=4CoDiCaTJN+LFxlwyURPQlkHoXPhaz72iTcURzvPQHU=;
	b=K9mnZPL+jUtG9D4QK60z7W2nbfki5G39IMIYB7vXmCiz7oAh+d1lZQnFji4rFfgsWnR1
	 085slwN5+pJQgRwn16/Qya8BQWkuhIBii6abh4XrZr3juFi/HbgMP5wMICgsEGLKNfqQ9
	 lONRVPlCuxCWuRQWkuSQPGsiIP+g3bw6O8N19c/CV4Mux8rSQoioN1Cdfy8/+dbWnAuwz
	 voQc8r5rf2kynjfYW/TY6fuqglYZOcfzIKMgfHJWQtkGj+2cBc2AuMTZRkiykMJYUVm3d
	 PWfHY/MrgM6fpadMMh3/DcfWmgeGy/391+Ag7zoNk7j7DZXShDpYNECAoxnvGm//AmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DvSQlGzQ;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F5606A31A;
	Wed, 21 Oct 2026 06:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DvSQlGzQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565924; x=1824101924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i07QuMRn/2JfcFy0JuCMmwxFwETBHdVXa2IAMSqe/48=;
  b=DvSQlGzQHaF2gS2vowBqFRYEkl0w/Q7LcHEHbOe/+YRD+GZXXq52LB/M
   3jiFExm1GHrpTyUHx9BwL+SUNhIxVScaWh6rowgTdphKw9BTF+qc3wV1m
   OCu0p4lwYCwcueKL0JZVbsdzhAcUiM1TjY27LWoRuJNhnFiaTJjQZSbSL
   KS5ohGuHGK9kzqnDp/Q9NpfPXbECxehA65apCUWq8yS8crHaSX7XYz9nG
   EskyxVIdbBm9xY+fbh2UJg3SBGqYbL1fqpHCGyA3tN7nAKqNH30QEfTJ7
   XAcHsbctjk6Z+4OO8+MEcBqrqUO6sjD1LAt+whzobf6BagOGFtnGcO3+m
   w==;
X-CSE-ConnectionGUID: +ImzHyDxRfSzdNpaG8LWIw==
X-CSE-MsgGUID: oQlBF+K0TE2TXrv22O8YDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1184182"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1184182"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:58:43 -0700
X-CSE-ConnectionGUID: S6AFesmrT1+KJSlx5aB2uw==
X-CSE-MsgGUID: +peAPlOLSZe1ssAQhB/ynQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2933131"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:58:35 -0700
Date: Wed, 21 Oct 2026 09:58:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <athimRqtDvQu1ZzA@ashevche-desk.local>
References: <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon>
 <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ateI-JcExDyfXKrs@red-moon>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> > On Mon, Oct 19, 2026 at 12:34 PM Lorenzo Pieralisi
> > <lpieralisi@kernel.org> wrote:

[...]

> > Basically, yes, the idea is to defer the creation of the platform
> > device until the dependency is met.
> > 
> > > till the dependencies are cleared but then, without a _CRS, where will
> > > the consumer driver find the platform device resources ?
> > 
> > Well, good question.
> > 
> > > There are multiple facets in this issue and possibly some of them have
> > > been already solved but I need to pull them together.
> > >
> > > > Note that the dependencies can be added to acpi_dep_list after
> > > > creating a struct acpi_device with acpi_add_single_object() and
> > > > acpi_scan_add_dep() is not really suitable for that, but it should be
> > > > doable if the dependencies can be found.
> > > >
> > > > > I need to have a deeper look into this next week but I wanted to ask first
> > > > > whether there was something I missed - most likely.
> > > >
> > > > Well, it is not really straightforward.
> > >
> > > Yes it is getting messy. This RFC, with all its flaws, does not transparently
> > > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > > dependencies - though it does so by adding more stuff into ACPI static fwnode
> > > that to be honest I'd rather see gone.
> > 
> > I think what you need is a notification mechanism that will trigger
> > when a specific device (enumerated via the ACPI Namespace) becomes
> > operational.  It doesn't look like any of the existing ones (platform
> > device probe deferral or ACPI device dependencies tracking) is really
> > suitable for your use case.
> 
> Yes. It might just be a notification from ACPI core to say "the driver for
> this ACPI device probed, go create platform devices that depends on it".
> 
> We can check and track the dependency in code that does create those
> devices today.
> 
> I will think about this to see how bad this might look like.

Don't we do something similar in drivers/acpi/x86/lpss.c?

> > > > I'm still not sure why you can't represent all devices in the ACPI
> > > > namespace in addition to describing some of them in static tables.  I
> > > > guess that would work for everybody, wouldn't it?
> > >
> > > That's a fair point - though then code will have to work with firmware
> > > that does NOT explicitly require those devices in the namespace (ie: firmware
> > > as it is specified _now_); it can turn out to be a mess even less
> > > manageable than this discussion ;-)
> > 
> > If it has to work under these conditions anyway, then adding stuff to
> > the namespace is rather pointless.
> 
> Yes that's the problem, reworking the code to make it work with namespace
> devices is doable the issue is existing firmware and that we can't change it
> (and we can't create it in the kernel either).

-- 
With Best Regards,
Andy Shevchenko


