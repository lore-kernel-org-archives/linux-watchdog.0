Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E843EEAC2;
	Wed, 30 Sep 2026 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754058; cv=none; b=tdC0z6m71dmD9YNPXOROG80ldYONYEWPxC8D6LvrTuRgF5QC2TiWdrlNqPgZ5+IYaJg4whuFcJ/OegZaQkTDMp9I46hSTEKleaWlqniqN/Z9kZ5EJAZ57KA6WIsePCptE3m/1aiftSoSlZi2yCVRKABU0LDBU5EEluEbvoPiPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754058; c=relaxed/simple;
	bh=DB/gpgguVjDIuVwtjp6SLVEmPbEKy+QEiu2yF2ynW1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bztQ0jw0FYlwRi9DeCM0fqShsntGlD+eAllbqrB6hupzuc1ueJzhWehISoPtsTF3HVrjFsy/Pk9nNL6hGUVNXAzJAKhxGceByyjXyYAPE8BxlqWLHvoj3tPjQn1iTGM2bayb0iWj2g0sLg/r74teQmw5ginhout5rLIEhWwpEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHZjVW8o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHZjVW8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754056; x=1822290056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DB/gpgguVjDIuVwtjp6SLVEmPbEKy+QEiu2yF2ynW1A=;
  b=kHZjVW8oodDY6PItDfdr4PoRAluLD5yfIx0lWfsJ+8fcKN6gqFYbN9v+
   VjsmzAgsS8DmgrGs6t0wB5dQjWFwCY21B4tWFGRQ3BNrozhnwPae3mRQc
   C7+s9HUmUHlkPT8ps0JSkEGr0Iy+38OH/vZq9JlTPLzXvo1k92XnqkyQ1
   8++gtezw9Yh6AyWfOFTFnISgmjy0mqX2TKovAcDqLuTuJ1Xr2uXMnsk3R
   jtpgGtxNv/XYXAHHWNfuk9z493OsiGKzZyX8ggu76nvTFLYZHfgW2AgUI
   HOeDJ4Fo3K+/VuKSr3xVjWjYwcCHxwwrF0g3TtNa4PldR76DnFp4azG8E
   g==;
X-CSE-ConnectionGUID: n8MudpWdShWK3kVSiY6MjQ==
X-CSE-MsgGUID: kBGBOJ9FRnuG9hema3Gkrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95295666"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="95295666"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:40:55 -0700
X-CSE-ConnectionGUID: ypcLuiZ5TTK7EuilGWHtuw==
X-CSE-MsgGUID: w/Puch9LTca83ohyI/ylog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278960059"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:40:50 -0700
Date: Wed, 30 Sep 2026 10:40:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <ary9AGmVWDuez7Ax@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>
 <art5m5QPXAOAvkvW@red-moon>
 <arxZ7BAya5ntRi6t@hu-ashoraj-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arxZ7BAya5ntRi6t@hu-ashoraj-lv.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 05:38:04PM -0700, Ashok Raj wrote:
> On Tue, Sep 29, 2026 at 10:40:59AM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Sep 28, 2026 at 04:24:18PM -0700, Ashok Raj wrote:
> > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:

...

> > > > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_POLARITY,
> > > > +						index, &polarity);
> 
> For each of the above calls for read_u32_prop_index() the allocation,
> copy a value and does free it. 
> 
> Instead you could read the whole array, and just get each value and
> discard it once? 

This was my question as well. But I formulated it differently.

> > > > +	if (ret)
> > > > +		return ret == -ENOENT ? -ENXIO : ret;

-- 
With Best Regards,
Andy Shevchenko


