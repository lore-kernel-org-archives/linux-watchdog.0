Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AC2E7165;
	Fri, 25 Sep 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330222; cv=none; b=r6b1rvjp4uXwxlopfvoQnjsjTOzQVhqnMbbF64ISuiGFUhPW+Mvdnk/Jw0/tKViK4PgarPrLTul5rMMBt6CZmV4IXI7s3u4Me8DT7JXgxbU999+VGUkT7QxPHFYapfJmeE+ZjJvT9+ES9WMtzec+KtFfwRE/iZeqJSeE6HE+VyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330222; c=relaxed/simple;
	bh=RFkzEkH/pTrprYA0V564zxkPwGY1QFaLSdmuR9IK8tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM9dY7PHzF5gcpQZz5Q4wXqvZL+PwnupfhkWHJakkF9pziOdCCxQaPrAYdi3TmiSarIE/XY91rH5Rh0CVNSaw41X7fhe1kyStf/PN/ZOmT9guIERX45DYNJT3hBTL4OFSqjmz8tkfFxDaWXolZAqFlMNfUvYA2RIVFDH+5lrcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrbXD5eU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrbXD5eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790330221; x=1821866221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFkzEkH/pTrprYA0V564zxkPwGY1QFaLSdmuR9IK8tg=;
  b=WrbXD5eUwFbFZsIPlS7qwb3VVINmS6xSfh40IHXJ7ToQsm0cacMragvL
   QXo5PTSt8ECu8oNSHad5uNOIA5I0NoXKfQE3fM2IEvJnO3WFQQ8SZARZi
   W8TmHIDi27KsP3pfqeZu5hZAc21ARlgtqPt1LWHqJOjvg3SmmvvJpP6ls
   Fa/49Ubzm4kD27PZLMS5LxJwyt6D1ARpcXXoPyVhpAysNyqYR63LF0pN4
   wN+Gyx1NGq8TRopvK9pY8yjUOXS5K2VYiUQZ4VMyEKLtZSR1ET00acu2T
   PUTXwy/H9YXIcBPkUjELm3ClTrsbHu1SIYxer/sCDkX2hmWTtHX0/tR05
   A==;
X-CSE-ConnectionGUID: NzTHglFjQ429gPWwl9m84Q==
X-CSE-MsgGUID: 84iPzlHERcu5kdmHzwFAAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101640317"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101640317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:57:01 -0700
X-CSE-ConnectionGUID: iuXnh6rdSPysbnNxiqRMHw==
X-CSE-MsgGUID: 1dKCGk7BS4CQlO0D0rpNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="270769027"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:56:56 -0700
Date: Fri, 25 Sep 2026 12:56:53 +0300
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
Subject: Re: [PATCH RFC 06/11] ACPI: GTDT: Convert SBSA watchdog to IRQ
 properties
Message-ID: <arZFZf0p30jEHGsD@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-6-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-6-2c62125d0085@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 09:48:05AM +0200, Lorenzo Pieralisi wrote:
> SBSA watchdog IRQs might be wired to interrupt controllers that are
> probed after the SBSA watchdog is probed and therefore the IRQ mappings
> cannot be carried out at platform device creation but deferred to
> SBSA watchdog probing through the platform_get_irq*() set of APIs.
> 
> To do that, stash the GSI number, trigger, polarity into standard
> properties attached to a software node that is attached to the
> platform device ACPI static fwnode, allowing the SBSA driver to
> retrieve those properties and map the IRQ when the SBSA driver
> is probed.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---

Same about the Cc list...

...

>  	struct resource res[] = {
>  		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
>  		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
> -		{},

Side note, even in the old code the last entry should be rather DEFINE_RES().
Because some APIs, such as resource_size() will not work on an 'empty'
resource.

>  	};

-- 
With Best Regards,
Andy Shevchenko


