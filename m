Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A048424D;
	Fri, 25 Sep 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330064; cv=none; b=fhkCjJ0taxSsjx+eLHIJ/KkoaeRRxnWisteoIUWFqfq9o76/DPZzLwcDswYZzj/+mDYzH8EJuhFnOZQmSBnc/Pw5L41diMYaAMSDipTfnmBZNj8PPBfzgICdpiv/OQ1I6Nx34JdMKUZ1Tc3DXAEB0mFjIwTXmvlQ3wqtrThvc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330064; c=relaxed/simple;
	bh=aJhvgsbYBkkTxrz9e8S/lyMN4dNTTNoAlaAJzf+q3Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxEzLMszS3eGC2MBAKMxvBSCeZMy/lFduTE2nKyIYDZjFUNawQwRcr7qct/sZ44xosx9kC2FvhOJrNOkozcQbHNkMB/+utHhT17edk5aaumGPQlXwwaTcrdCqAVAvniV66KZ7oExsJmOBqbe1ZYDVvo3AHspNOZrYy7LpzUF+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npDY0J8D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npDY0J8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790330063; x=1821866063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJhvgsbYBkkTxrz9e8S/lyMN4dNTTNoAlaAJzf+q3Ps=;
  b=npDY0J8DBK9uIwTBXZNeRou8V8xmVzPxHwxtwWGBqS1IVmNTxsckSLlm
   iO5urO6XmP04kvjEB9bC+fPDCu3GH/+cqVzBjJakgw3Aa9RPg0PyyhNPh
   zsJB+S2zmuL4+bY2qb9alBH/wMi6tRI4KgrelvSVmpkU0qVIZesU9RdjY
   iYo6o1yXJq2HpHlW1JRlfQ3QJfgPrNyUs7lPaTv+zJZle6rJ+b0kFrsLJ
   Vqd/9liyDUREp7aMj2LZoS1zztlEn1IDjQXTfzNOSN8Wp7p6woWysfRt5
   LY9Vh2elEfC/YKqivDl3oK4++kUd22eFdvKpuXp44xqh2pc/d7SQuljSa
   Q==;
X-CSE-ConnectionGUID: GwwOsx50RL6yKHBOLoBkmA==
X-CSE-MsgGUID: xkffvacvQxG0/rLClfSK9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101286660"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101286660"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:54:22 -0700
X-CSE-ConnectionGUID: LGW9EsPVR0isVUO96e4kkA==
X-CSE-MsgGUID: 4MntE1JoRG6EoE5n75P90w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="274386881"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:54:18 -0700
Date: Fri, 25 Sep 2026 12:54:15 +0300
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
Subject: Re: [PATCH RFC 03/11] driver core: platform: Add static ACPI nodes
 IRQ retrieval/mapping code
Message-ID: <arZEx0113s0bbkXJ@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 09:48:02AM +0200, Lorenzo Pieralisi wrote:
> ACPI static fwnodes types are not contemplated in the current
> 
> platform_get_irq_affinity()
> 
> implementation that is there to retrieve and map IRQs for a device.
> 
> Add fwnode_irq_get() to platform_get_irq_affinity() for static ACPI fwnodes
> to overcome this shortcoming, enabling IRQ retrieval and mapping for the
> ACPI static fwnode type.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> ---

Same about the Cc list...

...

> +	if (is_acpi_static_node(fwnode)) {
> +		ret = fwnode_irq_get(fwnode, num);
> +		if (ret > 0 || ret == -EPROBE_DEFER)
> +			goto out;
> +	}

This even doesn't sound right. If you know this is an ACPI-only feature what
the fwnode has all to do with it? Call the respective ACPI-oriented function.

-- 
With Best Regards,
Andy Shevchenko


