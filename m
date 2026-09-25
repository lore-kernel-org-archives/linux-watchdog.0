Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A894486656;
	Fri, 25 Sep 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329804; cv=none; b=Zm3bIBOF29mZZiAUuQ/Xy/CE46wMunXEVaK3WeLYQkuj3L0B51zLAlhKTqBPGveb5PHcAvRSngIZTwUvEpmrx556Sn88J8VVEm+8lLdiaRnLmH9STfSa3GSGQTgc68IlqjVLODv2SFSTaXeCeSBV5EJzBtl8herK/4lukeW5XMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329804; c=relaxed/simple;
	bh=sjQO25DPF6I4YR81FfUFsr7AZEkXc7WRPqKWMV/gMyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwtWI4+YllbEhjoFfr93KFE7Tibh43ngjI3EmKLE+/k/FgO3ZSvUODc24R8i082SzefSKsknRM66SFBGZVvYyaYdY3OrqQXjNyiXMVZUqNQxx5MdhPag+wuom6cok/XzFOjw2RaUN9pCmOavnzJdfyePKesTX7Rq3wWmGF63pAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfwDOgND; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfwDOgND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790329802; x=1821865802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjQO25DPF6I4YR81FfUFsr7AZEkXc7WRPqKWMV/gMyM=;
  b=mfwDOgNDTu6fsfYWun5QcnlSnzvuM5qRrtOwdywwfvEG/WEfcqSWlDDM
   8sGCuRMxPpWChlmI0c8A4m6Px+EVtK0mWwNxHTIMTHn95iM806rCWDanV
   jP+88jas1pZAKOLOrK009NTfrbj4LmoO1/ubHDJ+n6uk/2ID2DovnC6rA
   KXqsUMYt9Ig9P5PQNSozgezr3jq12GSm3QCOBAMRtNvDpsjOjdX1tDpfc
   BwBlqnrkKblewQHtw2fVLHfdst1c26YqCFOY9mrQgptpaDjZbs6FV+qwh
   02rk7hDMh7kzUH96E5aYEIog1b0gGi2RtJS9LI1dj/Oy8WG0tkCRvAhZN
   w==;
X-CSE-ConnectionGUID: 8TGLQSQmRh2CtzxZSlDbgw==
X-CSE-MsgGUID: Ep6sfsxxT5Wl1AgmVcZ9/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90239315"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90239315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:50:01 -0700
X-CSE-ConnectionGUID: 9ntgpx47RhiHdVDXWx7L6A==
X-CSE-MsgGUID: 4KMb9J06Q0Cu0ER0QdxE1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273850092"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:49:57 -0700
Date: Fri, 25 Sep 2026 12:49:54 +0300
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
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <arZDwutoadki7tiZ@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> To describe and map GSIs for firmware nodes created out of ACPI static
> table entries in a uniform way it is required to define some standard
> properties and attach them to ACPI static fwnode as secondary nodes.
> 
> Define properties names to describe GSIs and their trigger-mode/polarity,
> and implement an irq_get() callback for static fwnodes so that core code
> can retrieve and map IRQs for ACPI static fwnodes in standard manner.
> 
> An empty stub for property_read_string_array() is also added, so that
> the fwnode_irq_get_byname() interface falls back (through
> fwnode_property_read_string_array()) to the secondary
> fwnode to grab the "interrupt-names" property.

> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---

Same here, please avoid polluting commit message with the Cc list.

...

> +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> +						  const char *propname,
> +						  unsigned int index, u32 *value)
> +{
> +	u32 *values;
> +	int ret, count;
> +
> +	count = fwnode_property_count_u32(fwnode, propname);
> +	if (count < 0)
> +		return count;
> +
> +	if (index >= count)
> +		return -ENOENT;
> +
> +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;
> +
> +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> +	if (!ret)
> +		*value = values[index];

Use standard pattern, id est

	if (ret)
		...

> +	kfree(values);

You want to use __free()

> +	return ret;
> +}

I believe the whole approach is suboptimal, if you wish get indexed value (but why?)
it needs to be retrieved as that in the guts of ACPI. Allocating memory for the whole
array to retrieve a single element is simply wrong.

...

> +#define ACPI_IRQ_PROP_GSI		"linux,acpi-gsi"
> +#define ACPI_IRQ_PROP_GSI_TRIGGER	"linux,acpi-gsi-trigger"
> +#define ACPI_IRQ_PROP_GSI_POLARITY	"linux,acpi-gsi-polarity"

Oh... This sounds like a big ugly hack.

-- 
With Best Regards,
Andy Shevchenko


